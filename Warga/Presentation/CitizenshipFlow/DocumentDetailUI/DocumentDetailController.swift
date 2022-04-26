//
//  DocumentDetailController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 06/02/22.
//  Copyright (c) 2022 All rights reserved.

import UIKit

// MARK: DocumentDetailController
public final class DocumentDetailController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: DocumentDetailView = DefaultDocumentDetailView()
    var viewModel: DocumentDetailViewModel!
    
    class func create(with viewModel: DocumentDetailViewModel) -> DocumentDetailController {
        let controller = DocumentDetailController()
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
private extension DocumentDetailController {
    
    func bind(to viewModel: DocumentDetailViewModel) {
    }
    
    func setupViewDidLoad() {
        self._view.configureView(withDocument: self.viewModel.document)
        self.navigationItem.title = "Pengajuan Dokumen"
        
        self._view.requestButton.addTarget(self, action: #selector(self.onRequestButtonDidTap(_:)), for: .touchUpInside)
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
    
    @objc
    func onRequestButtonDidTap(_ sender: UIButton) {
        self.viewModel.doRequestDocument()
    }
    
}

// MARK: DocumentDetailController+DocumentDetailViewDelegate
extension DocumentDetailController: DocumentDetailViewDelegate {
    
}
