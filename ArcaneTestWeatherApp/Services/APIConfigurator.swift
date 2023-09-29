//
//  APIConfigurator.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 27.09.2023.
//

import Foundation

final class APIConfigurator {
    static let shared = APIConfigurator()
    private let apiKey = "358389cc2e7b7f987ac85f1075b911c6"
    
    private init() {}
    
    func getAPI(city: String) -> String {
        "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
    }
}
