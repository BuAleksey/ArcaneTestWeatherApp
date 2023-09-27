//
//  CitiesPresenter.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import Foundation

struct CityAndTemp {
    let city: String
    let temp: String
}

class CitiesListPresenter: CitiesListViewOutputProtocol {
    var interactor: CitiesListInteractorInputProtocol!
    var router: CitiesListRouterInputProtocol!
    
    private unowned let view: CitiesListViewInputProtocol
    
    required init(view: CitiesListViewInputProtocol) {
        self.view = view
    }
    
    func viewWillAppear() {
        interactor.retrieveCities()
    }
    
    func showDetailsWeather(_ city: City) {
        router.openDetailsWeatherViewController(with: city)
    }
    
    func addCity(_ city: City) {
        interactor.addCity(city)
    }
    
    func removeCity(_ city: City) {
        interactor.removeCity(city)
    }
}

// MARK: - CitiesListInteractorOutputProtocol
extension CitiesListPresenter: CitiesListInteractorOutputProtocol {
    func didAddCity(_ city: City) {
        interactor.retrieveCities()
    }
    
    func didRemoveCity(_ city: City) {
        interactor.retrieveCities()
    }
    
    func didRetrieveCities(_ cities: [City]) {
        view.showCities(cities)
    }
    

}
