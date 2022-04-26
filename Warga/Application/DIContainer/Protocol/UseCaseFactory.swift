//
//  UseCaseFactory.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//

import Foundation

public protocol UseCaseFactory {
    func makeSaveUserProfileUseCase() -> SaveUserProfileUseCase
    func makeFetchUserProfileUseCase() -> FetchUserProfileUseCase
    func makeFetchNewsUseCase() -> FetchNewsUseCase
    func makeFetchForecastUseCase() -> FetchForecastUseCase
    func makeRequestDocumentUseCase() -> RequestDocumentUseCase
    func makeFetchRequestDocumentUseCase() -> FetchRequestDocumentUseCase
}
