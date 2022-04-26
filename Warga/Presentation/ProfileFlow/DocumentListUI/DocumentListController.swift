//
//  DocumentListController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//  Copyright (c) 2022 All rights reserved.

import UIKit
import RxSwift

// MARK: DocumentListController
public final class DocumentListController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: DocumentListView = DefaultDocumentListView()
    var viewModel: DocumentListViewModel!
    private let disposeBag = DisposeBag()
    
    var userDocuments = [DocumentDTO]() {
        didSet {
            DispatchQueue.main.async {
                self._view.collectionView.reloadData()
            }
        }
    }
    
    class func create(with viewModel: DocumentListViewModel) -> DocumentListController {
        let controller = DocumentListController()
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
private extension DocumentListController {
    
    func bind(to viewModel: DocumentListViewModel) {
        self.observe(on: viewModel.displayedDocuments.asObservable())
    }
    
    func setupViewDidLoad() {
        self.navigationItem.title = "Dokumen Saya"
        self._view.collectionView.delegate = self
        self._view.collectionView.dataSource = self
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
    
    func observe(on observable: Observable<[DocumentDTO]>) {
        observable
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] documents in
                guard let self = self else { return }
                self.userDocuments = documents
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: DocumentListController+DocumentListViewDelegate
extension DocumentListController: DocumentListViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.didSelectDocument(document: self.userDocuments[indexPath.row])
    }
    
}

extension DocumentListController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 50, height: 60)
    }
    
}

extension DocumentListController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.userDocuments.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DocumentListCollectionCell.reuseIdentifier, for: indexPath) as? DocumentListCollectionCell else { return UICollectionViewCell() }
        cell.configureCell(with: self.userDocuments[indexPath.row])
        return cell
    }
    
    
}
