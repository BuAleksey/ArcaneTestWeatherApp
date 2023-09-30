//
//  DetailsViewController.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import UIKit

protocol DetailsWeatherViewInputProtocol: AnyObject {
    func showWeatherForTooday(_ weather: [DetailsWether])
    func showWeatherForNextDay(_ weather: [DetailsWether])
    func showErrorMasage(_ message: String)
}

protocol DetailsWeatherViewOutputProtocol {
    init(view: DetailsWeatherViewInputProtocol)
    func viewDidAppear()
    func showMoreDays()
}

final class DetailsWeatherViewController: UITableViewController {
    var presenter: DetailsWeatherViewOutputProtocol!
    var showingMoreWeather = false {
        didSet {
            setupNavigationBar()
        }
    }

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    private var days: [DetailsWether] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidAppear()

        tableView.register(DetailsWeatherViewCell.self, forCellReuseIdentifier: "detailWeatherCell")
        tableView.separatorStyle = .none
        
        setupConstraints()
        activityIndicator.startAnimating()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        days.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailWeatherCell", for: indexPath) as! DetailsWeatherViewCell
        let day = days[indexPath.row]
        cell.detailsWeather = day
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func setupConstraints() {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let city = days.first?.city
        navigationItem.title = city
        
        let moreBtn = UIBarButtonItem(
            title: showingMoreWeather ? "Today" : "More",
            style: .plain,
            target: self,
            action: #selector(showMore)
        )
        navigationItem.rightBarButtonItem = moreBtn
    }
    
    @objc private func showMore() {
        if showingMoreWeather {
            presenter.viewDidAppear()
            showingMoreWeather.toggle()
        } else {
            presenter.showMoreDays()
            showingMoreWeather.toggle()
        }
    }
}

// MARK: - DetailsWeatherViewInputProtocol
extension DetailsWeatherViewController: DetailsWeatherViewInputProtocol {
    func showWeatherForTooday(_ weather: [DetailsWether]) {
        days = weather
        activityIndicator.stopAnimating()
        setupNavigationBar()
    }
    
    func showWeatherForNextDay(_ weather: [DetailsWether]) {
        activityIndicator.startAnimating()
        days.removeAll()
        days = weather
        activityIndicator.stopAnimating()
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
