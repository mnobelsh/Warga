//
//  SignInViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation
import RxSwift
import RxRelay
import UIKit

// MARK: SignInViewModelResponse
public enum SignInViewModelResponse {
    case successSignIn
    case failedSignIn(withError: Error)
}

// MARK: SignInViewModelDelegate
public protocol SignInViewModelDelegate: AnyObject {
}

// MARK: - SignInViewModelRequestValue
public struct SignInViewModelRequestValue {
}

// MARK: - SignInViewModelRoute
public struct SignInViewModelRoute {
    var startLaunchpadFlow: (_ instructor: LaunchpadFlowCoordinatorInstructor) -> Void
    var startAuthFlow: (_ instructor: AuthFlowCoordinatorInstructor) -> Void
}

// MARK: - SignInViewModelInput
public protocol SignInViewModelInput {
    func viewDidLoad()
    func doUserAuthentication(nik: String, password: String)
    func showMainApp()
    func showRegisterUI()
}

// MARK: - SignInViewModelOutput
public protocol SignInViewModelOutput {
    var displayedLoadingState: PublishRelay<LoadingView.State> { get }
    var displayedResponse: PublishRelay<SignInViewModelResponse> { get }
}

// MARK: - SignInViewModel
public protocol SignInViewModel: SignInViewModelInput, SignInViewModelOutput { }

// MARK: - DefaultSignInViewModel
public final class DefaultSignInViewModel: SignInViewModel {

    // MARK: Dependency Variable
    weak var delegate: SignInViewModelDelegate?
    let requestValue: SignInViewModelRequestValue
    let route: SignInViewModelRoute

    // MARK: Output ViewModel Variable
    public let displayedLoadingState = PublishRelay<LoadingView.State>()
    public let displayedResponse = PublishRelay<SignInViewModelResponse>()
    
    // MARK: - Use Case
    let fetchUserProfileUseCase: FetchUserProfileUseCase

    init(
        requestValue: SignInViewModelRequestValue,
        route: SignInViewModelRoute,
        fetchUserProfileUseCase: FetchUserProfileUseCase
    ) {
        self.requestValue = requestValue
        self.route = route
        self.fetchUserProfileUseCase = fetchUserProfileUseCase
    }

}

// MARK: Input ViewModel Function
public extension DefaultSignInViewModel {

    func viewDidLoad() {
   
    }

    func doUserAuthentication(nik: String, password: String) {
        self.displayedLoadingState.accept(.show)
        let requestValue = FetchUserProfileUseCaseRequest(parameter: .byNIK(nik))
        self.fetchUserProfileUseCase.execute(requestValue) { result in
            switch result {
            case .success(let profile):
                guard let email = profile?.email else {
                    let error = NSError(domain: "", code: 0, userInfo: [.emptyStringWarning: "invalid email address."])
                    self.displayedLoadingState.accept(.hide)
                    self.displayedResponse.accept(.failedSignIn(withError: error))
                    return
                }
                FirebaseService.shared.signIn(withEmail: email, andPassword: password) { result, error in
                    self.displayedLoadingState.accept(.hide)
                    if let error = error {
                        self.displayedLoadingState.accept(.hide)
                        self.displayedResponse.accept(.failedSignIn(withError: error))
                    } else {
                        self.displayedResponse.accept(.successSignIn)
                        UserPreference.shared.currentProfile = profile
                    }
                }
            case .failure(let error):
                self.displayedLoadingState.accept(.hide)
                self.displayedResponse.accept(.failedSignIn(withError: error))
            }
        }
    }
    
    func showMainApp() {
        self.route.startLaunchpadFlow(.launchpad)
    }
    
    func showRegisterUI() {
        let requestValue = SignUpViewModelRequestValue()
        self.route.startAuthFlow(.signUp(requestValue: requestValue))
    }
}

// MARK: Private Function
private extension DefaultSignInViewModel {

}
