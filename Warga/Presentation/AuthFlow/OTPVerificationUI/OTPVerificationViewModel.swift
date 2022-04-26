//
//  OTPVerificationViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 20/09/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation

// MARK: OTPVerificationViewModelResponse
public enum OTPVerificationViewModelResponse {
}

// MARK: OTPVerificationViewModelDelegate
public protocol OTPVerificationViewModelDelegate: AnyObject {
}

// MARK: - OTPVerificationViewModelRequestValue
public struct OTPVerificationViewModelRequestValue {
}

// MARK: - OTPVerificationViewModelRoute
public struct OTPVerificationViewModelRoute {
}

// MARK: - OTPVerificationViewModelInput
public protocol OTPVerificationViewModelInput {
    func viewDidLoad()
}

// MARK: - OTPVerificationViewModelOutput
public protocol OTPVerificationViewModelOutput {
}

// MARK: - OTPVerificationViewModel
public protocol OTPVerificationViewModel: OTPVerificationViewModelInput, OTPVerificationViewModelOutput { }

// MARK: - DefaultOTPVerificationViewModel
public final class DefaultOTPVerificationViewModel: OTPVerificationViewModel {

    // MARK: Dependency Variable
    weak var delegate: OTPVerificationViewModelDelegate?
    let requestValue: OTPVerificationViewModelRequestValue
    let route: OTPVerificationViewModelRoute

    // MARK: Output ViewModel Variable

    init(
        requestValue: OTPVerificationViewModelRequestValue,
        route: OTPVerificationViewModelRoute
    ) {
        self.requestValue = requestValue
        self.route = route
    }

}

// MARK: Input ViewModel Function
public extension DefaultOTPVerificationViewModel {

    func viewDidLoad() {
    }

}

// MARK: Private Function
private extension DefaultOTPVerificationViewModel {

}
