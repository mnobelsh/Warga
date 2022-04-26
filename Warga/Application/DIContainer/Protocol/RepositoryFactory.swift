//
//  RepositoryFactory.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//

import Foundation

public protocol RepositoryFactory {
    
    func makeFirebaseRepository() -> FirestoreRepository
    func makeCMSRepository() -> CMSRepository
    
}
