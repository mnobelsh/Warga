//
//  HomeFlowCoordinator.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 09/10/21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

// MARK: HomeFlowCoordinatorFactory
public protocol HomeFlowCoordinatorFactory  {
    func makeHomeDashboardController(
        requestValue: HomeDashboardViewModelRequestValue,
        route: HomeDashboardViewModelRoute
    ) -> HomeDashboardController
}

// MARK: HomeFlowCoordinator
public protocol HomeFlowCoordinator {
    func start(with instructor: HomeFlowCoordinatorInstructor)
}

// MARK: HomeFlowCoordinatorInstructor
public enum HomeFlowCoordinatorInstructor {
    case dashboard(requestValue: HomeDashboardViewModelRequestValue)
}

// MARK: DefaultHomeFlowCoordinator
public final class DefaultHomeFlowCoordinator {

    // MARK: DI Variable
    let navigationController: UINavigationController
    let flowCoordinatorFactory: FlowCoordinatorFactory
    let presentationFactory: HomeFlowCoordinatorFactory

    // MARK: Init Funciton
    public init(
        navigationController: UINavigationController,
        flowCoordinatorFactory: FlowCoordinatorFactory,
        presentationFactory: HomeFlowCoordinatorFactory
    ) {
        self.navigationController = navigationController
        self.flowCoordinatorFactory = flowCoordinatorFactory
        self.presentationFactory = presentationFactory
    }
    
}

extension DefaultHomeFlowCoordinator: HomeFlowCoordinator {
    
    public func start(with instructor: HomeFlowCoordinatorInstructor) {
        switch instructor {
        case .dashboard(let requestValue):
            let route = HomeDashboardViewModelRoute(
                startDialogFlow: self.startDialogFlow(_:)
            )
            let controller = self.presentationFactory.makeHomeDashboardController(requestValue: requestValue, route: route)
            self.navigationController.setViewControllers([controller], animated: true)
        }
    }
    
    public func startDialogFlow(_ instructor: DialogFlowCoordinatorInstructor) {
        DispatchQueue.main.async {
            self.flowCoordinatorFactory.instantiateDialogFlowCoordinator(navigationController: self.navigationController).start(with: instructor)
        }
    }
    
}
