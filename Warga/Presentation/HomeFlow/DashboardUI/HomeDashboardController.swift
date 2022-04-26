//
//  HomeDashboardController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import RxSwift
import SPPermissions


// MARK: HomeDashboardController
public final class HomeDashboardController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: HomeDashboardView = DefaultHomeDashboardView()
    var viewModel: HomeDashboardViewModel!
    
    private let disposeBag = DisposeBag()
    var displayedNews = [NewsDomain]()
    var displayedCurrentForecast: ForecastDomain?
    var displayedHourlyForecasts = [ForecastDomain]()
    var response: HomeDashboardViewModelResponse = .fetchingAllData
    var covidMenu: [DashboardCovidMenu] = DashboardCovidMenu.list
    
    class func create(with viewModel: HomeDashboardViewModel) -> HomeDashboardController {
        let controller = HomeDashboardController()
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
private extension HomeDashboardController {
    
    func bind(to viewModel: HomeDashboardViewModel) {
        self.bindDisplayedNews(viewModel.displayedNews.asObservable())
        self.bindDisplayedResponse(viewModel.displayedResponse.asObservable())
        self.bindDisplayedCurrentWeather(viewModel.displayedCurrentForecast.asObservable())
        self.bindDisplayedHourlyWeathers(viewModel.displayedHourlyForecasts.asObservable())
    }
    
    func setupViewDidLoad() {
        self._view.collectionView.sectionDelegate = self
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
    
    func bindDisplayedCurrentWeather(_ observable: Observable<ForecastDomain>) {
        observable
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] forecast in
                guard let self = self else { return }
                self.displayedCurrentForecast = forecast
            })
            .disposed(by: self.disposeBag)
    }
    
    func bindDisplayedHourlyWeathers(_ observable: Observable<[ForecastDomain]>) {
        observable
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] forecasts in
                guard let self = self else { return }
                self.displayedHourlyForecasts = forecasts
            })
            .disposed(by: self.disposeBag)
    }
    
    func bindDisplayedNews(_ observable: Observable<[NewsDomain]>) {
        observable
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] news in
                guard let self = self else { return }
                self.displayedNews = news
            })
            .disposed(by: self.disposeBag)
    }
    
    func bindDisplayedResponse(_ observable: Observable<HomeDashboardViewModelResponse>) {
        observable
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                self.response = response
                switch response {
                case .fetchingAllData:
                    self._view.collectionView.reloadData()
                case .fetchForecastDidSuccess,.fetchForecastDidFail:
                    self._view.collectionView.refreshControl?.endRefreshing()
                    self._view.reloadSection(at: .header)
                case .fetchNewsDidSuccess,.fetchNewsDidFail:
                    self._view.collectionView.refreshControl?.endRefreshing()
                    self._view.reloadSection(at: .berita)
                }
            })
            .disposed(by: self.disposeBag)
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
        self.viewModel.fetchData()
    }
    
}

// MARK: HomeDashboardController+HomeDashboardViewDelegate
extension HomeDashboardController: HomeDashboardViewDelegate {
    
}


public struct DashboardCovidMenu {
    
    static let list: [DashboardCovidMenu] = MenuType.allCases.map { .init(type: $0) }
    
    public enum MenuType: CaseIterable {
        case vaksinasi
        case testMandiri
        case ketersediaanRumahSakit
        case donorDarah
    }

    var type: MenuType
    var title: String
    var description: String
    var icon: UIImage
    var image: UIImage?
    var destination: String
    
    init(type: MenuType) {
        self.type = type
        switch type {
        case .donorDarah:
            self.title = "Donor Plasma Konvalesen"
            self.description = ""
            self.icon = .bloodTest3D
            self.image = nil
            self.destination = "https://corona-dev.jakarta.go.id/en/donor-plasma"
        case .ketersediaanRumahSakit:
            self.title = "Ketersediaan Rumah Sakit"
            self.description = ""
            self.icon = .hospital3D
            self.image = nil
            self.destination = "http://eis.dinkes.jakarta.go.id/bed/"
        case .testMandiri:
            self.title = "Periksa Mandiri"
            self.description = ""
            self.icon = .doctorCheck3D
            self.image = nil
            self.destination = "https://rapidtest-corona.jakarta.go.id/"
        case .vaksinasi:
            self.title = "Vaksinasi COVID-19"
            self.description = ""
            self.icon = .vaccineNeedle3D
            self.image = nil
            self.destination = "https://vaksinasi-corona.jakarta.go.id/"
        }
    }
}
