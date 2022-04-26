//
//  ProfileFlowCoordinator.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 09/10/21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

// MARK: ProfileFlowCoordinatorFactory
public protocol ProfileFlowCoordinatorFactory  {
    func makeProfileDashboardController(
        requestValue: ProfileDashboardViewModelRequestValue,
        route: ProfileDashboardViewModelRoute
    ) -> ProfileDashboardController
    func makeFamilyMemberController(
        requestValue: FamilyMemberViewModelRequestValue,
        route: FamilyMemberViewModelRoute
    ) -> FamilyMemberController
    func makeDocumentListController(
        requestValue: DocumentListViewModelRequestValue,
        route: DocumentListViewModelRoute
    ) -> DocumentListController
    func makeActivityListController(
        requestValue: ActivityListViewModelRequestValue,
        route: ActivityListViewModelRoute
    ) -> ActivityListController
}

// MARK: ProfileFlowCoordinator
public protocol ProfileFlowCoordinator {
    func start(with instructor: ProfileFlowCoordinatorInstructor)
}

// MARK: ProfileFlowCoordinatorInstructor
public enum ProfileFlowCoordinatorInstructor {
    case dashboard(requestValue: ProfileDashboardViewModelRequestValue)
    case familyMember(requestValue: FamilyMemberViewModelRequestValue)
    case activityList(requestValue: ActivityListViewModelRequestValue)
    case documentList(requestValue: DocumentListViewModelRequestValue)
}

// MARK: DefaultProfileFlowCoordinator
public final class DefaultProfileFlowCoordinator {

    // MARK: DI Variable
    let navigationController: UINavigationController
    let flowCoordinatorFactory: FlowCoordinatorFactory
    let presentationFactory: ProfileFlowCoordinatorFactory

    // MARK: Init Funciton
    public init(
        navigationController: UINavigationController,
        flowCoordinatorFactory: FlowCoordinatorFactory,
        presentationFactory: ProfileFlowCoordinatorFactory
    ) {
        self.navigationController = navigationController
        self.flowCoordinatorFactory = flowCoordinatorFactory
        self.presentationFactory = presentationFactory
    }
    
}

extension DefaultProfileFlowCoordinator: ProfileFlowCoordinator {
    
    public func start(with instructor: ProfileFlowCoordinatorInstructor) {
        switch instructor {
        case .dashboard(let requestValue):
            let route = ProfileDashboardViewModelRoute(
                startProfileFlow: self.start(with:),
                startInitialFlow: self.startInitialFlow(_:),
                startDialogFlow: self.startDialogFlow(_:)
            )
            let controller = self.presentationFactory.makeProfileDashboardController(requestValue: requestValue, route: route)
            self.navigationController.setViewControllers([controller], animated: true)
        case .familyMember(let requestValue):
            let route = FamilyMemberViewModelRoute(
                pop: self.pop, startDialogFlow: self.startDialogFlow(_:)
            )
            let controller = self.presentationFactory.makeFamilyMemberController(requestValue: requestValue, route: route)
            self.navigationController.pushViewController(controller, animated: true)
        case .activityList(let requestValue):
            let route = ActivityListViewModelRoute()
            let controller = self.presentationFactory.makeActivityListController(requestValue: requestValue, route: route)
            self.navigationController.pushViewController(controller, animated: true)
        case .documentList(let requestValue):
            let route = DocumentListViewModelRoute(startDocumentFlow: self.startDocumentFlow(_:))
            let controller = self.presentationFactory.makeDocumentListController(requestValue: requestValue, route: route)
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
    
}

private extension DefaultProfileFlowCoordinator {
    
    func pop() {
        DispatchQueue.main.async {
            self.navigationController.popViewController(animated: true)
        }
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
    
    func startDocumentFlow(_ instructor: DocumentFlowCoordinatorInstructor) {
        DispatchQueue.main.async {
            self.flowCoordinatorFactory.instantiateDocumentFlowCoordinator(navigationController: self.navigationController).start(with: instructor)
        }
    }
    
}
