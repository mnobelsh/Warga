//
//  FetchNewsUseCase.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/10/21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation
import RxSwift

public struct FetchNewsUseCaseResponse {
    
}

public struct FetchNewsUseCaseRequest {
    public enum Source: String {
        case cnbc = "cnbc"
        case kumparan = "kumparan"
        case tempo = "tempo"
    }
    var source: Source
}

public protocol FetchNewsUseCase {
    func execute(_ request: FetchNewsUseCaseRequest) -> Observable<[NewsDomain]>
}

public final class DefaultFetchNewsUseCase {

    let cmsRepository: CMSRepository
    
    public init(
        cmsRepository: CMSRepository
    ) {
        self.cmsRepository = cmsRepository
    }

}

extension DefaultFetchNewsUseCase: FetchNewsUseCase {

    public func execute(_ request: FetchNewsUseCaseRequest) -> Observable<[NewsDomain]> {
        return self.cmsRepository.fetchNews(from: request.source.rawValue)
    }
    
}
