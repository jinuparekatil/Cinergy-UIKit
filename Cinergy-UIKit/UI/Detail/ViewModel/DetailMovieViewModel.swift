//
//  DetailMovieViewModel.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 21/01/2024.
//

import Foundation
import Combine
import KeychainAccess

class DetailMovieViewModel {
    
    @Published var movie: MovieDetail?
    @Published var errorMessage: String?
    var movieId: String
    init(movieId: String) {
        self.movieId = movieId
        fetchPosts()
    }

    let baseURLString = Constants.Urls.baseURL
    let apiEndPoint: ApiEndPoints = .getMovieInfo
    private var method: HTTPMethod = .post
    
    private var cancellables: Set<AnyCancellable> = []
    private var fetchDataSubject = PassthroughSubject<MovieDetail, Error>()
    var isMovieDetailView: Binding<Bool> = Binding(false)

    var fetchDataPublisher: AnyPublisher<MovieDetail, Error> {
        return fetchDataSubject.eraseToAnyPublisher()
    }
    func fetchPosts()  {
        Task.detached {
            do {
                
                // Convert the parameters to JSON data
                let parameters: [String: Any] = [
                    
                    "device_type": Constants.Urls.deviceType,
                    "device_id": Constants.Urls.devicId,
                    "location_id": Constants.Urls.locationId,
                    "movie_id": self.movieId,
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
                    do {
                        let fetchedPosts: MovieDetail = try await NetworkManager.fetchData(from: request)
                        
                        self.movie = fetchedPosts
                        
                        self.fetchDataSubject.send(fetchedPosts)
                        await MainActor.run {
                            self.movie = fetchedPosts
                            self.isMovieDetailView.value = true
                        }
                        
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
    
}
