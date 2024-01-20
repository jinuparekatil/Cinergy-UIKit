//
//  Constants.swift
//  Cinergy-Network-1
//
//  Created by Jinu on 20/01/2024.
//

import Foundation


struct Constants {
    
    struct Urls {
        static let baseURL = "https://cinergyapp.thetunagroup.com/api"
        static let petListing = "\(baseURL)/pet-listing"
        
        
        let header = ["Content-Type": "application/json"]
        let  parameters = ["secret_key":
         "402620C92552D9303C58B901B43B0A41718E772C19520DD9A9AA52CE5A8 FCB99",

         "device_type": "2"]

//         "device_id": uniqueDeviceId appending "CI -", "push_token": ""]
        
        
    }
}
