//
//  CMSRepository.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/10/21.
//

import Foundation
import RxSwift

public protocol CMSRepository {
    func fetchNews(from source: String) -> Observable<[NewsDomain]>
    func fetchForecast(lat: Double, lon: Double) -> Observable<ForecastInfoDomain>
}

public class DefaultCMSRepository {
    
    let newsStorage: NewsStorage
    let forecastStorage: ForecastStorage
    
    init(
        newsStorage: NewsStorage,
        weatherStorage: ForecastStorage
    ) {
        self.newsStorage = newsStorage
        self.forecastStorage = weatherStorage
    }
    
}

extension DefaultCMSRepository: CMSRepository {

    
    public func fetchNews(from source: String) -> Observable<[NewsDomain]> {
        return self.newsStorage.fetchNews(from: source).map { $0.data.map { $0.toDomain() } }
    }
    
    public func fetchForecast(lat: Double, lon: Double) -> Observable<ForecastInfoDomain> {
        return self.forecastStorage.fetchForecast(lat: lat, lon: lon).map { $0.toDomain() }
    }
    
    
}

