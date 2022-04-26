//
//  CitizenshipDashboardController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import RxSwift

// MARK: CitizenshipDashboardController
public final class CitizenshipDashboardController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: CitizenshipDashboardView = DefaultCitizenshipDashboardView()
    var viewModel: CitizenshipDashboardViewModel!
    
    private let disposeBag = DisposeBag()
    
    var ongoingDocument: RequestDocumentDTO? {
        didSet {
            DispatchQueue.main.async {
                self._view.collectionView.performBatchUpdates {
                    self._view.collectionView.reloadSections(IndexSet(integer: 0))
                }
            }
        }
    }
    
    var completed = 3
    var total = 3
    
    class func create(with viewModel: CitizenshipDashboardViewModel) -> CitizenshipDashboardController {
        let controller = CitizenshipDashboardController()
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
private extension CitizenshipDashboardController {
    
    func bind(to viewModel: CitizenshipDashboardViewModel) {
        self.observe(on: viewModel.requestedDocument.asObservable())
    }
    
    func setupViewDidLoad() {
        self._view.collectionView.dataSource = self
        self._view.collectionView.delegate = self
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
    
    func setupGestures() {
        self._view.collectionView.refreshControl?.addTarget(
            self,
            action: #selector(self.onRefreshControlValueChanged(_:)),
            for: .valueChanged
        )
    }
    
    @objc
    func onRefreshControlValueChanged(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            self.completed = 14
            self._view.collectionView.reloadData()
            sender.endRefreshing()
        }
    }
    
    func observe(on observable: Observable<RequestDocumentDTO?>) {
        observable.subscribe(on: MainScheduler.instance).subscribe(onNext: {[weak self] document in
            guard let self = self else { return }
            self.ongoingDocument = document
        })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: CitizenshipDashboardController+CitizenshipDashboardViewDelegate
extension CitizenshipDashboardController: CitizenshipDashboardViewDelegate {
    
}
