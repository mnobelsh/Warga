//
//  FetchUserProfileUseCase.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/09/21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

public struct FetchUserProfileUseCaseResponse {
    
}

public struct FetchUserProfileUseCaseRequest {
    
    public enum FetchParameter {
        case byNIK(String)
        case byId(String)
        case byPhoneNumber(String)
    }
    
    
    let parameter: FetchParameter
}

public protocol FetchUserProfileUseCase {
    func execute(_ request: FetchUserProfileUseCaseRequest, completion: @escaping(Result<ProfileDTO?, Error>) -> Void)
}

public final class DefaultFetchUserProfileUseCase {
    
    let firebaseRepository: FirestoreRepository

    public init(
        firebaseRepository: FirestoreRepository
    ) {
        self.firebaseRepository = firebaseRepository
    }

}

extension DefaultFetchUserProfileUseCase: FetchUserProfileUseCase {

    public func execute(_ request: FetchUserProfileUseCaseRequest, completion: @escaping(Result<ProfileDTO?, Error>) -> Void) {
        var field: String
        var query: String
        switch request.parameter {
        case .byId(let id):
            field = ProfileDTO.id
            query = id
        case .byNIK(let nik):
            field = ProfileDTO.nik
            query = nik
        case .byPhoneNumber(let phone):
            field = ProfileDTO.nomorTelepon
            query = phone
        }
        self.firebaseRepository.fetchRealtimeDocument(of: ProfileDTO.self, from: .users, whereField: field, isEqualTo: query, completion: completion)
    }
    
}
