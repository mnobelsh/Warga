//
//  RequestDocumentViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//  Copyright (c) 2022 All rights reserved.

import UIKit
import RxRelay
import UIKit

// MARK: RequestDocumentViewModelResponse
public enum RequestDocumentViewModelResponse {
    case requestDocumentDidSuccess
    case requestDocumentDidFail
}

// MARK: RequestDocumentViewModelDelegate
public protocol RequestDocumentViewModelDelegate: AnyObject {
}

// MARK: - RequestDocumentViewModelRequestValue
public struct RequestDocumentViewModelRequestValue {
    var document: DocumentDomain
}

// MARK: - RequestDocumentViewModelRoute
public struct RequestDocumentViewModelRoute {
    var startDocumentFlow: (_ instructor: DocumentFlowCoordinatorInstructor) -> Void
    var startDialogFlow: (_ instructor: DialogFlowCoordinatorInstructor) -> Void
}

// MARK: - RequestDocumentViewModelInput
public protocol RequestDocumentViewModelInput {
    func viewDidLoad()
    func showScanDocumentUI(presentingController: UIViewController, requestValue: ScanDocumentViewModelRequestValue)
    func doUpdateProfile(newProfile: ProfileDTO)
    func doRequestDocument()
}

// MARK: - RequestDocumentViewModelOutput
public protocol RequestDocumentViewModelOutput {
    var document: DocumentDomain { get }
    var response: PublishRelay<RequestDocumentViewModelResponse> { get }
    var displayedRequiredDocuments: PublishRelay<[DocumentRequiredDomain]> { get }
}

// MARK: - RequestDocumentViewModel
public protocol RequestDocumentViewModel: RequestDocumentViewModelInput, RequestDocumentViewModelOutput { }

// MARK: - DefaultRequestDocumentViewModel
public final class DefaultRequestDocumentViewModel: RequestDocumentViewModel {

    // MARK: Dependency Variable
    weak var delegate: RequestDocumentViewModelDelegate?
    let requestValue: RequestDocumentViewModelRequestValue
    let route: RequestDocumentViewModelRoute
   
    // MARK: Output ViewModel Variable
    public var document: DocumentDomain
    public let response = PublishRelay<RequestDocumentViewModelResponse>()
    public let displayedRequiredDocuments = PublishRelay<[DocumentRequiredDomain]>()
    
    private let fetchUserProfileUseCase: FetchUserProfileUseCase
    private let saveUserProfileUseCase: SaveUserProfileUseCase
    private let requestDocumentUseCase: RequestDocumentUseCase

    init(
        requestValue: RequestDocumentViewModelRequestValue,
        route: RequestDocumentViewModelRoute,
        fetchUserProfileUseCase: FetchUserProfileUseCase,
        saveUserProfileUseCase: SaveUserProfileUseCase,
        requestDocumentUseCase: RequestDocumentUseCase
    ) {
        self.requestValue = requestValue
        self.route = route
        self.document = requestValue.document
        self.fetchUserProfileUseCase = fetchUserProfileUseCase
        self.saveUserProfileUseCase = saveUserProfileUseCase
        self.requestDocumentUseCase = requestDocumentUseCase
    }

}

// MARK: Input ViewModel Function
public extension DefaultRequestDocumentViewModel {

    func viewDidLoad() {
        self.reloadDocumentsData()
    }
    
    func showScanDocumentUI(presentingController: UIViewController, requestValue: ScanDocumentViewModelRequestValue) {
        self.route.startDocumentFlow(.scanDocument(presentingController: presentingController, requestValue: requestValue))
    }

    
    func doUpdateProfile(newProfile: ProfileDTO) {
        let requestValue = SaveUserProfileUseCaseRequest(profile: newProfile, operation: .update)
        self.saveUserProfileUseCase.execute(requestValue) { result in
            switch result {
            case .success(let profile):
                UserPreference.shared.currentProfile = profile
                self.reloadDocumentsData()
            case .failure:
                break
            }
        }
    }
    
    func doRequestDocument() {
        guard let profileId = UserPreference.shared.currentProfile?.id else { return }
        let requestDocument = RequestDocumentDTO(
            documentId: self.requestValue.document.id,
            profileId: profileId,
            status: RequestDocumentStatus.requested.rawValue
        )
        let requestValue = RequestDocumentUseCaseRequest(requestDocument: requestDocument)
        self.requestDocumentUseCase.execute(requestValue) { [weak self] result in
            guard let self = self else { return }
            var alertDialogRequestValue: AlertDialogViewRequestValue
            switch result {
            case .success:
                alertDialogRequestValue = AlertDialogViewRequestValue(alertType: .success, title: "Sukses melakukan pengajuan dokumen")
                self.response.accept(.requestDocumentDidSuccess)
            case .failure:
                alertDialogRequestValue = AlertDialogViewRequestValue(alertType: .failure, title: "Gagal melakukan pengajuan dokumen")
                self.response.accept(.requestDocumentDidFail)
            }
            self.route.startDialogFlow(.alert(requestValue: alertDialogRequestValue))
        }
    }
}

// MARK: Private Function
private extension DefaultRequestDocumentViewModel {
    
    func reloadDocumentsData() {
        guard let id = UserPreference.shared.currentProfile?.id else { return }
        let requestValue = FetchUserProfileUseCaseRequest(parameter: .byId(id))
        self.fetchUserProfileUseCase.execute(requestValue) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                UserPreference.shared.currentProfile = profile
                guard let userDocuments = profile?.dokumen else { return }
                self.setExistingDocuments(documents: userDocuments)
            case .failure:
                break
            }
        }
    }

    func setExistingDocuments(documents: [DocumentDTO]) {
        let dispatchGroup = DispatchGroup()
        self.document.requiredDocuments.forEach { doc in
            dispatchGroup.enter()
            guard let userDoc = documents.first(where: { $0.id == doc.type.id }) else {
                doc.base64EncodedContent = nil
                doc.isUserOwned = false
                dispatchGroup.leave()
                return
            }
            doc.isUserOwned = true
            doc.base64EncodedContent = userDoc.base64EncodedString
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            self.displayedRequiredDocuments.accept(self.document.requiredDocuments.sorted(by: { $0.isUserOwned && !$1.isUserOwned }))
        }
    }
    
}
