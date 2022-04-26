//
//  MainNavigationController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 21/10/21.
//

import UIKit
import SPPermissions

public final class MainNavigationController: UINavigationController {

    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
        self.navigationBar.prefersLargeTitles = false
    }


}

extension MainNavigationController: SPPermissionsDelegate, SPPermissionsDataSource {
    
    public func configure(_ cell: SPPermissionsTableViewCell, for permission: SPPermissions.Permission) {
        cell.configureCell(forPermission: permission)
    }
    
    public func deniedAlertTexts(for permission: SPPermissions.Permission) -> SPPermissionsDeniedAlertTexts? {
        return nil
    }
    
    public func didHidePermissions(_ permissions: [SPPermissions.Permission]) {
        UserPreference.shared.doneAppLaunchPermission = true
    }
    
}
