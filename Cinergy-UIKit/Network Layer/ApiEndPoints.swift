//
//  AppEndPoints.swift
//  Cinergy-Network-1
//
//  Created by Jinu on 20/01/2024.
//

import Foundation

enum ApiEndPoints  {
    case guestToken
    case login
    case escapeRoomMovies
    case getMovieInfo
}

extension ApiEndPoints {
    var path: String {
        switch self {
        case .guestToken:
            return "api/guestToken"
        case .login:
            return "api/login"
        case .escapeRoomMovies:
            return "api/escapeRoomMovies"
        case .getMovieInfo:
            return "api/getMovieInfo"
        }
    }
}
