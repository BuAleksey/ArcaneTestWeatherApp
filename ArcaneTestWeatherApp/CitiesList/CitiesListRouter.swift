//
//  CitiesRouter.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import Foundation

protocol CitiesListRouterInputProtocol {
    init(view: CitiesListViewController)
    func openDetailsWeatherViewController(with city: City)
}

class CitiesListRouter: CitiesListRouterInputProtocol {
    private unowned let view: CitiesListViewController
    
    required init(view: CitiesListViewController) {
        self.view = view
    }
    
    func openDetailsWeatherViewController(with city: City) {
        view.performSegue(withIdentifier: "showDetails", sender: city)
    }
}
