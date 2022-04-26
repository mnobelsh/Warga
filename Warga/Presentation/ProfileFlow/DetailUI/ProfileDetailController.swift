//
//  ProfileDetailController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: ProfileDetailController
public final class ProfileDetailController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: ProfileDetailView = DefaultProfileDetailView()
    var viewModel: ProfileDetailViewModel!
    
    class func create(with viewModel: ProfileDetailViewModel) -> ProfileDetailController {
        let controller = ProfileDetailController()
        controller.viewModel = viewModel
        return controller
    }
    
    public override func loadView() {
        self._view.delegate = self
        self.view = self._view.asView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
        self.bind(to: self.viewModel)
        self.viewModel.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViewWillAppear()
    }
    
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setupViewWillDisappear()
    }
    
}

// MARK: Public Function
public extension ProfileDetailController {
    
    func route(_ route: ProfileDetailViewModelRoute) {
    }
    
}

// MARK: Private Function
private extension ProfileDetailController {
    
    func bind(to viewModel: ProfileDetailViewModel) {
    }
    
    func setupViewDidLoad() {
    }
    
    func setupViewWillAppear() {
        self._view.viewWillAppear(
            navigationBar: self.navigationController?.navigationBar,
            navigationItem: self.navigationItem,
            tabBarController: self.tabBarController
        )
    }
    
    func setupViewWillDisappear() {
        self._view.viewWillDisappear()
    }
    
}

// MARK: ProfileDetailController+ProfileDetailViewDelegate
extension ProfileDetailController: ProfileDetailViewDelegate {
    
}
