//
//  ScanDocumentViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 23/10/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation

// MARK: ScanDocumentViewModelResponse
public enum ScanDocumentViewModelResponse {
}

// MARK: ScanDocumentViewModelDelegate
public protocol ScanDocumentViewModelDelegate: AnyObject {
    func didRecognizeText(textGroup: [String])
    func didScanDocument(pdfData: Data)
    func didFailWithError(_ error: Error)
}

// MARK: - ScanDocumentViewModelRequestValue
public struct ScanDocumentViewModelRequestValue {
    var delegate: ScanDocumentViewModelDelegate
}

// MARK: - ScanDocumentViewModelRoute
public struct ScanDocumentViewModelRoute {
    var startDialogFlow: (_ instructor: DialogFlowCoordinatorInstructor) -> Void
}

// MARK: - ScanDocumentViewModelInput
public protocol ScanDocumentViewModelInput {
    func viewDidLoad()
    func didRecognizeText(textGroup: [String])
    func didScanDocument(pdfData: Data)
    func didFailWithError(_ error: Error)
    func showInstructionDialog(requestValue: InstructionDialogViewRequestValue)
}

// MARK: - ScanDocumentViewModelOutput
public protocol ScanDocumentViewModelOutput {
}

// MARK: - ScanDocumentViewModel
public protocol ScanDocumentViewModel: ScanDocumentViewModelInput, ScanDocumentViewModelOutput { }

// MARK: - DefaultScanDocumentViewModel
public final class DefaultScanDocumentViewModel: ScanDocumentViewModel {

    // MARK: Dependency Variable
    weak var delegate: ScanDocumentViewModelDelegate?
    let requestValue: ScanDocumentViewModelRequestValue
    let route: ScanDocumentViewModelRoute

    // MARK: Output ViewModel Variable

    init(
        requestValue: ScanDocumentViewModelRequestValue,
        route: ScanDocumentViewModelRoute
    ) {
        self.requestValue = requestValue
        self.route = route
    }

}

// MARK: Input ViewModel Function
public extension DefaultScanDocumentViewModel {

    func viewDidLoad() {
        self.delegate = self.requestValue.delegate
    }
    
    func didScanDocument(pdfData: Data) {
        self.delegate?.didScanDocument(pdfData: pdfData)
    }
    
    func didRecognizeText(textGroup: [String]) {
        self.delegate?.didRecognizeText(textGroup: textGroup)
    }
    
    func didFailWithError(_ error: Error) {
        self.delegate?.didFailWithError(error)
    }
    
    func showInstructionDialog(requestValue: InstructionDialogViewRequestValue) {
        self.route.startDialogFlow(.instruction(requestValue: requestValue))
    }

}

// MARK: Private Function
private extension DefaultScanDocumentViewModel {

}
