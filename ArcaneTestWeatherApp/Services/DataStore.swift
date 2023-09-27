//
//  DataBase.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import Foundation

class DataStore {
    static let shared = DataStore()
    var cities = [City(name: "Moscow"), City(name: "London")]
    
    private init() {}
    
    func addCity(_ city: City) {
        cities.append(city)
    }
    
    func removeCity(_ city: City) {
        if let index = cities.firstIndex(where: { $0.name == city.name }) {
            cities.remove(at: index)
        }
    }
}
