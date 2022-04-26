//
//  FamilyMemberController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import RxSwift
import RxGesture

// MARK: FamilyMemberController
public final class FamilyMemberController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: FamilyMemberView = DefaultFamilyMemberView()
    var viewModel: FamilyMemberViewModel!
    
    private let disposeBag = DisposeBag()
    
    // TODO: - Dummy data will be deleted
    var familyMember: [(name: String, relationship: String)] = [
        (name: "Muhammad Nobel Shidqi", relationship: "Saya"),
        (name: "Sarah Ray", relationship: "Istri"),
        (name: "Raymond Belford", relationship: "Anak"),
        (name: "Michelle Laundra", relationship: "Anak"),
    ]
    
    class func create(with viewModel: FamilyMemberViewModel) -> FamilyMemberController {
        let controller = FamilyMemberController()
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
public extension FamilyMemberController {
    
    func route(_ route: FamilyMemberViewModelRoute) {
    }
    
}

// MARK: Private Function
private extension FamilyMemberController {
    
    func bind(to viewModel: FamilyMemberViewModel) {
    }
    
    func setupViewDidLoad() {
        self._view.tableView.dataSource = self
        self._view.tableView.delegate = self
        self.configureGestures()
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
    
    func configureGestures() {
        self._view.addFamilyMemberButton
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
//                guard let self = self else { return }
//                guard let familyId = UserPreference.shared.currentProfile?.id_keluarga else { return }
//                let requestValue = ShowQRCodeDialogViewRequestValue(code: familyId)
//                self.viewModel.showQRCodeDialog(requestValue: requestValue)
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: FamilyMemberController+FamilyMemberViewDelegate
extension FamilyMemberController: FamilyMemberViewDelegate {
    
    public func onBackButtonDidTap(_ sender: UITapGestureRecognizer) {
        self.viewModel.popViewController()
    }
    
}
