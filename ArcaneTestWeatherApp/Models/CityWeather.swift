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
    let main: String
}

struct Wind: Decodable {
    let speed: Double
}
