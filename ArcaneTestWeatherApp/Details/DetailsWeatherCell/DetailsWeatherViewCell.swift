//
//  DetailsWeatherViewCell.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 30.09.2023.
//

import UIKit

final class DetailsWeatherViewCell: UITableViewCell {
    var detailsWeather: DetailsWether? {
        didSet {
            dateLabel.text = detailsWeather?.date
            imageWeather.image = UIImage(systemName: detailsWeather?.image ?? "")
            tempLabel.text = detailsWeather?.temp
            windLabel.text = detailsWeather?.wind
        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let imageWeather: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .darkGray
        return image
    }()
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    private let windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        containerView.addSubview(dateLabel)
        containerView.addSubview(imageWeather)
        containerView.addSubview(tempLabel)
        containerView.addSubview(windLabel)
        contentView.addSubview(containerView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
            imageWeather.leadingAnchor.constraint(equalTo: centerXAnchor, constant: -30),
            tempLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 30),
            windLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -6)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
