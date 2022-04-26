//
//  DialogFlowCoordinator.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.
//

import UIKit
import SwiftMessages
import SPPermissions
import SPPermissionsCamera
import SPPermissionsLocationWhenInUse
import SPPermissionsPhotoLibrary
import SPPermissionsNotification

// MARK: DialogFlowCoordinatorFactory
public protocol DialogFlowCoordinatorFactory  {
    func makeWebViewController(
        requestValue: WebViewViewModelRequestValue,
        route: WebViewViewModelRoute
    ) -> WebViewController
}

// MARK: DialogFlowCoordinator
public protocol DialogFlowCoordinator {
    func start(with instructor: DialogFlowCoordinatorInstructor)
}

// MARK: DialogFlowCoordinatorInstructor
public enum DialogFlowCoordinatorInstructor {
    case permission(permissions: [SPPermissions.Permission])
    case alert(requestValue: AlertDialogViewRequestValue)
    case instruction(requestValue: InstructionDialogViewRequestValue)
    case webView(requestValue: WebViewViewModelRequestValue)
    case showQRCode(requestValue: ShowQRCodeDialogViewRequestValue)
    case confirmationDialog(requestValue: ConfirmationDialogRequestValue)
}

// MARK: DefaultDialogFlowCoordinator
public final class DefaultDialogFlowCoordinator {

    // MARK: DI Variable
    let navigationController: UINavigationController
    let flowCoordinatorFactory: FlowCoordinatorFactory
    let presentationFactory: DialogFlowCoordinatorFactory

    // MARK: Init Funciton
    public init(
        navigationController: UINavigationController,
        flowCoordinatorFactory: FlowCoordinatorFactory,
        presentationFactory: DialogFlowCoordinatorFactory
    ) {
        self.navigationController = navigationController
        self.flowCoordinatorFactory = flowCoordinatorFactory
        self.presentationFactory = presentationFactory
    }
    
}

extension DefaultDialogFlowCoordinator: DialogFlowCoordinator {
    
    public func start(with instructor: DialogFlowCoordinatorInstructor) {
        switch instructor {
        case .permission(let permissions):
            let vc = self.initPermissionDialog(permissions: permissions)
            vc.present(on: self.navigationController)
        case .alert(let requestValue):
            self.showAlertDialog(requestValue: requestValue)
        case .instruction(let requestValue):
            self.showInstructionDialog(requestValue: requestValue)
        case .webView(let requestValue):
            let vc = self.initWebViewController(requestValue: requestValue)
            self.navigationController.pushViewController(vc, animated: true)
        case .showQRCode(let requestValue):
            self.showQRCodeDialog(requestValue: requestValue)
        case .confirmationDialog(let requestValue):
            self.showConfirmationDialogView(requestValue: requestValue)
        }
    }
    
}

private extension DefaultDialogFlowCoordinator {
    
    func pop() {
        DispatchQueue.main.async {
            self.navigationController.popViewController(animated: true)
        }
    }
    
    func initWebViewController(requestValue: WebViewViewModelRequestValue) -> WebViewController {
        let route = WebViewViewModelRoute(
            pop: self.pop
        )
        return self.presentationFactory.makeWebViewController(
            requestValue: requestValue,
            route: route
        )
    }
    
    func initPermissionDialog(
        permissions: [SPPermissions.Permission]
    ) -> SPPermissionsDialogController {
        
        let permissionController = SPPermissions.dialog(permissions)
        permissionController.delegate = self.navigationController as? SPPermissionsDelegate
        permissionController.dataSource = self.navigationController as? SPPermissionsDataSource
        permissionController.dismissCondition = .allPermissionsAuthorized
        permissionController.allowSwipeDismiss = true
        permissionController.showCloseButton = true
        
        return permissionController
    }
    
    func showAlertDialog(requestValue: AlertDialogViewRequestValue) {
        let view = AlertDialogView(requestValue: requestValue)
        view.snp.makeConstraints {
            $0.height.equalTo(150)
        }
        
        var config = SwiftMessages.defaultConfig
        config.dimMode = .none
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: .alert)
        config.duration = requestValue.duration
        config.interactiveHide = true
        config.ignoreDuplicates = true
        config.shouldAutorotate = true
        
        SwiftMessages.show(config: config, view: view)
    }
    
    func showInstructionDialog(requestValue: InstructionDialogViewRequestValue) {
        let view = InstructionDialogView(requestValue: requestValue)
        
        var config = SwiftMessages.defaultConfig
        config.dimMode = .blur(style: .systemUltraThinMaterialDark, alpha: 0.6, interactive: true)
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: .normal)
        config.duration = requestValue.duration
        config.interactiveHide = true
        config.ignoreDuplicates = true
        config.shouldAutorotate = true
        
        SwiftMessages.show(config: config, view: view)
    }
    
    
    func showQRCodeDialog(requestValue: ShowQRCodeDialogViewRequestValue) {
        let view = ShowQRCodeDialogView(requestValue: requestValue)
        
        var config = SwiftMessages.defaultConfig
        config.dimMode = .blur(style: .systemUltraThinMaterialDark, alpha: 0.6, interactive: true)
        config.presentationStyle = .center
        config.presentationContext = .automatic
        config.duration = .forever
        config.interactiveHide = true
        config.ignoreDuplicates = true
        config.shouldAutorotate = true
        
        SwiftMessages.show(config: config, view: view)
    }
    
    func showConfirmationDialogView(requestValue: ConfirmationDialogRequestValue) {
        let view = ConfirmationDialogView(requestValue: requestValue)
        
        var config = SwiftMessages.defaultConfig
        config.dimMode = .blur(style: .systemUltraThinMaterialDark, alpha: 0.6, interactive: true)
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: .normal)
        config.duration = .forever
        config.interactiveHide = true
        config.ignoreDuplicates = true
        config.shouldAutorotate = true
        
        SwiftMessages.show(config: config, view: view)
    }
}
