//
//  NotificationFlowCoordinator.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

// MARK: NotificationFlowCoordinatorFactory
public protocol NotificationFlowCoordinatorFactory  {
}

// MARK: NotificationFlowCoordinator
public protocol NotificationFlowCoordinator {
    func start(with instructor: NotificationFlowCoordinatorInstructor)
}

// MARK: NotificationFlowCoordinatorInstructor
public enum NotificationFlowCoordinatorInstructor {
    
}

// MARK: DefaultNotificationFlowCoordinator
public final class DefaultNotificationFlowCoordinator {

    // MARK: DI Variable
    let navigationController: UINavigationController
    let flowCoordinatorFactory: FlowCoordinatorFactory
    let presentationFactory: NotificationFlowCoordinatorFactory

    // MARK: Init Funciton
    public init(
        navigationController: UINavigationController,
        flowCoordinatorFactory: FlowCoordinatorFactory,
        presentationFactory: NotificationFlowCoordinatorFactory
    ) {
        self.navigationController = navigationController
        self.flowCoordinatorFactory = flowCoordinatorFactory
        self.presentationFactory = presentationFactory
    }
    
}

extension DefaultNotificationFlowCoordinator: NotificationFlowCoordinator {
    
    public func start(with instructor: NotificationFlowCoordinatorInstructor) {
    }
    
}
