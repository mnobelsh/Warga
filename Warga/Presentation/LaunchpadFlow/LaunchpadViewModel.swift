//
//  LaunchpadViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 09/10/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation
import SPPermissions

// MARK: LaunchpadViewModelResponse
public enum LaunchpadViewModelResponse {
}

// MARK: LaunchpadViewModelDelegate
public protocol LaunchpadViewModelDelegate: AnyObject {
}

// MARK: - LaunchpadViewModelRequestValue
public struct LaunchpadViewModelRequestValue {
    var citizenshipNavigationController: AnyObject
    var communityNavigationController: AnyObject
    var homeNavigationController: AnyObject
    var profileNavigationController: AnyObject
}

// MARK: - LaunchpadViewModelRoute
public struct LaunchpadViewModelRoute {
    var startDialogFlow: (_ instructor: DialogFlowCoordinatorInstructor) -> Void
}

// MARK: - LaunchpadViewModelInput
public protocol LaunchpadViewModelInput {
    func viewDidLoad()
    func showAppPermission()
}

// MARK: - LaunchpadViewModelOutput
public protocol LaunchpadViewModelOutput {
    var requestValue: LaunchpadViewModelRequestValue { get }
}

// MARK: - LaunchpadViewModel
public protocol LaunchpadViewModel: LaunchpadViewModelInput, LaunchpadViewModelOutput { }

// MARK: - DefaultLaunchpadViewModel
public final class DefaultLaunchpadViewModel: LaunchpadViewModel {

    // MARK: Dependency Variable
    weak var delegate: LaunchpadViewModelDelegate?
    public var requestValue: LaunchpadViewModelRequestValue

    private var route: LaunchpadViewModelRoute

    init(
        requestValue: LaunchpadViewModelRequestValue,
        route: LaunchpadViewModelRoute
    ) {
        self.requestValue = requestValue
        self.route = route
    }

}

// MARK: Input ViewModel Function
public extension DefaultLaunchpadViewModel {

    func viewDidLoad() {
    }
    
    func showAppPermission() {
        guard !UserPreference.shared.doneAppLaunchPermission else { return }
        self.route.startDialogFlow(
            .permission(permissions: [.notification,.camera,.locationWhenInUse])
        )
    }
}

// MARK: Private Function
private extension DefaultLaunchpadViewModel {
    
}

