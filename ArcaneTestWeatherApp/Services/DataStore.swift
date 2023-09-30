//
//  DataBase.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import Foundation

final class DataStore {
    static let shared = DataStore()
    var cities = ["Moscow", "London"]
    
    private init() {}
    
    func addCity(_ city: String) {
        cities.append(city)
    }
    
    func removeCity(_ city: String) {
        if let index = cities.firstIndex(where: { $0 == city }) {
            cities.remove(at: index)
        }
    }
}
