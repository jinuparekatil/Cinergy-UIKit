//
//  MovieBookingViewModel.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 21/01/2024.
//

import Foundation

class MovieBookingViewModel {
    
    var  movie: MovieInfo
    var dateSelectedIndex:Int = 0
    var timeSelectedIndex:Int = 0
    init(movie: MovieInfo) {
        self.movie = movie
       
    }
}
