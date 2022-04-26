//
//  AppDIContainer+RepositoryFactory.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/09/21.
//

import Foundation

extension AppDICointainer: RepositoryFactory {
    
    public func makeCMSRepository() -> CMSRepository {
        return DefaultCMSRepository(newsStorage: self.newsStorage, weatherStorage: self.weatherStorage)
    }
    
    public func makeFirebaseRepository() -> FirestoreRepository {
        return DefaultFirestoreRepository(firestoreStorage: self.firestoreStorage)
    }
}
