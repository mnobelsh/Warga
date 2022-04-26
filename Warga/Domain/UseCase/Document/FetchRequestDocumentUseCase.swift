//
//  FetchRequestDocumentUseCase.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation


public struct FetchRequestDocumentUseCaseResponse {
    
}

public struct FetchRequestDocumentUseCaseRequest {
    var profileId: String
}

public protocol FetchRequestDocumentUseCase {
    func execute(_ request: FetchRequestDocumentUseCaseRequest,
                 completion: @escaping (Result<RequestDocumentDTO?, Error>) -> Void)
}

public final class DefaultFetchRequestDocumentUseCase {

    let firebaseRepository: FirestoreRepository
    
    public init(
        firebaseRepository: FirestoreRepository
    ) {
        self.firebaseRepository = firebaseRepository
    }

}

extension DefaultFetchRequestDocumentUseCase: FetchRequestDocumentUseCase {

    public func execute(_ request: FetchRequestDocumentUseCaseRequest,
                        completion: @escaping (Result<RequestDocumentDTO?, Error>) -> Void) {
        self.firebaseRepository.fetchRealtimeDocument(withDocumentPath: request.profileId, of: RequestDocumentDTO.self, from: .requestDocumentPool, completion: completion)
        
    }
    
}
