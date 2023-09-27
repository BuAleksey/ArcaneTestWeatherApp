//
//  CitiesTableViewController.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import UIKit

protocol CitiesListViewInputProtocol: AnyObject {
    func showCities(_ cities: [City])
}

protocol CitiesListViewOutputProtocol {
    init(view: CitiesListViewInputProtocol)
    func viewWillAppear()
    func showDetailsWeather(_ city: City)
    func addCity(_ city: City)
    func removeCity(_ city: City)
}

class CitiesListViewController: UITableViewController {
    var presenter: CitiesListViewOutputProtocol!
    
    private var configurator: CitiesListConfiguratorInputProtocol = CitiesListConfigurator()
    private var cities: [City] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        configurator.configure(withView: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailsWeatherViewController else {
            return
        }
        let configurator: DetailsWeatherConfiguratorInputProtocol = DetailsWeatherConfigurator()
        configurator.configure(withView: detailsVC, and: sender as! City)
    }
    
    @IBAction func addCity(_ sender: UIBarButtonItem) {
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
                    let city = City(name: cityName)
                    self.presenter.addCity(city)
                }
            )
        )
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = cities[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = city.name
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let city = cities[indexPath.row]
        presenter.showDetailsWeather(city)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let city = cities[indexPath.row]
            presenter.removeCity(city)
        }
    }
}

// MARK: - CitiesListViewInputProtocol
extension CitiesListViewController: CitiesListViewInputProtocol {
    func showCities(_ cities: [City]) {
        self.cities = cities
    }
}
