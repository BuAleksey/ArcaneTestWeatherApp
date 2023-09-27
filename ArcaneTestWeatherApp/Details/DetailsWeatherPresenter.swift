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
        
    }
}

// MARK: - DetailsWeatherInteractorOutputProtocol
extension DetailsWeatherPresenter: DetailsWeatherInteractorOutputProtocol {
    
}
