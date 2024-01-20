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

        // Use data(for:delegate:queue:) to fetch data asynchronously
        let (data, _) = try await session.data(for: request)

        return try JSONDecoder().decode(T.self, from: data)
    }
}
