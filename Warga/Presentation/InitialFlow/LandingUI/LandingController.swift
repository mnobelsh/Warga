//
//  LandingController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import RxGesture
import RxSwift

// MARK: LandingController
public final class LandingController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: LandingView = DefaultLandingView()
    var viewModel: LandingViewModel!
    
    let disposeBag = DisposeBag()
    
    class func create(with viewModel: LandingViewModel) -> LandingController {
        let controller = LandingController()
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
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self._view.viewDidAppear()
    }
    
}

// MARK: Public Function
public extension LandingController {
    
    func route(_ route: LandingViewModelRoute) {
    }
    
}

// MARK: Private Function
private extension LandingController {
    
    func bind(to viewModel: LandingViewModel) {
    }
    
    func setupViewDidLoad() {
        self.setupGestures()
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
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupGestures() {
        
        self._view.leftBarView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe { _ in
                print("tapped!")
            } onError: { _ in }
            .disposed(by: self.disposeBag)
        
        self._view.signInButton.rx
            .tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.showSignInUI()
            } onError: { _ in }
            .disposed(by: self.disposeBag)
        
        self._view.signUpButton.rx
            .tap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.showSignUpUI()
            } onError: { _ in }
            .disposed(by: self.disposeBag)
        
        self._view.policyLabel.rx
            .tapGesture()
            .when(.recognized)
            .subscribe { _ in
                print("Privacy Policy")
            } onError: { _ in }
            .disposed(by: self.disposeBag)

    }
    
}

// MARK: LandingController+LandingViewDelegate
extension LandingController: LandingViewDelegate {
    
}
