//
//  SignUpViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation
import RxSwift
import RxRelay
import PromiseKit

// MARK: SignUpViewModelResponse
public enum SignUpViewModelResponse {
    case userAlreadyExist
    case registerDidSuccess
    case registerDidFail
}

// MARK: SignUpViewModelDelegate
public protocol SignUpViewModelDelegate: AnyObject {
}

// MARK: - SignUpViewModelRequestValue
public struct SignUpViewModelRequestValue {
}

// MARK: - SignUpViewModelRoute
public struct SignUpViewModelRoute {
    var startAuthFlow: (_ instructor: AuthFlowCoordinatorInstructor) -> Void
    var startDocumentFlow: (_ isntructor: DocumentFlowCoordinatorInstructor) -> Void
    var startDialogFlow: (_ instructor: DialogFlowCoordinatorInstructor) -> Void
}

// MARK: - SignUpViewModelInput
public protocol SignUpViewModelInput {
    func viewDidLoad()
    func doSignUp(withProfile profile: ProfileDTO, password: String)
    func showOTPVerificationUI()
    func showScanDocumentUI(presentingController: SignUpController)
    func showDialogFlow(alertType: AlertDialogViewRequestValue.AlertType, title: String)
    func showSignInUI()
}

// MARK: - SignUpViewModelOutput
public protocol SignUpViewModelOutput {
    var displayedNIKNumber: PublishRelay<String> { get }
    var displayedName: PublishRelay<String> { get }
    var displayedLoadingState: PublishRelay<LoadingView.State> { get }
    var displayedResponse: PublishRelay<SignUpViewModelResponse> { get }
    var scannedDocument: PublishRelay<Data> { get }
}

// MARK: - SignUpViewModel
public protocol SignUpViewModel: SignUpViewModelInput, SignUpViewModelOutput { }

// MARK: - DefaultSignUpViewModel
public final class DefaultSignUpViewModel: SignUpViewModel {

    // MARK: Dependency Variable
    weak var delegate: SignUpViewModelDelegate?
    let requestValue: SignUpViewModelRequestValue
    let route: SignUpViewModelRoute
    
    private var userData: ProfileDTO?
    
    // MARK: - UseCase
    private let saveUserProfileUseCase: SaveUserProfileUseCase
    private let fetchUserProfileUseCase: FetchUserProfileUseCase

    // MARK: Output ViewModel Variable
    public let displayedNIKNumber = PublishRelay<String>()
    public let displayedName = PublishRelay<String>()
    public let displayedLoadingState = PublishRelay<LoadingView.State>()
    public let displayedResponse = PublishRelay<SignUpViewModelResponse>()
    public let scannedDocument = PublishRelay<Data>()

    init(
        requestValue: SignUpViewModelRequestValue,
        route: SignUpViewModelRoute,
        fetchUserProfileUseCase: FetchUserProfileUseCase,
        saveUserProfileUseCase: SaveUserProfileUseCase
    ) {
        self.requestValue = requestValue
        self.route = route
        self.fetchUserProfileUseCase = fetchUserProfileUseCase
        self.saveUserProfileUseCase = saveUserProfileUseCase
    }

}

// MARK: Input ViewModel Function
public extension DefaultSignUpViewModel {

    func viewDidLoad() {

    }
    
    func doSignUp(withProfile profile: ProfileDTO, password: String) {
        firstly {
            self.fetchUser(with: profile.nik)
        }.done { fetchedUser in
            guard fetchedUser == nil else {
                self.displayedResponse.accept(.userAlreadyExist)
                return
            }
            UserPreference.shared.signUpData = profile
            guard UserPreference.shared.signUpData != nil else { return }
            self.saveUserProfile(profile: profile, password: password)
        }.ensure {
            self.displayedLoadingState.accept(.hide)
        }.catch { error in
            self.displayedResponse.accept(.registerDidFail)
        }
    }
    
    func showSignInUI() {
        let requestValue = SignInViewModelRequestValue()
        self.route.startAuthFlow(.signIn(requestValue: requestValue))
    }
    
    func showDialogFlow(alertType: AlertDialogViewRequestValue.AlertType, title: String) {
        let requestValue = AlertDialogViewRequestValue(alertType: alertType, title: title)
        self.route.startDialogFlow(.alert(requestValue: requestValue))
    }
    
    func showOTPVerificationUI() {
        let requestValue = OTPVerificationViewModelRequestValue()
        self.route.startAuthFlow(.OTPVerification(requestValue: requestValue))
    }
    
    func showScanDocumentUI(presentingController: SignUpController) {
        let requestValue = ScanDocumentViewModelRequestValue(delegate: self)
        self.route.startDocumentFlow(.scanDocument(presentingController: presentingController, requestValue: requestValue))
    }
    
}

// MARK: Private Function
private extension DefaultSignUpViewModel {
    
    func saveUserProfile(profile: ProfileDTO, password: String) {
        FirebaseService.shared.registerUser(withEmail: profile.email, andPassword: password) { result, error in
            if error != nil {
                self.displayedResponse.accept(.registerDidFail)
            } else {
                guard let result = result else {
                    self.displayedResponse.accept(.registerDidFail)
                    return
                }
                var newProfile = profile
                newProfile.id = result.user.uid
                let requestValue = SaveUserProfileUseCaseRequest(profile: newProfile, operation: .add)
                self.saveUserProfileUseCase.execute(requestValue) { result in
                    switch result {
                    case .success:
                        self.displayedResponse.accept(.registerDidSuccess)
                    case .failure:
                        self.displayedResponse.accept(.registerDidFail)
                    }
                }
            }
        }
    }


    func fetchUser(with nikNumber: String) -> Promise<ProfileDTO?> {
        self.displayedLoadingState.accept(.show)
        return Promise { [weak self] promise in
            guard let self = self else { return }
            let request = FetchUserProfileUseCaseRequest(parameter: .byNIK(nikNumber))
            self.fetchUserProfileUseCase.execute(request) { result in
                switch result {
                case .success(let user):
                    promise.fulfill(user)
                case .failure(let error):
                    promise.reject(error)
                }
            }
        }
    }
    
    func retrieveInfoFrom(from textGroup: [String]) {
        guard let nikNumber = textGroup.filter({ $0.isValidNikNumber() }).first else { return }
        var name = ""
        for index in 0..<textGroup.count {
            if textGroup[index] == nikNumber {
                name = textGroup[index+2]
                break
            }
        }
        self.displayedNIKNumber.accept(nikNumber)
        self.displayedName.accept(name)
    }
    
}

extension DefaultSignUpViewModel: ScanDocumentViewModelDelegate {
    
    public func didRecognizeText(textGroup: [String]) {
        self.retrieveInfoFrom(from: textGroup)
    }
    
    public func didScanDocument(pdfData: Data) {
        self.scannedDocument.accept(pdfData)
    }
    
    public func didFailWithError(_ error: Error) {
        
    }
    
    
}
