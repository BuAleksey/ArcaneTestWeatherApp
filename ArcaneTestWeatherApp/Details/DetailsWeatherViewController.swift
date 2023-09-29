//
//  DetailsViewController.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import UIKit

protocol DetailsWeatherViewInputProtocol: AnyObject {
    func displayCityName(with name: String)
    func displayTemp(with temp: String)
    func displayWind(with wind: String)
    func displayImage(with image: String)
    func showErrorMasage(_ message: String)
}

protocol DetailsWeatherViewOutputProtocol {
    init(view: DetailsWeatherViewInputProtocol)
    func showDetails()
}

class DetailsWeatherViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var windLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var presenter: DetailsWeatherViewOutputProtocol!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showDetails()
        stackView.isHidden = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
}

// MARK: - DetailsWeatherViewInputProtocol
extension DetailsWeatherViewController: DetailsWeatherViewInputProtocol {
    func displayCityName(with name: String) {
        self.activityIndicator.stopAnimating()
        stackView.isHidden.toggle()
        cityLabel.text = name
    }
    
    func displayTemp(with temp: String) {
        self.activityIndicator.stopAnimating()
        tempLabel.text = temp
    }
    
    func displayWind(with wind: String) {
        self.activityIndicator.stopAnimating()
        windLabel.text = wind
    }
    
    func displayImage(with image: String) {
        self.activityIndicator.stopAnimating()
        imageView.image = UIImage(systemName: image)
    }
    
    func showErrorMasage(_ message: String) {
        DispatchQueue.main.async { [unowned self] in
            self.activityIndicator.stopAnimating()
            let alertController = UIAlertController(
                title: "Failed to load data",
                message: message,
                preferredStyle: .alert
            )
            self.present(alertController, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                alertController.dismiss(animated: true)
            }
        }
    }
}
