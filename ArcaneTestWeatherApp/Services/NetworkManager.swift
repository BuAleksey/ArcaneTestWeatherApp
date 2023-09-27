//
//  NetworkManager.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private let api = "https://api.openweathermap.org/data/2.5/weather?q=Moscow&apikey=358389cc2e7b7f987ac85f1075b911c6&units=metric"
    
    private init() {}
    
    func fetchData(completion: @escaping (_ weather: CityWeather) -> Void) {
        guard let url = URL(string: api) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No Description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weather = try decoder.decode(CityWeather.self, from: data)
                DispatchQueue.main.async {
                    completion(weather)
                }
            } catch let error {
                print("Error serialization json", error)
            }
            
        }.resume()
    }
}
