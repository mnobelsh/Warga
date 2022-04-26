//
//  LaunchpadFlowCoordinator.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 09/10/21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

// MARK: LaunchpadFlowCoordinatorFactory
public protocol LaunchpadFlowCoordinatorFactory  {
    func makeLaunchpadController(
        requestValue: LaunchpadViewModelRequestValue,
        route: LaunchpadViewModelRoute
    ) -> LaunchpadController
}

// MARK: LaunchpadFlowCoordinator
public protocol LaunchpadFlowCoordinator {
    func start(with instructor: LaunchpadFlowCoordinatorInstructor)
}

// MARK: LaunchpadFlowCoordinatorInstructor
public enum LaunchpadFlowCoordinatorInstructor {
    case launchpad
}

// MARK: DefaultLaunchpadFlowCoordinator
public final class DefaultLaunchpadFlowCoordinator {

    // MARK: DI Variable
    let navigationController: UINavigationController
    let flowCoordinatorFactory: FlowCoordinatorFactory
    let presentationFactory: LaunchpadFlowCoordinatorFactory
    

    // MARK: Init Funciton
    public init(
        navigationController: UINavigationController,
        flowCoordinatorFactory: FlowCoordinatorFactory,
        presentationFactory: LaunchpadFlowCoordinatorFactory
    ) {
        self.navigationController = navigationController
        self.flowCoordinatorFactory = flowCoordinatorFactory
        self.presentationFactory = presentationFactory
    }
    
}

extension DefaultLaunchpadFlowCoordinator: LaunchpadFlowCoordinator {
    
    public func start(with instructor: LaunchpadFlowCoordinatorInstructor) {
        switch instructor {
        case .launchpad:
            let requestValue = LaunchpadViewModelRequestValue(
                citizenshipNavigationController: self.makeCitizenshipNavigationController(),
                communityNavigationController: self.makeCommunityNavigationController(),
                homeNavigationController: self.makeHomeNavigationController(),
                profileNavigationController: self.makeProfileNavigationController()
            )
            let route = LaunchpadViewModelRoute(
                startDialogFlow: self.startDialogFlow(_:)
            )
            let controller = self.presentationFactory.makeLaunchpadController(requestValue: requestValue, route: route)
            self.navigationController.setViewControllers([controller], animated: true)
        }
    }
    
}

private extension DefaultLaunchpadFlowCoordinator {
    
    func makeNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.view.backgroundColor = .background
        navigationController.navigationBar.prefersLargeTitles = false
        return navigationController
    }
    
    func makeCitizenshipNavigationController() -> UINavigationController {
        let requestValue = CitizenshipDashboardViewModelRequestValue()
        let navigationController = self.makeNavigationController()
        navigationController.tabBarItem.configureItem(withTitle: "Kependudukan", andImage: .citizenshipIcon)
        self.flowCoordinatorFactory.instantiateCitizenshipFlowCoordinator(navigationController: navigationController).start(with: .dashboard(requestValue: requestValue))
        return navigationController
    }
    
    func makeCommunityNavigationController() -> UINavigationController {
        let requestValue = CommunityDashboardViewModelRequestValue()
        let navigationController = self.makeNavigationController()
        navigationController.tabBarItem.configureItem(withTitle: "Lingkungan", andImage: .houseCircleFillIcon)
        self.flowCoordinatorFactory.instantiateCommunityFlowCoordinator(navigationController: navigationController).start(with: .dashboard(requestValue: requestValue))
        return navigationController
    }
    
    func makeHomeNavigationController() -> UINavigationController {
        let requestValue = HomeDashboardViewModelRequestValue()
        let navigationController = self.makeNavigationController()
        navigationController.tabBarItem.configureItem(withTitle: "Beranda", andImage: .squareGridFillIcon)
        self.flowCoordinatorFactory.instantiateHomeFlowCoordinator(navigationController: navigationController).start(with: .dashboard(requestValue: requestValue))
        return navigationController
    }
    
    func makeProfileNavigationController() -> UINavigationController {
        let requestValue = ProfileDashboardViewModelRequestValue()
        let navigationController = self.makeNavigationController()
        navigationController.tabBarItem.configureItem(withTitle: "Profil", andImage: .personCircleFillIcon)
        self.flowCoordinatorFactory.instantiateProfileFlowCoordinator(navigationController: navigationController).start(with: .dashboard(requestValue: requestValue))
        return navigationController
    }
    
    func startInitialFlow(_ instructor: InitialFlowCoordinatorInstructor) {
        DispatchQueue.main.async {
            self.flowCoordinatorFactory.instantiateInitialFlowCoordinator().start(with: instructor)
        }
    }
    
    func startDialogFlow(_ instructor: DialogFlowCoordinatorInstructor) {
        DispatchQueue.main.async {
            self.flowCoordinatorFactory.instantiateDialogFlowCoordinator(navigationController: self.navigationController).start(with: instructor)
        }
    }
    
    
    
}

