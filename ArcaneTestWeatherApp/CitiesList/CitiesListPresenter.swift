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
    
    func viewDidAppear() {
        interactor.retrieveCities()
    }
    
    func addCity(_ city: String) {
        interactor.addCity(city)
    }
    
    func removeCity(_ city: String) {
        interactor.removeCity(city)
    }
    
    func showDetailsWeather(_ city: String) {
        router.openDetailsWeatherViewController(with: city)
    }
}

// MARK: - CitiesListInteractorOutputProtocol
extension CitiesListPresenter: CitiesListInteractorOutputProtocol {
    func didRetrieveCities(_ city: CityWeather) {
        let tempString = String(Int(city.main.temp)) + "°C"
        let cityAndTemp = CityAndTemp(city: city.name, temp: tempString)
        view.showCities(cityAndTemp)
    }
    
    func didAddCity(_ city: CityWeather) {
        let tempString = String(Int(city.main.temp)) + "°C"
        let cityAndTemp = CityAndTemp(city: city.name, temp: tempString)
        view.showCities(cityAndTemp)
    }
    
    func didRemoveCity(_ city: String) {
        view.removeCity(city)
    }
    
    func receivedError(_ error: String) {
        view.showErrorMasage(error)
    }
}
