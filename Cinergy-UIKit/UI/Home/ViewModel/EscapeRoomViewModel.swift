//
//  EscapeRoomViewModel.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 20/01/2024.
//

import Foundation
import Combine
import KeychainAccess


class EscapeRoomViewModel {
    @Published var movies: EscapeRoomMovies?
    @Published var errorMessage: String?
    lazy var moviesCount: Int = {
        return self.movies?.escapeRoomsMovies.count ?? 0
        }()
    var EscapeMovieListView: Binding<Bool> = Binding(false)

    let baseURLString = Constants.Urls.baseURL
    let apiEndPoint: ApiEndPoints = .escapeRoomMovies
    private var method: HTTPMethod = .post
    
    private var cancellables: Set<AnyCancellable> = []
    private var fetchDataSubject = PassthroughSubject<Guest, Error>()
    var fetchDataPublisher: AnyPublisher<Guest, Error> {
        return fetchDataSubject.eraseToAnyPublisher()
    }
    init() {
        fetchPosts()
    }
    func fetchPosts()  {
        Task.detached {
            do {
                // Convert the parameters to JSON data
                let parameters: [String: Any] = [
                    "secret_key": Constants.Urls.secretKey,
                    "device_type": Constants.Urls.deviceType,
                    "device_id": Constants.Urls.devicId,
                    "location_id": Constants.Urls.locationId,
                    "member_id": "\(Constants.Urls.userId ?? 0)",
                    "userid": "\(Constants.Urls.userId ?? 0)",
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
                    // Add the token to the Authorization header
                    let token = self.retrieveTokenFromKeychain()
                    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

                    let fetchedPosts: EscapeRoomMovies = try await NetworkManager.fetchData(from: request)
                    await MainActor.run {
                        self.movies = fetchedPosts
                        self.EscapeMovieListView.value = true
                      
                    }
                    
                }  // Handle the result
            } catch {
                // Ensure UI updates on the main thread
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    // Function to retrieve the token from the keychain
       func retrieveTokenFromKeychain() -> String? {
           do {
              
               let token = try Keychain(service: Constants.Urls.keyChainKey).get("authToken")

               return token
           } catch {
               print("Error retrieving token from keychain: \(error)")
               return nil
           }
       }
    func getMovieCount() ->  Int {
        return movies?.escapeRoomsMovies.count ?? 0
    }
    func getMovie(index: Int) ->  EscapeRoom? {
        return movies?.escapeRoomsMovies[index]
    }
}
