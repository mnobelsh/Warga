//
//  ForecastStorage.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 18/10/21.
//

import Foundation
import RxSwift

public protocol ForecastStorage {
    func fetchForecast(lat: Double, lon: Double) -> Observable<CMSAPIEndPoint.FetchForecastDTO.Response.Body>
}

public struct DefaultForecastStorage {
    
    let weatherNetworkService: ForecastAPINetworkService
    
    init(weatherNetworkService: ForecastAPINetworkService) {
        self.weatherNetworkService = weatherNetworkService
    }
    
}

extension DefaultForecastStorage: ForecastStorage {
    
    public func fetchForecast(lat: Double, lon: Double) -> Observable<CMSAPIEndPoint.FetchForecastDTO.Response.Body> {
        let path = CMSAPIEndPoint.FetchForecastDTO.path
        let parameters = CMSAPIEndPoint.FetchForecastDTO.Request.Parameters(lat: lat, lon: lon).get()
        let request = URLRequestBuilder(with: DefaultForecastAPINetworkService.baseUrl, path: path, method: .get)
        request.addParameter(parameters)
        return self.weatherNetworkService.fetchWeather(request: request.build())
    }
    
}

