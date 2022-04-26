//
//  ViewDocumentViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//  Copyright (c) 2022 All rights reserved.

import Foundation
import RxSwift

// MARK: ViewDocumentViewModelResponse
public enum ViewDocumentViewModelResponse {
}

// MARK: ViewDocumentViewModelDelegate
public protocol ViewDocumentViewModelDelegate: AnyObject {
}

// MARK: - ViewDocumentViewModelRequestValue
public struct ViewDocumentViewModelRequestValue {
    var documents: [DocumentDTO]
}

// MARK: - ViewDocumentViewModelRoute
public struct ViewDocumentViewModelRoute {
}

// MARK: - ViewDocumentViewModelInput
public protocol ViewDocumentViewModelInput {
    func viewDidLoad()
}

// MARK: - ViewDocumentViewModelOutput
public protocol ViewDocumentViewModelOutput {
    var documents: [DocumentDTO] { get }
}

// MARK: - ViewDocumentViewModel
public protocol ViewDocumentViewModel: ViewDocumentViewModelInput, ViewDocumentViewModelOutput { }

// MARK: - DefaultViewDocumentViewModel
public final class DefaultViewDocumentViewModel: ViewDocumentViewModel {

    // MARK: Dependency Variable
    weak var delegate: ViewDocumentViewModelDelegate?
    let requestValue: ViewDocumentViewModelRequestValue
    let route: ViewDocumentViewModelRoute

    // MARK: Output ViewModel Variable
    public var documents: [DocumentDTO]

    init(
        requestValue: ViewDocumentViewModelRequestValue,
        route: ViewDocumentViewModelRoute
    ) {
        self.requestValue = requestValue
        self.route = route
        self.documents = requestValue.documents
    }

}

// MARK: Input ViewModel Function
public extension DefaultViewDocumentViewModel {

    func viewDidLoad() {
    }

}

// MARK: Private Function
private extension DefaultViewDocumentViewModel {

}
