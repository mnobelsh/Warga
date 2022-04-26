//
//  InitialFlowCoordinator.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

// MARK: InitialFlowCoordinatorFactory
public protocol InitialFlowCoordinatorFactory  {
    
    func makeLandingController(
        requestValue: LandingViewModelRequestValue,
        route: LandingViewModelRoute
    ) -> LandingController
    
    func makeOnBoardingController(
        requestValue: OnBoardingViewModelRequestValue,
        route: OnBoardingViewModelRoute
    ) -> OnBoardingController
    
}

// MARK: InitialFlowCoordinator
public protocol InitialFlowCoordinator {
    func start(with instructor: InitialFlowCoordinatorInstructor)
}

// MARK: InitialFlowCoordinatorInstructor
public enum InitialFlowCoordinatorInstructor {
    case landing(requestValue: LandingViewModelRequestValue)
    case onBoarding(requestValue: OnBoardingViewModelRequestValue)
}

// MARK: DefaultInitialFlowCoordinator
public final class DefaultInitialFlowCoordinator {

    // MARK: DI Variable
    let navigationController: UINavigationController
    let flowCoordinatorFactory: FlowCoordinatorFactory
    let presentationFactory: InitialFlowCoordinatorFactory

    // MARK: Init Funciton
    public init(
        navigationController: UINavigationController,
        flowCoordinatorFactory: FlowCoordinatorFactory,
        presentationFactory: InitialFlowCoordinatorFactory
    ) {
        self.navigationController = navigationController
        self.flowCoordinatorFactory = flowCoordinatorFactory
        self.presentationFactory = presentationFactory
    }
    
}

extension DefaultInitialFlowCoordinator: InitialFlowCoordinator {
    
    public func start(with instructor: InitialFlowCoordinatorInstructor) {
        switch instructor {
        case .landing(let requestValue):
            let route = LandingViewModelRoute(
                startAuthFlow: self.startAuthFlow(_:)
            )
            let controller = self.presentationFactory.makeLandingController(requestValue: requestValue, route: route)
            self.navigationController.setViewControllers([controller], animated: true)
        case .onBoarding(let requestValue):
            let route = OnBoardingViewModelRoute()
            let controller = self.presentationFactory.makeOnBoardingController(requestValue: requestValue, route: route)
            self.navigationController.setViewControllers([controller], animated: true)
        }
    }
    
}

private extension DefaultInitialFlowCoordinator {
    
    func startAuthFlow(_ instructor: AuthFlowCoordinatorInstructor) {
        DispatchQueue.main.async {
            self.flowCoordinatorFactory.instantiateAuthFlowCoordinator(navigationController: self.navigationController).start(with: instructor)
        }
    }
    
}
