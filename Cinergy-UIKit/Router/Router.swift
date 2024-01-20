//
//  Router.swift
//  Cinergy-UIKit
//
//  Created by Jinu on 20/01/2024.
//

import UIKit
import Foundation

class Router {
     func getViewController(withIdentifier identifier: String, viewModel: EscapeRoomViewModel) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! EscapeRoomViewController
        viewController.viewModel = viewModel
        return viewController
    }
}
