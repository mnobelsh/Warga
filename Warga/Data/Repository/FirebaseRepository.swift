//
//  FirebaseRepository.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/09/21.
//

import Foundation
import RxSwift

public protocol FirebaseRepository {
    func saveUser(_ user: UserDTO, completion: @escaping((Result<UserDTO, Error>) -> Void))
}

public class DefaultFirebaseRepository: FirebaseRepository {
    
    let firestoreStorage: FirebaseFirestoreStorage
    
    init(
        firestoreStorage: FirebaseFirestoreStorage
    ) {
        self.firestoreStorage = firestoreStorage
    }
    
}

extension DefaultFirebaseRepository {
    
    public func saveUser(_ user: UserDTO, completion: @escaping ((Result<UserDTO, Error>) -> Void)) {
        firestoreStorage.setData(from: user, to: .users, completion: completion)
    }
    
}
