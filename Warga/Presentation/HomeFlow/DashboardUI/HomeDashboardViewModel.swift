//
//  HomeDashboardViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation
import RxSwift
import RxRelay
import PromiseKit
import CoreLocation

// MARK: HomeDashboardViewModelResponse
public enum HomeDashboardViewModelResponse {
    case fetchForecastDidSuccess
    case fetchForecastDidFail
    case fetchNewsDidSuccess
    case fetchNewsDidFail
    case fetchingAllData
}

// MARK: HomeDashboardViewModelDelegate
public protocol HomeDashboardViewModelDelegate: AnyObject {
}

// MARK: - HomeDashboardViewModelRequestValue
public struct HomeDashboardViewModelRequestValue {
}

// MARK: - HomeDashboardViewModelRoute
public struct HomeDashboardViewModelRoute {
    var startDialogFlow: (_ instructor: DialogFlowCoordinatorInstructor) -> Void
}

// MARK: - HomeDashboardViewModelInput
public protocol HomeDashboardViewModelInput {
    func viewDidLoad()
    func fetchData()
    func fetchForecast(in coordinate: (lat: Double, lon: Double)?)
    func didSelect(_ covidMenu: DashboardCovidMenu)
    func didSelect(_ news: NewsDomain)
}

// MARK: - HomeDashboardViewModelOutput
public protocol HomeDashboardViewModelOutput {
    var displayedNews: PublishRelay<[NewsDomain]> { get }
    var displayedResponse: PublishRelay<HomeDashboardViewModelResponse> { get }
    var displayedCurrentForecast: PublishRelay<ForecastDomain> { get }
    var displayedHourlyForecasts: PublishRelay<[ForecastDomain]> { get }
}

// MARK: - HomeDashboardViewModel
public protocol HomeDashboardViewModel: HomeDashboardViewModelInput, HomeDashboardViewModelOutput { }

// MARK: - DefaultHomeDashboardViewModel
public final class DefaultHomeDashboardViewModel: HomeDashboardViewModel {

    // MARK: Dependency Variable
    weak var delegate: HomeDashboardViewModelDelegate?
    let requestValue: HomeDashboardViewModelRequestValue
    let route: HomeDashboardViewModelRoute
    var userCoordinate: (lat: Double, lon: Double)?
    lazy var locationService = LocationService(delegate: self)

    // MARK: Output ViewModel Variable
    let disposeBag = DisposeBag()
    public let displayedNews = PublishRelay<[NewsDomain]>()
    public let displayedResponse = PublishRelay<HomeDashboardViewModelResponse>()
    public let displayedCoordinate = PublishRelay<(lat: Double, lon: Double)>()
    public let displayedCurrentForecast = PublishRelay<ForecastDomain>()
    public let displayedHourlyForecasts = PublishRelay<[ForecastDomain]>()
    
    // MARK: Use Case
    let fetchNewsUseCase: FetchNewsUseCase
    let fetchForecastUseCase: FetchForecastUseCase

    init(
        requestValue: HomeDashboardViewModelRequestValue,
        route: HomeDashboardViewModelRoute,
        fetchNewsUseCase: FetchNewsUseCase,
        fetchForecastUseCase: FetchForecastUseCase
    ) {
        self.requestValue = requestValue
        self.route = route
        self.fetchNewsUseCase = fetchNewsUseCase
        self.fetchForecastUseCase = fetchForecastUseCase
    }

}

// MARK: Input ViewModel Function
public extension DefaultHomeDashboardViewModel {

    func viewDidLoad() {
        self.fetchData()
    }

    func fetchData() {
        self.locationService.updateLocation()
        self.fetchNews()
    }
    
    func fetchForecast(in coordinate: (lat: Double, lon: Double)?) {
        self.displayedResponse.accept(.fetchingAllData)
        guard let lat = coordinate?.lat, let lon = coordinate?.lon else {
            self.displayedResponse.accept(.fetchForecastDidFail)
            return
        }
        let requestValue = FetchForecastUseCaseRequest(lat: lat, lon: lon)
        self.fetchForecastUseCase.execute(requestValue)
            .subscribe(on: MainScheduler.instance)
            .subscribe { [weak self] forecastInfo in
                guard let self = self else { return }
                self.displayedCurrentForecast.accept(forecastInfo.currentForecast)
                let upcomingForecasts = forecastInfo.hourlyForecasts.filter { $0.date > Date() }
                self.displayedHourlyForecasts.accept(Array(upcomingForecasts.prefix(16)))
                self.displayedResponse.accept(.fetchForecastDidSuccess)
            } onError: { error in
                self.displayedResponse.accept(.fetchForecastDidFail)
            }
            .disposed(by: self.disposeBag)
    }
    
    func didSelect(_ covidMenu: DashboardCovidMenu) {
        self.showWebView(title: covidMenu.title, source: covidMenu.destination)
    }
    
    func didSelect(_ news: NewsDomain) {
        let title = String(news.title.prefix(35)+"...")
        self.showWebView(title: title, source: news.sourceUrl)
    }

}

// MARK: Private Function
private extension DefaultHomeDashboardViewModel {

    func fetchNews() {
        self.displayedResponse.accept(.fetchingAllData)
        let requestValue = FetchNewsUseCaseRequest(source: .kumparan)
        self.fetchNewsUseCase.execute(requestValue)
            .subscribe(on: MainScheduler.instance)
            .subscribe { [weak self] news in
                guard let self = self else { return }
                self.displayedNews.accept(Array(news.prefix(5)))
                self.displayedResponse.accept(.fetchNewsDidSuccess)
            } onError: { error in
                self.displayedResponse.accept(.fetchNewsDidFail)
            }
            .disposed(by: self.disposeBag)
    }
    
    func showWebView(title: String, source: String) {
        let request = WebViewViewModelRequestValue(title: title, source: source)
        self.route.startDialogFlow(.webView(requestValue: request))
    }
    
}

extension DefaultHomeDashboardViewModel: LocationServiceDelegate {
    
    public func locationService(_ manager: CLLocationManager, didUpdateLocation location: CLLocation) {
        self.userCoordinate = (lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        self.fetchForecast(in: self.userCoordinate)
    }
    
    public func locationServiceRequestWhenInUse(_ manager: CLLocationManager, with status: CLAuthorizationStatus) {
        self.route.startDialogFlow(.permission(permissions: [.locationWhenInUse]))
    }
    
    public func locationService(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.route.startDialogFlow(.permission(permissions: [.locationWhenInUse]))
    }
    
}
