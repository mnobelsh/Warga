//
//  NetworkService.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/10/21.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

public protocol NetworkServiceProtocol {
    
    func sendRequest<T: Codable>(with request: URLRequestConvertible) -> Observable<T>
    
}

public struct NetworkService: NetworkServiceProtocol {
    
    static let shared = NetworkService()
    
    var session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 45
        return Session(configuration: config)
    }()
    
}

extension NetworkService {
    
    public func sendRequest<T: Codable>(with request: URLRequestConvertible) -> Observable<T> {
        return self.session
            .rx
            .request(urlRequest: request)
            .observe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .validate(statusCode: 200..<300)
            .flatMap { 
                $0.rx.decodable()
            }
            
    }
    
}
