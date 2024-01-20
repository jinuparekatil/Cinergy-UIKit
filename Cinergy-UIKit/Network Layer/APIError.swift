//
//  APIError.swift
//  Cinergy-Network-1
//
//  Created by Jinu on 20/01/2024.
//

import Foundation

public enum APIError: Error {
    
    case urlError
    case decodingError
    case unknownError(String)
}
