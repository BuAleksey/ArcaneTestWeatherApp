//
//  DetailsWeatherInteractor.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 27.09.2023.
//

import Foundation

protocol DetailsWeatherInteractorInputProtocol {
    init(presenter: DetailsWeatherInteractorOutputProtocol, city: City)
}

protocol DetailsWeatherInteractorOutputProtocol: AnyObject {
    
}

class DetailsWeatherInteractor: DetailsWeatherInteractorInputProtocol {
    private unowned let presenter: DetailsWeatherInteractorOutputProtocol!
    private let city: City
    
    required init(presenter: DetailsWeatherInteractorOutputProtocol, city: City) {
        self.presenter = presenter
        self.city = city
    }
}
