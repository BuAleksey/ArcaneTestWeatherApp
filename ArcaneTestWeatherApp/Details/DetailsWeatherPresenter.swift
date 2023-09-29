//
//  DetailsWeatherPresenter.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 27.09.2023.
//

import Foundation

class DetailsWeatherPresenter: DetailsWeatherViewOutputProtocol {
    var interactor: DetailsWeatherInteractorInputProtocol!
    private unowned let view: DetailsWeatherViewInputProtocol
    
    required init(view: DetailsWeatherViewInputProtocol) {
        self.view = view
    }
    
    func showDetails() {
        interactor.retrieveDetailWeather()
    }
}

// MARK: - DetailsWeatherInteractorOutputProtocol
extension DetailsWeatherPresenter: DetailsWeatherInteractorOutputProtocol {
    func didRetrieveDetailWeather(weather: CityWeather) {
        let tempString = String(Int(weather.main.temp)) + "°C"
        let windString = String(Int(weather.wind.speed)) + "m/s"
        view.displayCityName(with: weather.name)
        view.displayTemp(with: tempString)
        view.displayWind(with: windString)
        guard let imageString = weather.weather.first?.systemIcon else { return }
        view.displayImage(with: imageString)
    }
    
    func receivedError(_ error: String) {
        view.showErrorMasage(error)
    }
}
