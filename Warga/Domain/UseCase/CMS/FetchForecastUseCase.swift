//
//  FetchForecastUseCase.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 18/10/21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation
import RxSwift

public struct FetchForecastUseCaseResponse {
    
}

public struct FetchForecastUseCaseRequest {
    var lat: Double
    var lon: Double
}

public protocol FetchForecastUseCase {
    func execute(_ request: FetchForecastUseCaseRequest) -> Observable<ForecastInfoDomain>
}

public final class DefaultFetchForecastUseCase {

    let cmsRepository: CMSRepository
    
    public init(
        cmsRepository: CMSRepository
    ) {
        self.cmsRepository = cmsRepository
    }

}

extension DefaultFetchForecastUseCase: FetchForecastUseCase {

    public func execute(_ request: FetchForecastUseCaseRequest) -> Observable<ForecastInfoDomain> {
        return self.cmsRepository.fetchForecast(lat: request.lat, lon: request.lon)
    }
    
}
