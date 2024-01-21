//
//  MovieDetail.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 21/01/2024.
//

import Foundation

public struct MovieDetail: Codable {
    let response: String
    let movieInfo: MovieInfo?
    let erTickets: String

    enum CodingKeys: String, CodingKey {
        case response
        case movieInfo = "movie_info"
        case erTickets = "er_tickets"
    }
}

struct MovieInfo: Codable {
    let scheduledFilmId, slug, title, rating: String
    let runTime, synopsis, imageURL, imageURLPoster: String
    let trailerURL, genres: String
    let showTimes: [ShowTime]
    let dateList: [String]
    
    enum CodingKeys: String, CodingKey {
        case scheduledFilmId = "ScheduledFilmId"
        case slug
        case title = "Title"
        case rating = "Rating"
        case runTime = "RunTime"
        case synopsis = "Synopsis"
        case imageURL = "image_url"
        case imageURLPoster = "image_url_poster"
        case trailerURL = "TrailerUrl"
        case genres = "Genres"
        case showTimes = "show_times"
        case dateList = "date_list"
    }
}

struct ShowTime: Codable {
    let date: String
    let sessions: [Session]
}

struct Session: Codable {
    let scheduledFilmId, attribute, sessionId, showtimeVista: String
    let showtime: String
    let isAllocatedSeating: Bool
    let seatsAvailable, screenNumber, soldoutStatus: Int
    let allowTicketSales: Bool
    
    enum CodingKeys: String, CodingKey {
        case scheduledFilmId = "ScheduledFilmId"
        case attribute = "Attribute"
        case sessionId = "SessionId"
        case showtimeVista = "ShowtimeVista"
        case showtime = "Showtime"
        case isAllocatedSeating = "IsAllocatedSeating"
        case seatsAvailable = "SeatsAvailable"
        case screenNumber = "ScreenNumber"
        case soldoutStatus = "SoldoutStatus"
        case allowTicketSales = "AllowTicketSales"
    }
}
