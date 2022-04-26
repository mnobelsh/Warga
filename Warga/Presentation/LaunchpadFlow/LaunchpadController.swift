//
//  LaunchpadController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 09/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import SPPermissions

// MARK: LaunchpadController
public final class LaunchpadController: UITabBarController {
    
    // MARK: Dependency Variable
    var viewModel: LaunchpadViewModel!
    
    class func create(with viewModel: LaunchpadViewModel) -> LaunchpadController {
        let controller = LaunchpadController()
        controller.viewModel = viewModel
        return controller
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bind(to: self.viewModel)
        self.setupViewWillAppear()
    }
    
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setupViewWillDisappear()
    }
    
}

// MARK: Private Function
private extension LaunchpadController {
    
    func bind(to viewModel: LaunchpadViewModel) {
    }
    
    func setupViewDidLoad() {
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundColor = .white
        self.tabBar.dropShadow(offset: CGSize(width: 0, height: 0), opacity: 0.35)
        self.tabBar.barTintColor = .lightGray
        self.view.backgroundColor = .background
    }
    
    func setupViewWillAppear() {
        self.navigationController?.navigationBar.isHidden = true
        self.setViewControllers([
            self.viewModel.requestValue.homeNavigationController as! UINavigationController,
            self.viewModel.requestValue.citizenshipNavigationController as! UINavigationController,
            self.viewModel.requestValue.profileNavigationController as! UINavigationController
        ], animated: true)
        self.viewModel.showAppPermission()
    }
    
    func setupViewWillDisappear() {

    }
    
}
