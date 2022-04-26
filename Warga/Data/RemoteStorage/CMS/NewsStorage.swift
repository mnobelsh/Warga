//
//  NewsStorage.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/10/21.
//

import Foundation
import RxSwift

public protocol NewsStorage {
    func fetchNews(from source: String) -> Observable<CMSAPIEndPoint.FetchNewsDTO.Response.Body>
}

public struct DefaultNewsStorage {
    
    let newsNetworkService: NewsAPINetworkService
    
    init(newsNetworkService: NewsAPINetworkService) {
        self.newsNetworkService = newsNetworkService
    }
    
}

extension DefaultNewsStorage: NewsStorage {
    
    public func fetchNews(from source: String) -> Observable<CMSAPIEndPoint.FetchNewsDTO.Response.Body> {
        let path = CMSAPIEndPoint.FetchNewsDTO.path(source: source)
        let request = URLRequestBuilder(with: DefaultNewsAPINetworkService.baseUrl, path: path, method: .get)
        return self.newsNetworkService.fetchNews(request: request.build())
    }
    
}
