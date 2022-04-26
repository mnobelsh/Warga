//
//  OTPVerificationController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 20/09/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: OTPVerificationController
public final class OTPVerificationController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: OTPVerificationView = DefaultOTPVerificationView()
    var viewModel: OTPVerificationViewModel!
    
    class func create(with viewModel: OTPVerificationViewModel) -> OTPVerificationController {
        let controller = OTPVerificationController()
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
public extension OTPVerificationController {
    
    func route(_ route: OTPVerificationViewModelRoute) {
    }
    
}

// MARK: Private Function
private extension OTPVerificationController {
    
    func bind(to viewModel: OTPVerificationViewModel) {
    }
    
    func setupViewDidLoad() {
        self.setupTextFields()
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
    
    func setupTextFields() {
        self._view.firstOTPTextField.delegate = self
        self._view.secondOTPTextField.delegate = self
        self._view.thirdOTPTextField.delegate = self
        self._view.forthOTPTextField.delegate = self
        self._view.fifthOTPTextField.delegate = self
        self._view.sixthOTPTextField.delegate = self
    }
    
}

// MARK: OTPVerificationController+OTPVerificationViewDelegate
extension OTPVerificationController: OTPVerificationViewDelegate {
    
}
