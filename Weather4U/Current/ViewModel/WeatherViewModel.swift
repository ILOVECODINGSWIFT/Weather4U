//
//  WeatherViewModel.swift
//  Weather4U
//
//  Created by administrator on 16/07/20.
//  Copyright © 2020 ILoveCodingSwift. All rights reserved.
//

import Foundation

protocol WeatherViewModelProtocol {
    func didUpdateCurrentWeather()
}


class WeatherViewModel: NSObject {
    var delegate: WeatherViewModelProtocol?
    
    fileprivate(set) var currentWeather: WeatherModel?
    
    private var weatherService = WeatherService()

    func getCurrentWeather(lat : String, lng : String) {

        weatherService.requestCurrentWeather(lat : lat, lng : lng, completion: { (currentWeatherResult, error) in
            if let error = error {
                print(error)
            } else {
                if let result = currentWeatherResult {
                    self.currentWeather = result
                    self.delegate?.didUpdateCurrentWeather()
                }
            }
        })
    }
}
