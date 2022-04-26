//
//  DocumentDetailViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 06/02/22.
//  Copyright (c) 2022 All rights reserved.

import Foundation

// MARK: DocumentDetailViewModelResponse
public enum DocumentDetailViewModelResponse {
}

// MARK: DocumentDetailViewModelDelegate
public protocol DocumentDetailViewModelDelegate: AnyObject {
}

// MARK: - DocumentDetailViewModelRequestValue
public struct DocumentDetailViewModelRequestValue {
    var document: DocumentDomain
}

// MARK: - DocumentDetailViewModelRoute
public struct DocumentDetailViewModelRoute {
    var startCitizenshipFlow: (_ instructor: CitizenshipFlowCoordinatorInstructor) -> Void
}

// MARK: - DocumentDetailViewModelInput
public protocol DocumentDetailViewModelInput {
    func viewDidLoad()
    func doRequestDocument()
}

// MARK: - DocumentDetailViewModelOutput
public protocol DocumentDetailViewModelOutput {
    var document: DocumentDomain { get }
}

// MARK: - DocumentDetailViewModel
public protocol DocumentDetailViewModel: DocumentDetailViewModelInput, DocumentDetailViewModelOutput { }

// MARK: - DefaultDocumentDetailViewModel
public final class DefaultDocumentDetailViewModel: DocumentDetailViewModel {

    // MARK: Dependency Variable
    weak var delegate: DocumentDetailViewModelDelegate?
    let requestValue: DocumentDetailViewModelRequestValue
    let route: DocumentDetailViewModelRoute

    // MARK: Output ViewModel Variable
    public var document: DocumentDomain

    init(
        requestValue: DocumentDetailViewModelRequestValue,
        route: DocumentDetailViewModelRoute
    ) {
        self.requestValue = requestValue
        self.route = route
        self.document = requestValue.document
    }

}

// MARK: Input ViewModel Function
public extension DefaultDocumentDetailViewModel {

    func viewDidLoad() {
    }

    func doRequestDocument() {
        let requestValue = RequestDocumentViewModelRequestValue(document: self.requestValue.document)
        self.route.startCitizenshipFlow(.requestDocument(requestValue: requestValue))
    }
}

// MARK: Private Function
private extension DefaultDocumentDetailViewModel {

}
