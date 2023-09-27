//
//  CitiesInteractor.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import Foundation

protocol CitiesListInteractorInputProtocol {
    init(presenter: CitiesListInteractorOutputProtocol)
    func retrieveCities()
    func addCity(_ city: City)
    func removeCity(_ city: City)
}

protocol CitiesListInteractorOutputProtocol: AnyObject {
    func didAddCity(_ city: City)
    func didRemoveCity(_ city: City)
    func didRetrieveCities(_ cities: [City])
}

class CitiesListInteractor: CitiesListInteractorInputProtocol {
    private let dataStore = DataStore.shared
    private unowned let presenter: CitiesListInteractorOutputProtocol
    
    required init(presenter: CitiesListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func retrieveCities() {
        presenter.didRetrieveCities(dataStore.cities)
    }
    
    func addCity(_ city: City) {
        dataStore.addCity(city)
        presenter.didAddCity(city)
    }
    
    func removeCity(_ city: City) {
        dataStore.removeCity(city)
        presenter.didRemoveCity(city)
    }
}
