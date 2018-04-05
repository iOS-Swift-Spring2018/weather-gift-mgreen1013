//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Michael Green on 4/4/18.
//  Copyright © 2018 mgreen. All rights reserved.
//

import Foundation

class WeatherLocation: Codable {
    var name: String
    var coordinates: String
    
    init(name: String, coordinates: String) {
        self.name = name
        self.coordinates = coordinates
    }
}
