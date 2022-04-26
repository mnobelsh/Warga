//
//  AuthFlowCoordinator.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

// MARK: AuthFlowCoordinatorFactory
public protocol AuthFlowCoordinatorFactory  {
    
    func makeSignInController(
        requestValue: SignInViewModelRequestValue,
        route: SignInViewModelRoute
    ) -> SignInController
    
    func makeSignUpController(
        requestValue: SignUpViewModelRequestValue,
        route: SignUpViewModelRoute
    ) -> SignUpController
    
    func makeOTPVerificationController(
        requestValue: OTPVerificationViewModelRequestValue,
        route: OTPVerificationViewModelRoute
    ) -> OTPVerificationController
    
}

// MARK: AuthFlowCoordinator
public protocol AuthFlowCoordinator {
    func start(with instructor: AuthFlowCoordinatorInstructor)
}

// MARK: AuthFlowCoordinatorInstructor
public enum AuthFlowCoordinatorInstructor {
    case signIn(requestValue: SignInViewModelRequestValue)
    case signUp(requestValue: SignUpViewModelRequestValue)
    case OTPVerification(requestValue: OTPVerificationViewModelRequestValue)
}

// MARK: DefaultAuthFlowCoordinator
public final class DefaultAuthFlowCoordinator {

    // MARK: DI Variable
    let navigationController: UINavigationController
    let flowCoordinatorFactory: FlowCoordinatorFactory
    let presentationFactory: AuthFlowCoordinatorFactory

    // MARK: Init Funciton
    public init(
        navigationController: UINavigationController,
        flowCoordinatorFactory: FlowCoordinatorFactory,
        presentationFactory: AuthFlowCoordinatorFactory
    ) {
        self.navigationController = navigationController
        self.flowCoordinatorFactory = flowCoordinatorFactory
        self.presentationFactory = presentationFactory
    }
    
}

extension DefaultAuthFlowCoordinator: AuthFlowCoordinator {
    
    public func start(with instructor: AuthFlowCoordinatorInstructor) {
        switch instructor {
        case .signIn(let requestValue):
            let route = SignInViewModelRoute(
                startLaunchpadFlow: self.startLaunchpadFlow(_:),
                startAuthFlow: self.start(with:)
            )
            let controller = self.presentationFactory.makeSignInController(requestValue: requestValue, route: route)
            controller.modalPresentationStyle = .pageSheet
            self.navigationController.setViewControllers([controller], animated: true)
        case .signUp(let requestValue):
            let route = SignUpViewModelRoute(
                startAuthFlow: self.startAuthFlow(_:),
                startDocumentFlow: self.startDocumentFlow(_:),
                startDialogFlow: self.startDialogFlow(_:)
            )
            let controller = self.presentationFactory.makeSignUpController(requestValue: requestValue, route: route)
            self.navigationController.present(controller, animated: true, completion: nil)
        case .OTPVerification(let requestValue):
            let route = OTPVerificationViewModelRoute()
            let controller = self.presentationFactory.makeOTPVerificationController(requestValue: requestValue, route: route)
            controller.modalPresentationStyle = .pageSheet
            if let vc = self.navigationController.viewControllers.last, vc.modalPresentationStyle == .pageSheet {
                self.navigationController.viewControllers.last?.dismiss(animated: true)
            }
            self.navigationController.present(controller, animated: true)
        }
    }
    
}

private extension DefaultAuthFlowCoordinator {
    
    func startAuthFlow(_ instructor: AuthFlowCoordinatorInstructor) {
        DispatchQueue.main.async {
            self.flowCoordinatorFactory.instantiateAuthFlowCoordinator(navigationController: self.navigationController).start(with: instructor)
        }
    }
    
    func startLaunchpadFlow(_ instructor: LaunchpadFlowCoordinatorInstructor) {
        DispatchQueue.main.async {
            self.flowCoordinatorFactory.instantiateLaunchpadFlowCoordinator().start(with: instructor)
        }
    }
    
    func startDocumentFlow(_ instructor: DocumentFlowCoordinatorInstructor) {
        DispatchQueue.main.async {
            self.flowCoordinatorFactory.instantiateDocumentFlowCoordinator(navigationController: self.navigationController).start(with: instructor)
        }
    }
    
    func startDialogFlow(_ instructor: DialogFlowCoordinatorInstructor) {
        DispatchQueue.main.async {
            self.flowCoordinatorFactory.instantiateDialogFlowCoordinator(navigationController: self.navigationController).start(with: instructor)
        }
    }

    
}
