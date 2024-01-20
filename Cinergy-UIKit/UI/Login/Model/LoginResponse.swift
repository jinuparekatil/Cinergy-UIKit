//
//  LoginResponse.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 20/01/2024.
//

import Foundation

struct LoginResponse: Decodable {
    let response: String
    let user: User
}

struct User: Decodable {
    let id: Int
    
}
