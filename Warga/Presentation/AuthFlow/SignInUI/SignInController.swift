//
//  SignInController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import RxSwift

// MARK: SignInController
public final class SignInController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: SignInView = DefaultSignInView()
    var viewModel: SignInViewModel!
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Common Attributes
    private var usernameFormItem: FormTextFieldItem = {
        let formItem = FormTextFieldItem()
        formItem.title = "Nomor Induk Kependudukan"
        formItem.keyboardType = .numberPad
        return formItem
    }()
    private var passwordItem: FormTextFieldItem = {
        let formItem = FormTextFieldItem()
        formItem.title = "Kata Sandi"
        formItem.secureTextEntry = true
        return formItem
    }()
    lazy var formItems = [self.usernameFormItem,self.passwordItem]
    
    class func create(with viewModel: SignInViewModel) -> SignInController {
        let controller = SignInController()
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
private extension SignInController {
    
    func bind(to viewModel: SignInViewModel) {
        self.bindDisplayedLoadingState(viewModel.displayedLoadingState.asObservable())
        self.bindDisplayedResponse(viewModel.displayedResponse.asObservable())
    }
    
    func setupViewDidLoad() {
        self.setupFormTableView()
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
    }
    
    func setupFormTableView() {
        self._view.tableView.dataSource = self
        self._view.tableView.delegate = self
    }
    
    func setupGestures() {
        self._view.signInButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.doUserAuthentication(nik: self.usernameFormItem.value ?? "", password: self.passwordItem.value ?? "")
            })
            .disposed(by: self.disposeBag)
        self._view.registerButton.addTarget(self, action: #selector(self.onRegiterButtonTapped(_:)), for: .touchUpInside)
    }
    
    func bindDisplayedResponse(_ observable: Observable<SignInViewModelResponse>) {
        observable
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch response {
                    case .successSignIn:
                        self.startMainApp()
                    case .failedSignIn:
                        break
                    }
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    func bindDisplayedLoadingState(_ observable: Observable<LoadingView.State>) {
        observable
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { state in
                DispatchQueue.main.async {
                    state == .show ? LoadingView.show() : LoadingView.hide()
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    func startMainApp() {
        DispatchQueue.main.async {
            self.dismiss(animated: true) { [weak self] in
                self?.viewModel.showMainApp()
            }
        }
    }
    
    @objc
    func onRegiterButtonTapped(_ sender: UIButton) {
        self.viewModel.showRegisterUI()
    }
}

// MARK: SignInController+SignInViewDelegate
extension SignInController: SignInViewDelegate {
    
}
