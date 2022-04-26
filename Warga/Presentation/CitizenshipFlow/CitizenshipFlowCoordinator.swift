//
//  CitizenshipFlowCoordinator.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

// MARK: CitizenshipFlowCoordinatorFactory
public protocol CitizenshipFlowCoordinatorFactory  {
    func makeCitizenshipDashboardController(
        requestValue: CitizenshipDashboardViewModelRequestValue,
        route: CitizenshipDashboardViewModelRoute
    ) -> CitizenshipDashboardController
    
    func makeDocumentDetailController(
        requestValue: DocumentDetailViewModelRequestValue,
        route: DocumentDetailViewModelRoute
    ) -> DocumentDetailController
    
    func makeRequestDocumentController(
        requestValue: RequestDocumentViewModelRequestValue,
        route: RequestDocumentViewModelRoute
    ) -> RequestDocumentController
}

// MARK: CitizenshipFlowCoordinator
public protocol CitizenshipFlowCoordinator {
    func start(with instructor: CitizenshipFlowCoordinatorInstructor)
}

// MARK: CitizenshipFlowCoordinatorInstructor
public enum CitizenshipFlowCoordinatorInstructor {
    case dashboard(requestValue: CitizenshipDashboardViewModelRequestValue)
    case documentDetail(requestValue: DocumentDetailViewModelRequestValue)
    case requestDocument(requestValue: RequestDocumentViewModelRequestValue)
}

// MARK: DefaultCitizenshipFlowCoordinator
public final class DefaultCitizenshipFlowCoordinator {

    // MARK: DI Variable
    let navigationController: UINavigationController
    let flowCoordinatorFactory: FlowCoordinatorFactory
    let presentationFactory: CitizenshipFlowCoordinatorFactory

    // MARK: Init Funciton
    public init(
        navigationController: UINavigationController,
        flowCoordinatorFactory: FlowCoordinatorFactory,
        presentationFactory: CitizenshipFlowCoordinatorFactory
    ) {
        self.navigationController = navigationController
        self.flowCoordinatorFactory = flowCoordinatorFactory
        self.presentationFactory = presentationFactory
    }
    
}

extension DefaultCitizenshipFlowCoordinator: CitizenshipFlowCoordinator {
    
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
    
    public func start(with instructor: CitizenshipFlowCoordinatorInstructor) {
        switch instructor {
        case .dashboard(let requestValue):
            let route = CitizenshipDashboardViewModelRoute(startCitzenshipFlow: self.start(with:))
            let controller = self.presentationFactory.makeCitizenshipDashboardController(requestValue: requestValue, route: route)
            self.navigationController.setViewControllers([controller], animated: true)
        case .documentDetail(let requestValue):
            let route = DocumentDetailViewModelRoute(startCitizenshipFlow: self.start(with:))
            let controller = self.presentationFactory.makeDocumentDetailController(requestValue: requestValue, route: route)
            self.navigationController.pushViewController(controller, animated: true)
        case .requestDocument(let requestValue):
            let route = RequestDocumentViewModelRoute(startDocumentFlow: self.startDocumentFlow(_:), startDialogFlow: self.startDialogFlow(_:))
            let controller = self.presentationFactory.makeRequestDocumentController(requestValue: requestValue, route: route)
            self.navigationController.present(controller, animated: true)
        }
    }
    
}
