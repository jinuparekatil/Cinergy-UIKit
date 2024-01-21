//
//  MovieBookingViewModel.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 21/01/2024.
//
import Foundation

// MARK: - MovieBookingViewModel

class MovieBookingViewModel {
    
    // MARK: Properties
    
    var movie: MovieInfo
    
    var dateSelectedIndex: Int = 0
    var timeSelectedIndex: Int = 0
    
    var isClickedDate: Binding<Bool> = Binding(false)
    
    // MARK: Initializer
    
    init(movie: MovieInfo) {
        self.movie = movie
    }
    
    // MARK: Public Methods
    
    func setDateForSelectedIndex(index: Int) {
        dateSelectedIndex = index
        isClickedDate.value = true
    }
    
    func setTimeForSelectedIndex(index: Int) {
        timeSelectedIndex = index
    }
    
   
    func getShowTime(index: Int) -> String {
        return movie.showTimes[dateSelectedIndex].sessions[index].showtime
    }
    
    func getDateCount() -> Int {
        return movie.dateList.count
    }
    
    func getTimeCount() -> Int {
        return movie.showTimes[dateSelectedIndex].sessions.count

    }
    
    func getWeek(index: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: movie.showTimes[index].date) {
            dateFormatter.dateFormat = "EEE"
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    func getDate(index: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: movie.showTimes[index].date) {
            dateFormatter.dateFormat = "MMM dd"
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
   
}
