//
//  DocumentFlowCoordinator.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit

// MARK: DocumentFlowCoordinatorFactory
public protocol DocumentFlowCoordinatorFactory  {
    func makeScanDocumentController(
        requestValue: ScanDocumentViewModelRequestValue,
        route: ScanDocumentViewModelRoute
    ) -> ScanDocumentController
    func makeViewDocumentController(
        requestValue: ViewDocumentViewModelRequestValue,
        route: ViewDocumentViewModelRoute
    ) -> ViewDocumentController
}

// MARK: DocumentFlowCoordinator
public protocol DocumentFlowCoordinator {
    func start(with instructor: DocumentFlowCoordinatorInstructor)
}

// MARK: DocumentFlowCoordinatorInstructor
public enum DocumentFlowCoordinatorInstructor {
    case scanDocument(presentingController: UIViewController,requestValue: ScanDocumentViewModelRequestValue)
    case viewDocument(requestValue: ViewDocumentViewModelRequestValue)
}

// MARK: DefaultDocumentFlowCoordinator
public final class DefaultDocumentFlowCoordinator {

    // MARK: DI Variable
    let navigationController: UINavigationController
    let flowCoordinatorFactory: FlowCoordinatorFactory
    let presentationFactory: DocumentFlowCoordinatorFactory

    // MARK: Init Funciton
    public init(
        navigationController: UINavigationController,
        flowCoordinatorFactory: FlowCoordinatorFactory,
        presentationFactory: DocumentFlowCoordinatorFactory
    ) {
        self.navigationController = navigationController
        self.flowCoordinatorFactory = flowCoordinatorFactory
        self.presentationFactory = presentationFactory
    }
    
}

extension DefaultDocumentFlowCoordinator: DocumentFlowCoordinator {
    
    public func start(with instructor: DocumentFlowCoordinatorInstructor) {
        switch instructor {
        case .scanDocument(let presentingController, let requestValue):
            let vc = self.initScanDocumentController(requestValue: requestValue)
            presentingController.present(vc, animated: true, completion: nil)
        case .viewDocument(let requestValue):
            let route = ViewDocumentViewModelRoute()
            let vc = self.presentationFactory.makeViewDocumentController(requestValue: requestValue, route: route)
            self.navigationController.pushViewController(vc, animated: true)
        }
    }
    
}

private extension DefaultDocumentFlowCoordinator {
    
    func initScanDocumentController(requestValue: ScanDocumentViewModelRequestValue) -> ScanDocumentController {
        let route = ScanDocumentViewModelRoute(
            startDialogFlow: self.startDialogFlow(_:)
        )
        return self.presentationFactory.makeScanDocumentController(requestValue: requestValue, route: route)
    }
    
    func startDialogFlow(_ instructor: DialogFlowCoordinatorInstructor) {
        DispatchQueue.main.async {
            self.flowCoordinatorFactory.instantiateDialogFlowCoordinator(navigationController: self.navigationController).start(with: instructor)
        }
    }
    
}
