//
//  LoginViewMModel.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 20/01/2024.
//

import Foundation
import Combine
import KeychainAccess

class InitialViewModel {
     var guest: Guest!
     var errorMessage: String?
    var didLogin: Binding<Bool>
    
    init(didLogin: Binding<Bool>) {
        self.didLogin = didLogin
    }

    let baseURLString = Constants.Urls.baseURL
    let apiEndPoint: ApiEndPoints = .guestToken
    private var method: HTTPMethod = .post
    
    private var cancellables: Set<AnyCancellable> = []
    private var fetchDataSubject = PassthroughSubject<Guest, Error>()
    var fetchDataPublisher: AnyPublisher<Guest, Error> {
        return fetchDataSubject.eraseToAnyPublisher()
    }
    func fetchPosts()  {
        Task.detached {
            do {
               
                // Convert the parameters to JSON data
                let parameters: [String: Any] = [
                    "secret_key": Constants.Urls.secretKey,
                    "device_type": Constants.Urls.deviceType,
                    "device_id": Constants.Urls.devicId,
                    "push_token": ""
                ]
                guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
                    fatalError("Failed to convert parameters to JSON data")
                }
                
                if let baseURL = URL(string: self.baseURLString), let url = URL(string: self.apiEndPoint.path, relativeTo: baseURL) {
                    var request = URLRequest(url: url)
                    request.httpMethod = self.method.rawValue
                    request.httpBody = jsonData
                    request.allHTTPHeaderFields = Constants.Urls.header
                    do {
                        let fetchedPosts: Guest = try await NetworkManager.fetchData(from: request)
                        
                        self.guest = fetchedPosts
                        if let token = self.guest.token {
                            do {
                                try Keychain(service: Constants.Urls.keyChainKey).set(token, key: "authToken")
                                let userId = try await self.loginWithToken(token: token)
                                Constants.Urls.userId = userId
                                self.didLogin.value = true
                            } catch {
                                print("Error saving token to keychain: \(error)")
                            }
                            
                        }
                        self.fetchDataSubject.send(fetchedPosts)
                        await MainActor.run { self.guest = fetchedPosts }
                        
                    } catch {
                        // Handle the error
                        print("Error: \(error)")
                    }
                    
                    
                    
                } else {
                    // Handle the case where the URL couldn't be created (e.g., invalid baseURL or ApiEndPoints path)
                    print("Error: Unable to create URL")
                }
                
                
                // Handle the result
            } catch {
                // Ensure UI updates on the main thread
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                self.fetchDataSubject.send(completion: .failure(error))
                
            }
        }
    }
    
    private func loginWithToken(token: String) async throws -> Int {
        let APIEndpoint: ApiEndPoints = .login
        let parameters: [String: Any] = [
            "device_id": Constants.Urls.devicId,
            "device_type": Constants.Urls.deviceType,
            "login_type": Constants.Urls.loginType
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            fatalError("Failed to convert parameters to JSON data")
        }

        if let baseURL = URL(string: Constants.Urls.baseURL), let url = URL(string: APIEndpoint.path, relativeTo: baseURL) {
            var request = URLRequest(url: url)
            request.httpMethod = self.method.rawValue
            request.httpBody = jsonData
            request.allHTTPHeaderFields = Constants.Urls.header

            // Add the token to the Authorization header
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

            do {
                // Assuming the login API response contains the user ID
                let response: LoginResponse = try await NetworkManager.fetchData(from: request)
                let userId = response.user.id

                return userId
            } catch {
                throw error
            }
        } else {
            throw APIError.unknownError("urlCreationFailed")
        }
    }

}

