//
//  CitiesTableViewController.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import UIKit

protocol CitiesListViewInputProtocol: AnyObject {
    func showCities(_ city: CityAndTemp)
    func removeCity(_ city: String)
    func showErrorMasage(_ message: String)
}

protocol CitiesListViewOutputProtocol {
    init(view: CitiesListViewInputProtocol)
    func viewDidAppear()
    func addCity(_ city: String)
    func removeCity(_ city: String)
    func showDetailsWeather(_ city: String)
}

final class CitiesListViewController: UITableViewController {
    var presenter: CitiesListViewOutputProtocol!
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private var configurator: CitiesListConfiguratorInputProtocol = CitiesListConfigurator()
    private var cities: [CityAndTemp] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(withView: self)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")      
        setupNavigationBar()
        setupConstraints()
        
        presenter.viewDidAppear()
        activityIndicator.startAnimating()
    }
    
    @IBAction func addCity(_ sender: UIBarButtonItem) {
        showAddCityAlet()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .value2, reuseIdentifier: "cell")
        let city = cities[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = city.city
        content.textProperties.font = .systemFont(ofSize: 16, weight: .black)
        
        content.secondaryText = city.temp
        content.secondaryTextProperties.color = .gray
        content.textProperties.font = .systemFont(ofSize: 16, weight: .black)
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = cities[indexPath.row]
        presenter.showDetailsWeather(city.city)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let city = cities[indexPath.row]
            presenter.removeCity(city.city)
        }
    }
    
    private func setupConstraints() {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Cities"
        
        let searchBtn = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: #selector(showAddCityAlet)
        )
        navigationItem.rightBarButtonItem = searchBtn
    }
    
    @objc private func showAddCityAlet() {
        let alertController = UIAlertController(
            title: "Add city",
            message: "Enter city name",
            preferredStyle: .alert
        )
        
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(
            UIAlertAction(
                title: "Add",
                style: .default,
                handler: { [unowned self](_) in
                    let cityName = alertController.textFields![0].text ?? ""
                    guard !cityName.isEmpty else { return }
                    self.presenter.addCity(cityName)
                    activityIndicator.startAnimating()
                }
            )
        )
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
}

// MARK: - CitiesListViewInputProtocol
extension CitiesListViewController: CitiesListViewInputProtocol {
    func showCities(_ city: CityAndTemp) {
        cities.append(city)
        activityIndicator.stopAnimating()
    }
    
    func removeCity(_ city: String) {
        if let index = cities.firstIndex(where: { $0.city == city }) {
            cities.remove(at: index)
            activityIndicator.stopAnimating()
        }
    }
    
    func showErrorMasage(_ message: String) {
        DispatchQueue.main.async { [unowned self] in
            self.activityIndicator.stopAnimating()
            let alertController = UIAlertController(
                title: "In English please",
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
