//
//  WeatherService.swift
//  Weather4U
//
//  Created by administrator on 16/07/20.
//  Copyright © 2020 ILoveCodingSwift. All rights reserved.
//

import Foundation
import Alamofire

struct WeatherService {
    
    // MARK: - Singleton
    static let shared = WeatherService()
    
    // MARK: - Services
    
    let appID = "62a8e3e457c926df8267625b74f38f9d" //appId can be found here or create a new one https://home.openweathermap.org/api_keys
    
    func requestCurrentWeather(lat: String, lng: String, completion: @escaping (WeatherModel?, Error?) -> ()) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lng)&appid=\(appID)"
        
        Alamofire.request(url).responseCurrentWeather { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let currentWeather = response.result.value {
                completion(currentWeather, nil)
                return
            }
        }
    }
    
}
