//
//  ForecastAPINetworkService.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 18/10/21.
//

import Foundation
import Alamofire
import RxSwift

public protocol ForecastAPINetworkService {
    func fetchWeather(request: URLRequestConvertible) -> Observable<CMSAPIEndPoint.FetchForecastDTO.Response.Body>
}

public struct DefaultForecastAPINetworkService {
    
    var networkService: NetworkServiceProtocol
    static let baseUrl = AppConfiguration.shared.openWeatherMapAPIBaseUrl
    static let imageBaseUrl = AppConfiguration.shared.openWeatherMapImageAPIEndPoint
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
}

extension DefaultForecastAPINetworkService: ForecastAPINetworkService {
    
    public func fetchWeather(request: URLRequestConvertible) -> Observable<CMSAPIEndPoint.FetchForecastDTO.Response.Body> {
        return self.networkService.sendRequest(with: request)
    }
    
}

