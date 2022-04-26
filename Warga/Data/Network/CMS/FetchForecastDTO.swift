//
//  FetchForecastDTO.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 18/10/21.
//

import Foundation

public extension CMSAPIEndPoint {
    
    struct FetchForecastDTO {
        
        static let path: String = "onecall"
        
        public struct Request {
            var parameters: Parameters
        }
        
        public struct Response {
            var body: Body
        }
        
    }
    
}

extension CMSAPIEndPoint.FetchForecastDTO.Request {
    
    public struct Parameters {
        var lat: Double
        var lon: Double
        var appId: String = AppConfiguration.shared.openWeatherMapAPIKey
        var units: String = "metric"
        var exclude: String = ["minutely","daily"].joined(separator: ",")
        var lang: String = "id"
        
        public func get() -> [String: Any] {
            return [
                "lat": self.lat,
                "lon": self.lon,
                "appid": self.appId,
                "units": self.units,
                "exclude": self.exclude,
                "lang": self.lang
            ]
        }
    }
    
    
}

extension CMSAPIEndPoint.FetchForecastDTO.Response {
    
    public struct Body: Codable {
        var lat: Double
        var lon: Double
        var timezone: String
        var current: ForecastDTO
        var hourly: [ForecastDTO]
        
        public func toDomain() -> ForecastInfoDomain {
            return ForecastInfoDomain(lat: self.lat, lon: self.lon, timeZone: self.timezone, currentForecast: self.current.toDomain(), hourlyForecasts: self.hourly.map{ $0.toDomain() } )
        }
    }
    
    public struct ForecastDTO: Codable {
        var dt: Int
        var temp: Double
        var weather: [WeatherDTO]
        
        public func toDomain() -> ForecastDomain {
            return ForecastDomain(date: Date(timeIntervalSince1970: TimeInterval(self.dt)), temp: self.temp, weather: self.weather[0].toDomain())
        }
    }
    
    public struct WeatherDTO: Codable {
        var id: Int
        var main: String
        var description: String
        var icon: String
        
        public func toDomain() -> WeatherDomain {
            return WeatherDomain(id: self.id, main: self.main, description: self.description, icon: self.icon)
        }
    }
    
}


