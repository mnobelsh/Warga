//
//  NewsAPINetworkService.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/10/21.
//

import Foundation
import Alamofire
import RxSwift

public protocol NewsAPINetworkService {
    func fetchNews(request: URLRequestConvertible) -> Observable<CMSAPIEndPoint.FetchNewsDTO.Response.Body>
}

public struct DefaultNewsAPINetworkService {
    
    var networkService: NetworkServiceProtocol
    static let baseUrl = AppConfiguration.shared.newsAPIBaseUrl
    
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    
}

extension DefaultNewsAPINetworkService: NewsAPINetworkService {
    
    public func fetchNews(request: URLRequestConvertible) -> Observable<CMSAPIEndPoint.FetchNewsDTO.Response.Body> {
        return self.networkService.sendRequest(with: request)
    }
    
}
