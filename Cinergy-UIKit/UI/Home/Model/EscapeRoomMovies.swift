//
//  EscapeRoomMovies.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 20/01/2024.
//

import Foundation

public struct EscapeRoomMovies: Codable {
    let response: String
    let er_Tickets: String?
    let escapeRoomsMovies: [EscapeRoom]
    enum CodingKeys: String, CodingKey {
        case response
        case er_Tickets = "er_Tickets"
        case escapeRoomsMovies = "escape_rooms_movies"
       
    }

   
}

public struct EscapeRoom: Codable {
     let id: String
     let scheduledFilmId: String
     let slug: String
     let title: String
     let rating: String
     let runTime: String
     let synopsis: String
     let imageUrl: String
     let imageUrlPoster: String

     enum CodingKeys: String, CodingKey {
         case id = "ID"
         case scheduledFilmId = "ScheduledFilmId"
         case slug
         case title = "Title"
         case rating = "Rating"
         case runTime = "RunTime"
         case synopsis = "Synopsis"
         case imageUrl = "image_url"
         case imageUrlPoster = "image_url_poster"
     }
 }
