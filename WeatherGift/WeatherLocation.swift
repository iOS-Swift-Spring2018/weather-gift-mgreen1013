//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Michael Green on 3/23/18.
//  Copyright © 2018 mgreen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    var currentSummary = ""
    
    func getWeather(completed: @escaping() -> ()) {
        let weatherURL = urlBase + urlKey + coordinates
        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                if let temperature = json["currently"]["temperature"].double{
                    let roundedTemp = String(format: "%3.f", temperature)
                    self.currentTemp = roundedTemp + "°"
                }
                if let summary = json["daily"]["summary"].string { 
                    self.currentSummary = summary }
            case .failure(let error):
                print(error)
            }
            
         completed()
        }
    }
    
}

