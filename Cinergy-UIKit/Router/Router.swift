//
//  Router.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 20/01/2024.
//

import UIKit
import Foundation

class Router {
     func getEscapeViewController(withIdentifier identifier: String, viewModel: EscapeRoomViewModel) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! EscapeRoomViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    func getMovieDetailViewController(withIdentifier identifier: String, viewModel: DetailMovieViewModel) -> UIViewController? {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! DetailViewController
       viewController.viewModel = viewModel
       return viewController
   }
    
    func getMovieDetailsVCViewController(withIdentifier identifier: String, viewModel: MovieBookingViewModel) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! BookViewController
        viewController.viewModel = viewModel
        return viewController
    }
}
