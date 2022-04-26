//
//  SaveUserProfileUseCase.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/09/21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

public struct SaveUserProfileUseCaseResponse {
    
}

public struct SaveUserProfileUseCaseRequest {
    enum Operation {
        case update
        case add
    }
    
    let profile: ProfileDTO
    let operation: Operation
}

public protocol SaveUserProfileUseCase {
    func execute(_ request: SaveUserProfileUseCaseRequest, completion: @escaping(Result<ProfileDTO, Error>) -> Void)
}

public final class DefaultSaveUserProfileUseCase {

    let firebaseRepository: FirestoreRepository
    
    public init(
        firebaseRepository: FirestoreRepository
    ) {
        self.firebaseRepository = firebaseRepository
    }

}

extension DefaultSaveUserProfileUseCase: SaveUserProfileUseCase {

    public func execute(_ request: SaveUserProfileUseCaseRequest, completion: @escaping (Result<ProfileDTO, Error>) -> Void) {
        self.firebaseRepository.fetchOneTimeDocument(of: ProfileDTO.self, from: .users, whereField: ProfileDTO.nik, isEqualTo: request.profile.nik) { [weak self] result in
            guard let self = self else { return}
            switch result {
            case .success(let profile):
                guard let existingProfile = profile else {
                    self.firebaseRepository.save(request.profile, withDocumentPath: request.profile.id, to: .users, completion: completion)
                    return
                }
                switch request.operation {
                case .add:
                    let error = NSError(domain: "DefaultSaveUserProfileUseCase", code: 0, userInfo: ["message": "user.exist"])
                    completion(.failure(error))
                case .update:
                    let updatedProfile = existingProfile.synchronize(with: request.profile)
                    self.firebaseRepository.save(updatedProfile, withDocumentPath: updatedProfile.id, to: .users, completion: completion)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}
