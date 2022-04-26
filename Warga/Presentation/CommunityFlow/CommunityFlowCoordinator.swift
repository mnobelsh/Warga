//
//  CommunityFlowCoordinator.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

// MARK: CommunityFlowCoordinatorFactory
public protocol CommunityFlowCoordinatorFactory  {
    func makeCommunityDashboardController(
        requestValue: CommunityDashboardViewModelRequestValue,
        route: CommunityDashboardViewModelRoute
    ) -> CommunityDashboardController
}

// MARK: CommunityFlowCoordinator
public protocol CommunityFlowCoordinator {
    func start(with instructor: CommunityFlowCoordinatorInstructor)
}

// MARK: CommunityFlowCoordinatorInstructor
public enum CommunityFlowCoordinatorInstructor {
    case dashboard(requestValue: CommunityDashboardViewModelRequestValue)
}

// MARK: DefaultCommunityFlowCoordinator
public final class DefaultCommunityFlowCoordinator {

    // MARK: DI Variable
    let navigationController: UINavigationController
    let flowCoordinatorFactory: FlowCoordinatorFactory
    let presentationFactory: CommunityFlowCoordinatorFactory

    // MARK: Init Funciton
    public init(
        navigationController: UINavigationController,
        flowCoordinatorFactory: FlowCoordinatorFactory,
        presentationFactory: CommunityFlowCoordinatorFactory
    ) {
        self.navigationController = navigationController
        self.flowCoordinatorFactory = flowCoordinatorFactory
        self.presentationFactory = presentationFactory
    }
    
}

extension DefaultCommunityFlowCoordinator: CommunityFlowCoordinator {
    
    public func start(with instructor: CommunityFlowCoordinatorInstructor) {
        switch instructor {
        case .dashboard(let requestValue):
            let route = CommunityDashboardViewModelRoute()
            let controller = self.presentationFactory.makeCommunityDashboardController(requestValue: requestValue, route: route)
            self.navigationController.setViewControllers([controller], animated: true)
        }
    }
    
}
