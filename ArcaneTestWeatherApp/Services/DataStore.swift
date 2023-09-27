//
//  DataBase.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import Foundation

class DataBase {
    static let shared = DataBase()
    var favoriteCities = ["Moscow", "Paris"]
    
    private init() {}
}
