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
            return "/guestToken"
        case .login:
            return "/login"
        case .escapeRoomMovies:
            return "/escapeRoomMovies"
        case .getMovieInfo:
            return "/getMovieInfo"
        }
    }
}
