//
//  Constants.swift
//  Cinergy-Network-1
//
//  Created by Jinu on 20/01/2024.
//

import Foundation


struct Constants {
    
    struct Urls {
        static let baseURL = "https://cinergyapp.thetunagroup.com"
        
        
        static let header = ["Content-Type": "application/json"]
//        static let parameters: [String: Any] = [
//            "secret_key": "402620C92552D9303C58B901B43B0A41718E772C19520DD9A9AA52CE5A8FCB99",
//            "device_type": "2",
//            "device_id": "CI - \(UUID())",
//            "push_token": ""
//        ]
        static let devicId =  "CI - \(UUID().uuidString)"
        static let secretKey = "402620C92552D9303C58B901B43B0A41718E772C19520DD9A9AA52CE5A8FCB99"
        static let deviceType = "2"
        static let loginType = "2"
        static let locationId = "5"
        static var userId: Int?
        static var memberId: Int?
        static let keyChainKey = "com.ios.Cinergy-UIKit"
        
    }
    
}
