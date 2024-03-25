//
//  NetworkService.swift
//  WeatherVK
//
//  Created by Admin on 23.03.2024.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    func getWeather(city: String, completion: @escaping (WetherAPI) -> Void) {
        let urlString = urlString(city: city)
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            if let weatherAPI = try? JSONDecoder().decode(WetherAPI.self, from: data) {
                completion(weatherAPI)
            } else {
                print("FAIL")
            }
        }
        task.resume()
    }
    
    private func urlString(city: String) -> String {
        
        var cityOk = ""
        
        for elem in city {
            if elem == " " {
                cityOk += "%20"
            } else {
                cityOk += String(elem)
            }
        }
        
        let baseString = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityOk)&lang=ru&appid=3d4db0d78f0ee1411950d8397a7ce860"
        
        return baseString
    }
}


