//
//  NetworkManager.swift
//  Cinergy-Network-1
//
//  Created by Jinu on 20/01/2024.
//
// MARK: - Async/Await-based NetworkManager:

import Foundation

class NetworkManager {
    static func fetchData<T: Decodable>(
        from request: URLRequest
    ) async throws -> T {
        // Create an instance of URLSession
        let session = URLSession.shared

        do {
            // Use data(for:delegate:queue:) to fetch data asynchronously
            let (data, _) = try await session.data(for: request)

            // Attempt to decode the JSON data
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                // Print or log the error for debugging purposes
                print("Error decoding JSON: \(error)")
                print("Decoding failure for type \(T.self) with JSON data:")
                print(String(data: data, encoding: .utf8) ?? "Invalid UTF-8 data")
                throw error
            }
        } catch {
            // Print or log the error for debugging purposes
            print("Error fetching data: \(error)")
            
            // Re-throw the error for the calling code to handle
            throw error
        }
    }
}

