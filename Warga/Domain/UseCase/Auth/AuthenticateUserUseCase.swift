//
//  AuthenticateUserUseCase.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 06/02/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation


public struct AuthenticateUserUseCaseResponse {
    
}

public struct AuthenticateUserUseCaseRequest {
    var nik: String
    var password: String
}

public protocol AuthenticateUserUseCase {
    func execute(_ request: AuthenticateUserUseCaseRequest,
                 completion: @escaping (Result<AuthenticateUserUseCaseResponse, Error>) -> Void)
}

public final class DefaultAuthenticateUserUseCase {

    public init() {
    }

}

extension DefaultAuthenticateUserUseCase: AuthenticateUserUseCase {

    public func execute(_ request: AuthenticateUserUseCaseRequest,
                        completion: @escaping (Result<AuthenticateUserUseCaseResponse, Error>) -> Void) {
        
    }
    
}
