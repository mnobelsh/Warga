//
//  ProfileDashboardController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import RxSwift

// MARK: ProfileDashboardController
public final class ProfileDashboardController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: ProfileDashboardView = DefaultProfileDashboardView()
    var viewModel: ProfileDashboardViewModel!
    
    let disposeBag = DisposeBag()
    
    public var profileInfoMenu = [ProfileDashboardMenu]()
    public var appConfigurationMenu = [ProfileDashboardMenu]()
    public var authConfigurationMenu = [ProfileDashboardMenu]()
    
    class func create(with viewModel: ProfileDashboardViewModel) -> ProfileDashboardController {
        let controller = ProfileDashboardController()
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
        self.viewModel.viewWillAppear()
    }
    
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setupViewWillDisappear()
    }
    
}

// MARK: Private Function
private extension ProfileDashboardController {
    
    func bind(to viewModel: ProfileDashboardViewModel) {
        self.bindDisplayedProfile(viewModel.displayedProfile.asObservable())
        self.bindDisplayedLoadingState(viewModel.displayedLoadingState.asObservable())
    }
    
    func setupViewDidLoad() {
        self._view.tableView.dataSource = self
        self._view.tableView.delegate = self
        self._view.showLoadingContent()
        self.setupGestures()
    }
    
    func setupViewWillAppear() {
        self._view.viewWillAppear(
            navigationBar: self.navigationController?.navigationBar,
            navigationItem: self.navigationItem,
            tabBarController: self.tabBarController
        )
        self.profileInfoMenu = [
            ProfileDashboardMenu(type: .activites, title: "Aktivitas Saya", iconImage: .starIsometric),
            ProfileDashboardMenu(type: .documents, title: "Dokumen Saya", iconImage: .filesIsometric),
        ]
        self.appConfigurationMenu = [
            ProfileDashboardMenu(type: .termsAndConditions, title: "Syarat & Ketentuan", iconImage: .documentIsometric),
        ]
        self.authConfigurationMenu = [
            ProfileDashboardMenu(type: .signOut, title: "Keluar", iconImage: .doorOpenIcon, backgroundColor: UIColor(gradientStyle: .leftToRight, withFrame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40), andColors: [ UIColor(hexString: "#fd746c") ?? .softRed, UIColor(hexString: "#ff9068") ?? .orange]), accessoryType: .none),
        ]
        self._view.tableView.reloadData()
    }
    
    func setupViewWillDisappear() {
        self._view.viewWillDisappear()
    }
    
    func bindDisplayedProfile(_ observable: Observable<ProfileDTO>) {
        observable
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] profile in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self._view.configureProfileData(with: profile)
                    self._view.hideLoadingContent()
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    func bindDisplayedLoadingState(_ observable: Observable<LoadingView.State>) {
        observable
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { state in
                state == .show ? LoadingView.show() : LoadingView.hide()
            })
            .disposed(by: self.disposeBag)
    }
    
    func setupGestures() {
        self._view.tableView.refreshControl?.addTarget(
            self,
            action: #selector(self.onRefreshControlValueChanged(_:)),
            for: .valueChanged
        )
    }
    
    @objc
    func onRefreshControlValueChanged(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            sender.endRefreshing()
        }
    }
    
}

// MARK: ProfileDashboardController+ProfileDashboardViewDelegate
extension ProfileDashboardController: ProfileDashboardViewDelegate {
    
}
