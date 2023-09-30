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

final class CitiesListPresenter: CitiesListViewOutputProtocol {
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
        router.presentDetailsWeatherViewController(with: city)
    }
}

// MARK: - CitiesListInteractorOutputProtocol
extension CitiesListPresenter: CitiesListInteractorOutputProtocol {
    func didRetrieveCities(_ city: CityWeather) {
        let tempString = String(Int(city.list.first?.main.temp ?? 0)) + "°C"
        let cityAndTemp = CityAndTemp(city: city.city.name, temp: tempString)
        view.showCities(cityAndTemp)
    }
    
    func didAddCity(_ city: CityWeather) {
        let tempString = String(Int(city.list.first?.main.temp ?? 0)) + "°C"
        let cityAndTemp = CityAndTemp(city: city.city.name, temp: tempString)
        view.showCities(cityAndTemp)
    }
    
    func didRemoveCity(_ city: String) {
        view.removeCity(city)
    }
    
    func receivedError(_ error: String) {
        view.showErrorMasage(error)
    }
}
