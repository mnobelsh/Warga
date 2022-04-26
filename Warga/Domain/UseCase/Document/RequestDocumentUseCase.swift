//
//  RequestDocumentUseCase.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation


public struct RequestDocumentUseCaseResponse {
    
}

public struct RequestDocumentUseCaseRequest {
    var requestDocument: RequestDocumentDTO
}

public protocol RequestDocumentUseCase {
    func execute(_ request: RequestDocumentUseCaseRequest,
                 completion: @escaping (Result<RequestDocumentDTO, Error>) -> Void)
}

public final class DefaultRequestDocumentUseCase {
    
    let firebaseRepository: FirestoreRepository
    
    public init(
        firebaseRepository: FirestoreRepository
    ) {
        self.firebaseRepository = firebaseRepository
    }

}

extension DefaultRequestDocumentUseCase: RequestDocumentUseCase {

    public func execute(_ request: RequestDocumentUseCaseRequest,
                        completion: @escaping (Result<RequestDocumentDTO, Error>) -> Void) {
        self.firebaseRepository.save(request.requestDocument, withDocumentPath: request.requestDocument.profileId, to: .requestDocumentPool, completion: completion)
    }
    
}
