//
//  ForecastDomain.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 18/10/21.
//

import Foundation

public struct ForecastInfoDomain {
    var lat: Double
    var lon: Double
    var timeZone: String
    var currentForecast: ForecastDomain
    var hourlyForecasts: [ForecastDomain]
}

public struct ForecastDomain {
    var date: Date
    var temp: Double
    var weather: WeatherDomain
}

public struct WeatherDomain {
    
    public enum Condition {
        case thunderStorm
        case drizzle
        case rain
        case snow
        case athmosphere
        case clear
        case clouds
    }
    
    var id: Int
    var main: String
    var title: String
    var icon: String
    var condition: Condition
    var description: String
    
    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.title = description
        self.icon = icon
        self.description = ""
        switch id {
        case 200...232:
            self.condition = .thunderStorm
            self.description = "Petir, kilat, atau halilintar mungkin kerap muncul di wilayan anda. Tetap berhati-hati."
        case 300...321:
            self.condition = .drizzle
            self.description = "Cuaca berembun menyebabkan lingkungan sekitar lebih lembab. Tetap beraktivitas dengan jagalah kesehatan."
        case 500...531:
            self.condition = .rain
            self.description = "Hujan mungkin kerap turun di wilayah anda. Tetap berhati-hati dan jagalah kesehatan."
        case 600...622:
            self.condition = .snow
        case 700...781:
            self.condition = .athmosphere
            self.description = "Cuaca berkabut, jarak pandang anda mungkin terganggu. Tetap berhati-hati dan jagalah kesehatan."
        case 801...804:
            self.condition = .clouds
            self.description = "Cuaca berawan. Tetap bersiaga akan datangnya hujan dan jagalah kesehatan."
        default:
            self.condition = .clear
            self.description = "Cuaca cerah, Selamat menjalankan aktivitas dan tetap jaga kesehatan."
        }
    }
}
