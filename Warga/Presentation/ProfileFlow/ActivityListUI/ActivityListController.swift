//
//  ActivityListController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//  Copyright (c) 2022 All rights reserved.

import UIKit

// MARK: ActivityListController
public final class ActivityListController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: ActivityListView = DefaultActivityListView()
    var viewModel: ActivityListViewModel!
    
    class func create(with viewModel: ActivityListViewModel) -> ActivityListController {
        let controller = ActivityListController()
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

// MARK: Private Function
private extension ActivityListController {
    
    func bind(to viewModel: ActivityListViewModel) {
    }
    
    func setupViewDidLoad() {
        self.navigationItem.title = "Aktivitas Saya"
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

// MARK: ActivityListController+ActivityListViewDelegate
extension ActivityListController: ActivityListViewDelegate {
    
}
