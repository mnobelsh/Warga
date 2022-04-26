//
//  AppDIContainer+FlowCoordinatorFactory.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//

import UIKit

extension AppDICointainer: FlowCoordinatorFactory {

    
    // MARK: - Auth Flow Coordinator
    public func instantiateAuthFlowCoordinator(navigationController: UINavigationController) -> AuthFlowCoordinator {
        return DefaultAuthFlowCoordinator(navigationController: navigationController, flowCoordinatorFactory: self, presentationFactory: self)
    }
    
    // MARK: - Home Flow Coordinator
    public func instantiateHomeFlowCoordinator(navigationController: UINavigationController) -> HomeFlowCoordinator {
        return DefaultHomeFlowCoordinator(navigationController: navigationController, flowCoordinatorFactory: self, presentationFactory: self)
    }
    
    // MARK: - Profile Flow Coordinator
    public func instantiateProfileFlowCoordinator(navigationController: UINavigationController) -> ProfileFlowCoordinator {
        return DefaultProfileFlowCoordinator(navigationController: navigationController, flowCoordinatorFactory: self, presentationFactory: self)
    }
    
    // MARK: - Citizenship Flow Coordinator
    public func instantiateCitizenshipFlowCoordinator(navigationController: UINavigationController) -> CitizenshipFlowCoordinator {
        return DefaultCitizenshipFlowCoordinator(navigationController: navigationController, flowCoordinatorFactory: self, presentationFactory: self)
    }
    
    // MARK: - Community Flow Coordinator
    public func instantiateCommunityFlowCoordinator(navigationController: UINavigationController) -> CommunityFlowCoordinator {
        return DefaultCommunityFlowCoordinator(navigationController: navigationController, flowCoordinatorFactory: self, presentationFactory: self)
    }
    
    // MARK: - Dialog Flow Coordinator
    public func instantiateDialogFlowCoordinator(navigationController: UINavigationController) -> DialogFlowCoordinator {
        return DefaultDialogFlowCoordinator(navigationController: navigationController, flowCoordinatorFactory: self, presentationFactory: self)
    }
    
    // MARK: - Initial Flow Coordinator
    public func instantiateInitialFlowCoordinator() -> InitialFlowCoordinator {
        return DefaultInitialFlowCoordinator(navigationController: self.navigationController, flowCoordinatorFactory: self, presentationFactory: self)
    }
    
    // MARK: - Launchpad Flow Coordinator
    public func instantiateLaunchpadFlowCoordinator() -> LaunchpadFlowCoordinator {
        return DefaultLaunchpadFlowCoordinator(navigationController: self.navigationController, flowCoordinatorFactory: self, presentationFactory: self)
    }
    
    // MARK: - Document Flow Coordinator
    public func instantiateDocumentFlowCoordinator(navigationController: UINavigationController) -> DocumentFlowCoordinator {
        return DefaultDocumentFlowCoordinator(navigationController: navigationController, flowCoordinatorFactory: self, presentationFactory: self)
    }
    
}
