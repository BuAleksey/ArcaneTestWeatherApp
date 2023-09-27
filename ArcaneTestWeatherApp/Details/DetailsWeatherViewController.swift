//
//  DetailsViewController.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import UIKit

protocol DetailsWeatherViewInputProtocol: AnyObject {
//    func displayCityName(with name: String)
//    func displayTemp(with temp: String)
//    func displayWind(with wind: String)
//    func displayImage(with image: String)
}

protocol DetailsWeatherViewOutputProtocol {
    init(view: DetailsWeatherViewInputProtocol)
    func showDetails()
}

class DetailsWeatherViewController: UIViewController {
    @IBOutlet var image: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    
    var presenter: DetailsWeatherViewOutputProtocol!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = "MSK"
    }
}

// MARK: - DetailsWeatherViewInputProtocol
extension DetailsWeatherViewController: DetailsWeatherViewInputProtocol {
//    func displayCityName(with name: String) {
//        cityLabel.text
//    }
//    
//    func displayTemp(with temp: String) {
//        tempLabel.text
//    }
//    
//    func displayWind(with wind: String) {
//        windLabel.text
//    }
//    
//    func displayImage(with image: String) {
//        
//    }
}
