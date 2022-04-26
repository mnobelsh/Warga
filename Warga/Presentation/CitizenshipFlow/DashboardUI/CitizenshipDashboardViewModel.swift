//
//  CitizenshipDashboardViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation
import RxRelay

// MARK: CitizenshipDashboardViewModelResponse
public enum CitizenshipDashboardViewModelResponse {
}

// MARK: CitizenshipDashboardViewModelDelegate
public protocol CitizenshipDashboardViewModelDelegate: AnyObject {
}

// MARK: - CitizenshipDashboardViewModelRequestValue
public struct CitizenshipDashboardViewModelRequestValue {
}

// MARK: - CitizenshipDashboardViewModelRoute
public struct CitizenshipDashboardViewModelRoute {
    var startCitzenshipFlow: (_ instructor: CitizenshipFlowCoordinatorInstructor) -> Void
}

// MARK: - CitizenshipDashboardViewModelInput
public protocol CitizenshipDashboardViewModelInput {
    func viewDidLoad()
    func showDocumentDetailUI(selectedDocument: DocumentDomain)
}

// MARK: - CitizenshipDashboardViewModelOutput
public protocol CitizenshipDashboardViewModelOutput {
    var requestedDocument: PublishRelay<RequestDocumentDTO?> { get }
}

// MARK: - CitizenshipDashboardViewModel
public protocol CitizenshipDashboardViewModel: CitizenshipDashboardViewModelInput, CitizenshipDashboardViewModelOutput { }

// MARK: - DefaultCitizenshipDashboardViewModel
public final class DefaultCitizenshipDashboardViewModel: CitizenshipDashboardViewModel {

    // MARK: Dependency Variable
    weak var delegate: CitizenshipDashboardViewModelDelegate?
    let requestValue: CitizenshipDashboardViewModelRequestValue
    let route: CitizenshipDashboardViewModelRoute

    // MARK: Output ViewModel Variable
    public let requestedDocument = PublishRelay<RequestDocumentDTO?>()
    
    private let fetchRequestDocumentUseCase: FetchRequestDocumentUseCase

    init(
        requestValue: CitizenshipDashboardViewModelRequestValue,
        route: CitizenshipDashboardViewModelRoute,
        fetchRequestDocumentUseCase: FetchRequestDocumentUseCase
    ) {
        self.requestValue = requestValue
        self.route = route
        self.fetchRequestDocumentUseCase = fetchRequestDocumentUseCase
    }

}

// MARK: Input ViewModel Function
public extension DefaultCitizenshipDashboardViewModel {

    func viewDidLoad() {
        guard let profileId = UserPreference.shared.currentProfile?.id else { return }
        self.fetchRequestDocumentUseCase.execute(.init(profileId: profileId)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let document):
                self.requestedDocument.accept(document)
            case .failure:
                self.requestedDocument.accept(nil)
            }
        }
    }
    
    func  showDocumentDetailUI(selectedDocument: DocumentDomain) {
        let requestValue = DocumentDetailViewModelRequestValue(document: selectedDocument)
        self.route.startCitzenshipFlow(.documentDetail(requestValue: requestValue))
    }

}

// MARK: Private Function
private extension DefaultCitizenshipDashboardViewModel {

}
