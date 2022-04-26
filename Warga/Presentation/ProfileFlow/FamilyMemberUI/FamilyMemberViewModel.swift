//
//  FamilyMemberViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation

// MARK: FamilyMemberViewModelResponse
public enum FamilyMemberViewModelResponse {
}

// MARK: FamilyMemberViewModelDelegate
public protocol FamilyMemberViewModelDelegate: AnyObject {
}

// MARK: - FamilyMemberViewModelRequestValue
public struct FamilyMemberViewModelRequestValue {
}

// MARK: - FamilyMemberViewModelRoute
public struct FamilyMemberViewModelRoute {
    var pop: () -> Void
    var startDialogFlow: (_ instructor: DialogFlowCoordinatorInstructor) -> Void
}

// MARK: - FamilyMemberViewModelInput
public protocol FamilyMemberViewModelInput {
    func viewDidLoad()
    func popViewController()
    func showQRCodeDialog(requestValue: ShowQRCodeDialogViewRequestValue)
}

// MARK: - FamilyMemberViewModelOutput
public protocol FamilyMemberViewModelOutput {
}

// MARK: - FamilyMemberViewModel
public protocol FamilyMemberViewModel: FamilyMemberViewModelInput, FamilyMemberViewModelOutput { }

// MARK: - DefaultFamilyMemberViewModel
public final class DefaultFamilyMemberViewModel: FamilyMemberViewModel {

    // MARK: Dependency Variable
    weak var delegate: FamilyMemberViewModelDelegate?
    let requestValue: FamilyMemberViewModelRequestValue
    let route: FamilyMemberViewModelRoute

    // MARK: Output ViewModel Variable

    init(
        requestValue: FamilyMemberViewModelRequestValue,
        route: FamilyMemberViewModelRoute
    ) {
        self.requestValue = requestValue
        self.route = route
    }

}

// MARK: Input ViewModel Function
public extension DefaultFamilyMemberViewModel {

    func viewDidLoad() {
    }
    
    func popViewController() {
        self.route.pop()
    }
    
    func showQRCodeDialog(requestValue: ShowQRCodeDialogViewRequestValue) {
        self.route.startDialogFlow(.showQRCode(requestValue: requestValue))
    }

}

// MARK: Private Function
private extension DefaultFamilyMemberViewModel {

}
