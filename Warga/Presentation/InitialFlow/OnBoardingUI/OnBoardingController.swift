//
//  OnBoardingController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: OnBoardingController
public final class OnBoardingController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: OnBoardingView = DefaultOnBoardingView()
    var viewModel: OnBoardingViewModel!
    
    class func create(with viewModel: OnBoardingViewModel) -> OnBoardingController {
        let controller = OnBoardingController()
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
public extension OnBoardingController {
    
    func route(_ route: OnBoardingViewModelRoute) {
    }
    
}

// MARK: Private Function
private extension OnBoardingController {
    
    func bind(to viewModel: OnBoardingViewModel) {
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

// MARK: OnBoardingController+OnBoardingViewDelegate
extension OnBoardingController: OnBoardingViewDelegate {
    
}
