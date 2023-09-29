//
//  СityWeather.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import Foundation

struct CityWeather: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    
    var systemIcon: String {
        switch id {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
}

struct Wind: Decodable {
    let speed: Double
}
