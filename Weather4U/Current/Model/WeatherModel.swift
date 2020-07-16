//
//  WeatherModel.swift
//  Weather4U
//
//  Created by administrator on 16/07/20.
//  Copyright © 2020 ILoveCodingSwift. All rights reserved.
//

import Foundation
import Alamofire


struct WeatherModel: Codable {
    let name : String
    let dt : TimeInterval
    let weather : [CoreModel]
    let main : MainModel
    let wind : WindModel
    let clouds : CloudsModel
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case dt = "dt"
        case weather = "weather"
        case main = "main"
        case wind = "wind"
        case clouds = "clouds"
    }
}

struct CoreModel: Codable {
    let main : String
    let description : String
    let icon : String
    
    enum CodingKeys: String, CodingKey {
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
}

struct MainModel: Codable {
    let temp : Double
    let temp_min : Double
    let temp_max : Double
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
    }
}

struct CloudsModel: Codable {
    let all : Double
    
    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}

struct WindModel: Codable {
    let speed : Double
    
    enum CodingKeys: String, CodingKey {
        case speed = "speed"
    }
}


// MARK: - Alamofire response handlers
extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseCurrentWeather(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<WeatherModel>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}
