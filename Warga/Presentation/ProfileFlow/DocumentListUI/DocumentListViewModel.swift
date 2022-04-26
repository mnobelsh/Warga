//
//  DocumentListViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//  Copyright (c) 2022 All rights reserved.

import Foundation
import RxSwift
import RxRelay

// MARK: DocumentListViewModelResponse
public enum DocumentListViewModelResponse {
}

// MARK: DocumentListViewModelDelegate
public protocol DocumentListViewModelDelegate: AnyObject {
}

// MARK: - DocumentListViewModelRequestValue
public struct DocumentListViewModelRequestValue {
}

// MARK: - DocumentListViewModelRoute
public struct DocumentListViewModelRoute {
    var startDocumentFlow: (_ instructor: DocumentFlowCoordinatorInstructor) -> Void
}

// MARK: - DocumentListViewModelInput
public protocol DocumentListViewModelInput {
    func viewDidLoad()
    func reloadData()
    func didSelectDocument(document: DocumentDTO)
}

// MARK: - DocumentListViewModelOutput
public protocol DocumentListViewModelOutput {
    var displayedDocuments: PublishRelay<[DocumentDTO]> { get }
}

// MARK: - DocumentListViewModel
public protocol DocumentListViewModel: DocumentListViewModelInput, DocumentListViewModelOutput { }

// MARK: - DefaultDocumentListViewModel
public final class DefaultDocumentListViewModel: DocumentListViewModel {

    // MARK: Dependency Variable
    weak var delegate: DocumentListViewModelDelegate?
    let requestValue: DocumentListViewModelRequestValue
    let route: DocumentListViewModelRoute

    // MARK: Output ViewModel Variable
    public let displayedDocuments = PublishRelay<[DocumentDTO]>()
    
    private let fetchUserProfileUseCase: FetchUserProfileUseCase

    init(
        requestValue: DocumentListViewModelRequestValue,
        route: DocumentListViewModelRoute,
        fetchUserProfileUseCase: FetchUserProfileUseCase
    ) {
        self.requestValue = requestValue
        self.route = route
        self.fetchUserProfileUseCase = fetchUserProfileUseCase
    }

}

// MARK: Input ViewModel Function
public extension DefaultDocumentListViewModel {

    func viewDidLoad() {
        self.reloadData()
    }

    func reloadData() {
        guard let id = UserPreference.shared.currentProfile?.id else { return }
        let requestValue = FetchUserProfileUseCaseRequest(parameter: .byId(id))
        self.fetchUserProfileUseCase.execute(requestValue) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                self.displayedDocuments.accept(profile?.dokumen ?? [])
            case .failure:
                break
            }
        }
    }
    
    public func didSelectDocument(document: DocumentDTO) {
        let requestValue = ViewDocumentViewModelRequestValue(documents: [document])
        self.route.startDocumentFlow(.viewDocument(requestValue: requestValue))
    }
}

// MARK: Private Function
private extension DefaultDocumentListViewModel {

}
