//
//  FlowCoordinatorFactory.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//

import UIKit

public protocol FlowCoordinatorFactory {
    
    func instantiateAuthFlowCoordinator(navigationController: UINavigationController) -> AuthFlowCoordinator
    func instantiateInitialFlowCoordinator() -> InitialFlowCoordinator
    func instantiateLaunchpadFlowCoordinator() -> LaunchpadFlowCoordinator
    func instantiateCitizenshipFlowCoordinator(navigationController: UINavigationController) -> CitizenshipFlowCoordinator
    func instantiateCommunityFlowCoordinator(navigationController: UINavigationController) -> CommunityFlowCoordinator
    func instantiateDialogFlowCoordinator(navigationController: UINavigationController) -> DialogFlowCoordinator
    func instantiateDocumentFlowCoordinator(navigationController: UINavigationController) -> DocumentFlowCoordinator
    func instantiateHomeFlowCoordinator(navigationController: UINavigationController) -> HomeFlowCoordinator
    func instantiateProfileFlowCoordinator(navigationController: UINavigationController) -> ProfileFlowCoordinator
    
}
