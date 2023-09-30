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
    func addCity(_ city: String)
    func removeCity(_ city: String)
}

protocol CitiesListInteractorOutputProtocol: AnyObject {
    func didRetrieveCities(_ city: CityWeather)
    func didAddCity(_ city: CityWeather)
    func didRemoveCity(_ city: String)
    func receivedError(_ error: String)
}

final class CitiesListInteractor: CitiesListInteractorInputProtocol {
    private let dataStore = DataStore.shared
    private let networkManager = NetworkManager.shared
    private unowned let presenter: CitiesListInteractorOutputProtocol
    
    required init(presenter: CitiesListInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func retrieveCities() {
        dataStore.cities.forEach({ city in
            networkManager.fetchData(city: city) { [weak self] result in
                switch result {
                case  .success(let weather):
                    self?.presenter.didRetrieveCities(weather)
                case .failure(let error):
                    self?.presenter.receivedError(error.localizedDescription)
                }
            }
        })
    }
    
    func addCity(_ city: String) {
        dataStore.addCity(city)
        networkManager.fetchData(city: city) { [weak self] result in
            switch result {
            case  .success(let weather):
                self?.presenter.didAddCity(weather)
            case .failure(let error):
                self?.presenter.receivedError(error.localizedDescription)
            }
        }
    }
    
    func removeCity(_ city: String) {
        dataStore.removeCity(city)
        presenter.didRemoveCity(city)
    }
}
