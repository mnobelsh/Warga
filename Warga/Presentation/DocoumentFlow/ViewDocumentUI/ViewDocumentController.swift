//
//  ViewDocumentController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//  Copyright (c) 2022 All rights reserved.

import UIKit
import RxSwift

// MARK: ViewDocumentController
public final class ViewDocumentController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: ViewDocumentView = DefaultViewDocumentView()
    var viewModel: ViewDocumentViewModel!
    private let disposeBag = DisposeBag()
    
    var displayedDocuments = [DocumentDTO]() {
        didSet {
            DispatchQueue.main.async {
                self._view.collectionView.reloadData()
            }
        }
    }
    
    class func create(with viewModel: ViewDocumentViewModel) -> ViewDocumentController {
        let controller = ViewDocumentController()
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
private extension ViewDocumentController {
    
    func bind(to viewModel: ViewDocumentViewModel) {
    }
    
    func setupViewDidLoad() {
        self._view.collectionView.dataSource = self
        self._view.collectionView.delegate = self
        self.displayedDocuments = self.viewModel.documents
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
                self.displayedDocuments = documents
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: ViewDocumentController+ViewDocumentViewDelegate
extension ViewDocumentController: ViewDocumentViewDelegate {
    
}

extension ViewDocumentController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.displayedDocuments.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewDocumentCollectionCell.reuseIdentifier, for: indexPath) as? ViewDocumentCollectionCell else { return UICollectionViewCell() }
        cell.configureCell(with: self.displayedDocuments[indexPath.row])
        return cell
    }
    
    
}

extension ViewDocumentController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}
