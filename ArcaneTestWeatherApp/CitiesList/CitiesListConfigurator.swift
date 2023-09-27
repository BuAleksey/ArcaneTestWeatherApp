//
//  CitiesListConfigurator.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import Foundation

protocol CitiesListConfiguratorInputProtocol {
    func configure(withView view: CitiesListViewController)
}

class CitiesListConfigurator: CitiesListConfiguratorInputProtocol {
    func configure(withView view: CitiesListViewController) {
        let presenter = CitiesListPresenter(view: view)
        let interactor = CitiesListInteractor(presenter: presenter)
        let router = CitiesListRouter(view: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
