//
//  AppDIContainer+UseCaseFactory.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//

import Foundation

extension AppDICointainer: UseCaseFactory {

    public func makeSaveUserProfileUseCase() -> SaveUserProfileUseCase {
        return DefaultSaveUserProfileUseCase(firebaseRepository: self.makeFirebaseRepository())
    }
    
    public func makeFetchUserProfileUseCase() -> FetchUserProfileUseCase {
        return DefaultFetchUserProfileUseCase(firebaseRepository: self.makeFirebaseRepository())
    }
    
    public func makeFetchNewsUseCase() -> FetchNewsUseCase {
        return DefaultFetchNewsUseCase(cmsRepository: self.makeCMSRepository())
    }
    
    public func makeFetchForecastUseCase() -> FetchForecastUseCase {
        return DefaultFetchForecastUseCase(cmsRepository: self.makeCMSRepository())
    }
    
    public func makeRequestDocumentUseCase() -> RequestDocumentUseCase {
        return DefaultRequestDocumentUseCase(firebaseRepository: self.makeFirebaseRepository())
    }
    
    public func makeFetchRequestDocumentUseCase() -> FetchRequestDocumentUseCase {
        return DefaultFetchRequestDocumentUseCase(firebaseRepository: self.makeFirebaseRepository())
    }
    
    
}
