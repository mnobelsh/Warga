//
//  RequestDocumentController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//  Copyright (c) 2022 All rights reserved.

import UIKit
import RxSwift

// MARK: RequestDocumentController
public final class RequestDocumentController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: RequestDocumentView = DefaultRequestDocumentView()
    var viewModel: RequestDocumentViewModel!
    private let disposeBag = DisposeBag()
    
    var scannedDocument: DocumentRequiredDomain?
    
    var displayedRequiredDocument = [DocumentRequiredDomain]() {
        didSet {
            DispatchQueue.main.async {
                self._view.tableView.performBatchUpdates {
                    self._view.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
                }
                self._view.setConfirmationButton(isEnabled: self.displayedRequiredDocument.filter { !$0.isUserOwned }.isEmpty)
            }
        }
    }
    
    class func create(with viewModel: RequestDocumentViewModel) -> RequestDocumentController {
        let controller = RequestDocumentController()
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
private extension RequestDocumentController {
    
    func bind(to viewModel: RequestDocumentViewModel) {
        self.observe(on: viewModel.response.asObservable())
        self.observe(on: viewModel.displayedRequiredDocuments.asObservable())
    }
    
    func setupViewDidLoad() {
        self._view.configureView(withDocument: self.viewModel.document)
        self._view.tableView.delegate = self
        self._view.tableView.dataSource = self
        self._view.confirmationButton.addTarget(self, action: #selector(self.onConfirmationButtonDidTap(_:)), for: .touchUpInside)
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
    
    func observe(on observable: Observable<[DocumentRequiredDomain]>) {
        observable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] documents in
                guard let self = self else { return }
                self.displayedRequiredDocument = documents
            })
            .disposed(by: self.disposeBag)
    }
    
    func observe(on observable: Observable<RequestDocumentViewModelResponse>) {
        observable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                switch response {
                case .requestDocumentDidSuccess:
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                default:
                    break
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    @objc
    func onConfirmationButtonDidTap(_ sender: UIButton) {
        self.viewModel.doRequestDocument()
    }
    
}

// MARK: RequestDocumentController+RequestDocumentViewDelegate
extension RequestDocumentController: RequestDocumentViewDelegate {
    
}

extension RequestDocumentController: UITableViewDataSource, UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedRequiredDocument.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RequestDocumentTableCell.reuseIdentifier, for: indexPath) as? RequestDocumentTableCell else { return UITableViewCell() }
        cell.configureCell(with: self.displayedRequiredDocument[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    
    
}

extension RequestDocumentController: RequestDocumentTableCellDelegate {
    
    public func cellDidTap(uploadDocumentButton button: UIButton, forDocument: DocumentRequiredDomain) {
        self.scannedDocument = forDocument
        let requestValue = ScanDocumentViewModelRequestValue(delegate: self)
        self.viewModel.showScanDocumentUI(presentingController: self, requestValue: requestValue)
    }
    
}


extension RequestDocumentController: ScanDocumentViewModelDelegate {
    
    public func didRecognizeText(textGroup: [String]) {
        
    }
    
    public func didScanDocument(pdfData: Data) {
        let newDocument = DocumentDTO(
            id: self.scannedDocument?.type.id,
            file_name: self.scannedDocument?.type.title,
            base64EncodedString: pdfData.base64EncodedString()
        )
        guard var updatedProfile = UserPreference.shared.currentProfile else { return }
        if updatedProfile.dokumen.contains(where: { $0.id == newDocument.id }) {
            updatedProfile.dokumen.removeAll(where: { $0.id == newDocument.id })
        }
        updatedProfile.dokumen.append(newDocument)
        self.viewModel.doUpdateProfile(newProfile: updatedProfile)
        self.scannedDocument = nil
    }
    
    public func didFailWithError(_ error: Error) {
        
    }
    
    
}
