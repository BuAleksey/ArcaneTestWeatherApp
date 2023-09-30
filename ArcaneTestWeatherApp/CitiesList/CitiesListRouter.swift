//
//  CitiesRouter.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import Foundation

protocol CitiesListRouterInputProtocol {
    init(view: CitiesListViewController)
    func presentDetailsWeatherViewController(with city: String)
}

final class CitiesListRouter: CitiesListRouterInputProtocol {
    private unowned let view: CitiesListViewController
    
    required init(view: CitiesListViewController) {
        self.view = view
    }
    
    func presentDetailsWeatherViewController(with city: String) {
        let detailVC = DetailsWeatherViewController()
        view.navigationController?.pushViewController(detailVC, animated: true)
        let configurator: DetailsWeatherConfiguratorInputProtocol = DetailsWeatherConfigurator()
        configurator.configure(withView: detailVC, and: city)
    }
}
