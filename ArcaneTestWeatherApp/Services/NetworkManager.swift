//
//  NetworkManager.swift
//  ArcaneTestWeatherApp
//
//  Created by Buba on 26.09.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    var apiConfigurator = APIConfigurator.shared
    private init() {}
    
    func fetchData(city: String,completion: @escaping (Result<CityWeather, Error>) -> Void) {
            guard let url = URL(string: apiConfigurator.getAPIForCity(city: city)) else { return }
        
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
                    completion(.success(weather))
                }
            } catch let error {
                completion(.failure(error))
                print("Error serialization json", error)
            }
        }.resume()
    }
}
