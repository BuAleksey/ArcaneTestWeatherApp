//
//  DetailsWeatherInteractor.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 27.09.2023.
//

import Foundation

protocol DetailsWeatherInteractorInputProtocol {
    init(presenter: DetailsWeatherInteractorOutputProtocol, city: String)
    func retrieveDetailWeather()
}

protocol DetailsWeatherInteractorOutputProtocol: AnyObject {
    func didRetrieveDetailWeather(weather: CityWeather)
    func receivedError(_ error: String)
}

class DetailsWeatherInteractor: DetailsWeatherInteractorInputProtocol {
    private unowned let presenter: DetailsWeatherInteractorOutputProtocol!
    private let city: String
    private let networkManager = NetworkManager.shared
    
    required init(presenter: DetailsWeatherInteractorOutputProtocol, city: String) {
        self.presenter = presenter
        self.city = city
    }
    
    func retrieveDetailWeather() {
        networkManager.fetchData(city: city) { [unowned self] result in
            switch result {
            case  .success(let weather):
                self.presenter.didRetrieveDetailWeather(weather: weather)
            case .failure(let error):
                self.presenter.receivedError(error.localizedDescription)
            }
        }
    }
}
