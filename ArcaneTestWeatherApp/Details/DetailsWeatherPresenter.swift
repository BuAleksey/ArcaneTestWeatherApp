//
//  DetailsWeatherPresenter.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 27.09.2023.
//

import Foundation

struct DetailsWether {
    let city: String
    let date: String
    let temp: String
    let wind: String
    let image: String
}

final class DetailsWeatherPresenter: DetailsWeatherViewOutputProtocol {
    var interactor: DetailsWeatherInteractorInputProtocol!
    private unowned let view: DetailsWeatherViewInputProtocol
    private let dateManager = DateManager.shared
    
    required init(view: DetailsWeatherViewInputProtocol) {
        self.view = view
    }
    
    func viewDidAppear() {
        interactor.retrieveWeatherForTooday()
    }
    
    func showMoreDays() {
        interactor.retrieveMoreWeather()
    }
}

// MARK: - DetailsWeatherInteractorOutputProtocol
extension DetailsWeatherPresenter: DetailsWeatherInteractorOutputProtocol {
    func didRetrieveWeatherForTooday(weather: CityWeather) {
        var detailsWetherArray: [DetailsWether] = []
        weather.list.forEach { weatherDetails in
            if dateManager.getCurrentUnixTimeInteval().contains(weatherDetails.dt) {
                let date = dateManager.getDateFromUnix(weatherDetails.dt)
                let tempString = String(Int(weatherDetails.main.temp)) + "°C"
                let windString = String(Int(weatherDetails.wind.speed)) + "m/s"
                let systemIcon = weatherDetails.weather.first?.systemIcon ?? ""
                
                let detailsWether = DetailsWether(
                    city: weather.city.name,
                    date: date,
                    temp: tempString,
                    wind: windString,
                    image: systemIcon
                )
                detailsWetherArray.append(detailsWether)
            }
        }
        view.showWeatherForTooday(detailsWetherArray)
    }
    
    func didRetrieveMoreWeather(weather: CityWeather) {
        var detailsWetherArray: [DetailsWether] = []
        weather.list.forEach { weatherDetails in
            if !dateManager.getCurrentUnixTimeInteval().contains(weatherDetails.dt) {
                let date = dateManager.getDateFromUnix(weatherDetails.dt)
                let tempString = String(Int(weatherDetails.main.temp)) + "°C"
                let windString = String(Int(weatherDetails.wind.speed)) + "m/s"
                let systemIcon = weatherDetails.weather.first?.systemIcon ?? ""
                
                let detailsWether = DetailsWether(
                    city: weather.city.name,
                    date: date,
                    temp: tempString,
                    wind: windString,
                    image: systemIcon
                )
                detailsWetherArray.append(detailsWether)
            }
        }
        view.showWeatherForNextDay(detailsWetherArray)
    }
    
    func receivedError(_ error: String) {
        view.showErrorMasage(error)
    }
}
