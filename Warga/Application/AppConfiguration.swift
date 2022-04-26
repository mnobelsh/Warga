//
//  AppConfiguration.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//

import Foundation


public struct AppConfiguration {
    
    static let shared = AppConfiguration()
    
    public var newsAPIBaseUrl: String = {
        guard let endpoint = Bundle.main.object(forInfoDictionaryKey: "APIEndPoint") as? [String: String], let baseUrl = endpoint["NewsAPIEndPoint"] else {
            fatalError("Unable to find news base url.")
        }
        return baseUrl
    }()
    
    public var openWeatherMapAPIBaseUrl: String = {
        guard let endpoint = Bundle.main.object(forInfoDictionaryKey: "APIEndPoint") as? [String: String], let baseUrl = endpoint["OpenWeatherMapAPIEndPoint"] else {
            fatalError("Unable to find weather base url.")
        }
        return baseUrl
    }()
    
    public var openWeatherMapImageAPIEndPoint: String = {
        guard let endpoint = Bundle.main.object(forInfoDictionaryKey: "APIEndPoint") as? [String: String], let baseUrl = endpoint["OpenWeatherMapImageAPIEndPoint"] else {
            fatalError("Unable to find weather image base url.")
        }
        return baseUrl
    }()
    
    public var openWeatherMapAPIKey: String = {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "APIKey") as? [String: String], let apiKey = apiKey["OpenWeatherMap"] else {
            fatalError("Unable to find OpenWeatherMap API Key.")
        }
        return apiKey
    }()
    
}
