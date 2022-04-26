//
//  CommunityDashboardController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import RxSwift
import RxGesture
import MapKit
import CoreLocation

// MARK: CommunityDashboardController
public final class CommunityDashboardController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: CommunityDashboardView = DefaultCommunityDashboardView()
    var viewModel: CommunityDashboardViewModel!
    
    lazy var contentVC = CommunityDashboardContentPanelController.create(with: self.viewModel)
    lazy var searchResultVC = CommunityDashboardSearchPanelController.create(with: self.viewModel)
    
    let disposeBag = DisposeBag()
    
    class func create(with viewModel: CommunityDashboardViewModel) -> CommunityDashboardController {
        let controller = CommunityDashboardController()
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
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupViewDidAppear()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setupViewWillDisappear()
    }
    
}

// MARK: Private Function
private extension CommunityDashboardController {
    
    func bind(to viewModel: CommunityDashboardViewModel) {
        self.bindDisplayedLocation(viewModel.displayedLocation.asObservable())
    }
    
    func setupViewDidLoad() {
        self.setupPanelController()
        self.setupGestures()
        self._view.mapView.delegate = self
        self._view.searchBar.delegate = self
        self._view.showContentPanel(at: self)
    }
    
    func setupViewWillAppear() {
        self._view.viewWillAppear(
            navigationBar: self.navigationController?.navigationBar,
            navigationItem: self.navigationItem,
            tabBarController: self.tabBarController
        )
    }
    
    func setupViewDidAppear() {
        self._view.viewDidAppear()
    }
    
    func setupViewWillDisappear() {
        self._view.viewWillDisappear()
    }
    
    func setupPanelController() {
        self.searchResultVC.delegate = self
        self._view.contentPanelController.set(contentViewController: self.contentVC)
        self._view.searchPanelController.set(contentViewController: self.searchResultVC)
        self._view.searchPanelController.track(scrollView: self.searchResultVC.tableView)
    }
    
    func bindDisplayedLocation(_ observable: Observable<CLLocation>) {
        observable.subscribe(on: MainScheduler.instance).subscribe { [weak self] location in
            guard let self = self else { return }
            self._view.mapView.configureMapView(withLocation: location)
        } onError: { error in
            print(error)
        }
        .disposed(by: self.disposeBag)
    }
    
    func setupGestures() {
        self._view.activityShortcutButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self._view.activityButtonIsShown.toggle()
                self._view.showActivityButtons(isShow: self._view.activityButtonIsShown)
            })
            .disposed(by: self.disposeBag)
        self._view.medicButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            })
            .disposed(by: self.disposeBag)
        self._view.quarantineButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            })
            .disposed(by: self.disposeBag)
        self._view.dangerButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            })
            .disposed(by: self.disposeBag)
        self._view.suspiciousButton.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
            })
            .disposed(by: self.disposeBag)
        
        self.searchResultVC.closeButton.rx
            .tapGesture()
            .when(.recognized).subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self._view.searchBar.resignFirstResponder()
                self._view.showContentPanel(at: self)
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: CommunityDashboardController+CommunityDashboardViewDelegate
extension CommunityDashboardController: CommunityDashboardViewDelegate {
    
}

extension CommunityDashboardController: MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
    
    public func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        print("[DEBUGS] VISIBLE REGION DID CHANGE \(mapView.visibleMapRect)")
    }
    
}

extension CommunityDashboardController: CommunityDashboardSearchPanelDelegate {
    
    public func searchPanelTableView(_ tableView: UITableView, didSelect mapItem: MKMapItem) {
        self._view.showContentPanel(at: self)
        guard let selectedLocation = mapItem.placemark.location else { return }
        self._view.mapView.configureMapView(withLocation: selectedLocation)
    }
    
}
