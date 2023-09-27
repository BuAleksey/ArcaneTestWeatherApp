//
//  DetailsWeatherConfigurator.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 27.09.2023.
//

import Foundation

protocol DetailsWeatherConfiguratorInputProtocol {
    func configure(withView view: DetailsWeatherViewController, and city: City)
}

class DetailsWeatherConfigurator: DetailsWeatherConfiguratorInputProtocol {
    func configure(withView view: DetailsWeatherViewController, and city: City) {
        let presenter = DetailsWeatherPresenter(view: view)
        let interactor = DetailsWeatherInteractor(presenter: presenter, city: city)
        view.presenter = presenter
        presenter.interactor = interactor
    }
}
