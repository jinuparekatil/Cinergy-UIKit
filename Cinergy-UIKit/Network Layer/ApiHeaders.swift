//
//  AppHeaders.swift
//  Cinergy-Network-1
//
//  Created by Jinu on 20/01/2024.
//

import Foundation

enum ApiHeaders {
    static var defaultHeaders: [String: String] = {
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            
        ]
        return headers
    }()
}
