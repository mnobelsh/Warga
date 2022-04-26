//
//  SignUpController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import RxSwift
import RxGesture
import WeScan

// MARK: SignUpController
public final class SignUpController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: SignUpView = DefaultSignUpView()
    var viewModel: SignUpViewModel!
    
    private let disposeBag = DisposeBag()
    
    private var scannedDocument: String?
    
    // MARK: - Common Attributes
    private var idFormItem: FormTextFieldItem = {
        let formItem = FormTextFieldItem()
        formItem.keyboardType = .numberPad
        formItem.title = "Nomor Induk Kependudukan"
        formItem.supplementaryText = .invalidField(formItem.title)
        return formItem
    }()
    private var nameFormItem: FormTextFieldItem = {
        let formItem = FormTextFieldItem()
        formItem.title = "Nama Lengkap (Sesuai KTP)"
        formItem.supplementaryText = .invalidField(formItem.title)
        return formItem
    }()
    private var emailFormItem: FormTextFieldItem = {
        let formItem = FormTextFieldItem()
        formItem.keyboardType = .emailAddress
        formItem.title = "Alamat Email"
        formItem.supplementaryText = .invalidField(formItem.title)
        return formItem
    }()
    private var passwordFormItem: FormTextFieldItem = {
        let formItem = FormTextFieldItem()
        formItem.title = "Kata Sandi"
        formItem.secureTextEntry = true
        formItem.supplementaryText = .passwordCharactersWarning
        return formItem
    }()
    
    lazy var formItems = [self.idFormItem,self.nameFormItem,self.emailFormItem, self.passwordFormItem]
    
    
    class func create(with viewModel: SignUpViewModel) -> SignUpController {
        let controller = SignUpController()
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
public extension SignUpController {
    
    func route(_ route: SignUpViewModelRoute) {
    }
    
}

// MARK: Private Function
private extension SignUpController {
    
    func bind(to viewModel: SignUpViewModel) {
        
        viewModel.displayedName
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] name in
                guard let self = self else { return }
                self.nameFormItem.value = name
                self.reloadFormTableView()
            })
            .disposed(by: self.disposeBag)
        
        viewModel.displayedNIKNumber
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] nik in
                guard let self = self else { return }
                self.idFormItem.value = nik
                self.reloadFormTableView()
            })
            .disposed(by: self.disposeBag)
        
        viewModel.displayedLoadingState
            .subscribe(on: MainScheduler.instance)
            .subscribe { state in
                DispatchQueue.main.async {
                    state == .show ? LoadingView.show() : LoadingView.hide()
                }
            } onError: { _ in }
            .disposed(by: self.disposeBag)
        
        viewModel.displayedResponse
            .subscribe(on: MainScheduler.instance)
            .subscribe { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .userAlreadyExist:
                    self.viewModel.showDialogFlow(alertType: .failure, title: "Nomor Induk Kependudukan yang anda masukan sudah terdaftar.")
                case .registerDidSuccess:
                    self.viewModel.showDialogFlow(alertType: .success, title: "Sukses melakukan registrasi.")
                    self.dismiss(animated: true, completion: nil)
                case .registerDidFail:
                    break
                }
            } onError: { _ in }
            .disposed(by: self.disposeBag)
        
        viewModel.scannedDocument
            .subscribe(on: MainScheduler.instance)
            .subscribe { [weak self] data in
                guard let self = self else { return }
                self.scannedDocument = data.base64EncodedString()
            } onError: { _ in }
            .disposed(by: self.disposeBag)

    }
    
    func setupViewDidLoad() {
        self._view.tableView.dataSource = self
        self._view.tableView.delegate = self
        self.setupFormItemHandlers()
        self.setupGestures()
    }
    
    func setupViewWillAppear() {
        self._view.viewWillAppear(
            navigationBar: self.navigationController?.navigationBar,
            navigationItem: self.navigationItem,
            tabBarController: self.tabBarController
        )
        self.validateFormInput(isValid: false)
    }
    
    func setupViewWillDisappear() {
        self._view.viewWillDisappear()
    }
    
    
    func setupGestures() {
        self._view.scanButton.rx
            .tap
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.showScanDocumentUI(presentingController: self)
            })
            .disposed(by: self.disposeBag)
        
        self._view.signUpButton.rx
            .tap.asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                let newProfile = ProfileDTO(
                    id: UUID().uuidString,
                    email: self.emailFormItem.value ?? "",
                    nik: self.idFormItem.value ?? "",
                    nama_lengkap: self.nameFormItem.value ?? "",
                    alamat: AddressDTO(alamat: "Pondok Bambu Permai Blok A/3", rt: "007", rw: "012", kelurahan: "Pondok Bambu", kecamatan: "Duren Sawit", kota: "Jakarta Timur", provinsi: "DKI Jakarta"),
                    dokumen: self.scannedDocument != nil ? [DocumentDTO(id: DocumentType.ktp.id, file_name: DocumentType.ktp.title, base64EncodedString: self.scannedDocument)] : []
                )
                guard let password = self.passwordFormItem.value else { return }
                self.viewModel.doSignUp(withProfile: newProfile, password: password)
            })
            .disposed(by: self.disposeBag)
    }
    
    func reloadFormTableView() {
        DispatchQueue.main.async {
            self._view.tableView.reloadData()
        }
    }
    
    func setupFormItemHandlers() {
        self.idFormItem.onFinish = { [weak self] cell, item in
            guard let self = self else { return }
            item.isValid = item.value?.isValidNikNumber() ?? false
            self.validateFormInput()
            self._view.tableView.reloadCell(cell)
        }
        self.nameFormItem.onFinish = { [weak self] cell, item in
            guard let self = self else { return }
            item.isValid = item.value?.isValidName() ?? false
            self.validateFormInput()
            self._view.tableView.reloadCell(cell)
        }
        self.emailFormItem.onFinish = { [weak self] cell, item in
            guard let self = self else { return }
            item.isValid = item.value?.isValidEmail() ?? false
            self.validateFormInput()
            self._view.tableView.reloadCell(cell)
        }
        self.passwordFormItem.onFinish = { [weak self] cell, item in
            guard let self = self else { return }
            item.isValid = item.value?.isValidPassword() ?? false
            self.validateFormInput()
            self._view.tableView.reloadCell(cell)
        }
    }
    
    func validateFormInput(isValid: Bool? = nil) {
        guard let isValid = isValid else {
            self._view.configureSignUpButtonEnabled(self.idFormItem.isValid && self.nameFormItem.isValid && self.emailFormItem.isValid && self.passwordFormItem.isValid)
            return
        }
        self._view.configureSignUpButtonEnabled(isValid)
    }
    
}

// MARK: SignUpController+SignUpViewDelegate
extension SignUpController: SignUpViewDelegate {
    
}


