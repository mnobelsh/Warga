//
//  LandingViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation

// MARK: LandingViewModelResponse
public enum LandingViewModelResponse {
}

// MARK: LandingViewModelDelegate
public protocol LandingViewModelDelegate: AnyObject {
}

// MARK: - LandingViewModelRequestValue
public struct LandingViewModelRequestValue {
}

// MARK: - LandingViewModelRoute
public struct LandingViewModelRoute {
    var startAuthFlow: (_ instructor: AuthFlowCoordinatorInstructor) -> Void
}

// MARK: - LandingViewModelInput
public protocol LandingViewModelInput {
    func viewDidLoad()
    func showSignUpUI()
    func showSignInUI()
}

// MARK: - LandingViewModelOutput
public protocol LandingViewModelOutput {
}

// MARK: - LandingViewModel
public protocol LandingViewModel: LandingViewModelInput, LandingViewModelOutput { }

// MARK: - DefaultLandingViewModel
public final class DefaultLandingViewModel: LandingViewModel {

    // MARK: Dependency Variable
    weak var delegate: LandingViewModelDelegate?
    let requestValue: LandingViewModelRequestValue
    let route: LandingViewModelRoute

    // MARK: Output ViewModel Variable

    init(
        requestValue: LandingViewModelRequestValue,
        route: LandingViewModelRoute
    ) {
        self.requestValue = requestValue
        self.route = route
    }

}

// MARK: Input ViewModel Function
public extension DefaultLandingViewModel {

    func viewDidLoad() {
    }
    
    func showSignUpUI() {
        let requestValue = SignUpViewModelRequestValue()
        self.route.startAuthFlow(.signUp(requestValue: requestValue))
    }
    
    func showSignInUI() {
        let requestValue = SignInViewModelRequestValue()
        self.route.startAuthFlow(.signIn(requestValue: requestValue))
    }

}

// MARK: Private Function
private extension DefaultLandingViewModel {

}
