//
//  DetailsWeatherInteractor.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 27.09.2023.
//

import Foundation

protocol DetailsWeatherInteractorInputProtocol {
    init(presenter: DetailsWeatherInteractorOutputProtocol, city: String)
    func retrieveWeatherForTooday()
    func retrieveMoreWeather()
}

protocol DetailsWeatherInteractorOutputProtocol: AnyObject {
    func didRetrieveWeatherForTooday(weather: CityWeather)
    func didRetrieveMoreWeather(weather: CityWeather)
    func receivedError(_ error: String)
}

final class DetailsWeatherInteractor: DetailsWeatherInteractorInputProtocol {
    private unowned let presenter: DetailsWeatherInteractorOutputProtocol!
    private let city: String
    private let networkManager = NetworkManager.shared
    
    required init(presenter: DetailsWeatherInteractorOutputProtocol, city: String) {
        self.presenter = presenter
        self.city = city
    }
    
    func retrieveWeatherForTooday() {
            networkManager.fetchData(city: city) { [weak self] result in
                switch result {
                case  .success(let weather):
                    self?.presenter.didRetrieveWeatherForTooday(weather: weather)
                case .failure(let error):
                    self?.presenter.receivedError(error.localizedDescription)
                }
            }
        }
    
    func retrieveMoreWeather() {
            networkManager.fetchData(city: city) { [weak self] result in
                switch result {
                case  .success(let weather):
                    self?.presenter.didRetrieveMoreWeather(weather: weather)
                case .failure(let error):
                    self?.presenter.receivedError(error.localizedDescription)
                }
            }
        }
}
