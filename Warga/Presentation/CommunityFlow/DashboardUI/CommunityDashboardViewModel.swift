//
//  CommunityDashboardViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation
import RxSwift
import RxRelay
import CoreLocation
import MapKit

// MARK: CommunityDashboardViewModelResponse
public enum CommunityDashboardViewModelResponse {

}

// MARK: CommunityDashboardViewModelDelegate
public protocol CommunityDashboardViewModelDelegate: AnyObject {
}

// MARK: - CommunityDashboardViewModelRequestValue
public struct CommunityDashboardViewModelRequestValue {
}

// MARK: - CommunityDashboardViewModelRoute
public struct CommunityDashboardViewModelRoute {
}

// MARK: - CommunityDashboardViewModelInput
public protocol CommunityDashboardViewModelInput {
    func viewDidLoad()
    func doSearchLocation(location: String, in region: MKCoordinateRegion)
}

// MARK: - CommunityDashboardViewModelOutput
public protocol CommunityDashboardViewModelOutput {
    var displayedLocation: PublishRelay<CLLocation> { get }
    var displayedSearchLocationResult: PublishRelay<[MKMapItem]> { get }
    var displayedResponse: PublishRelay<CommunityDashboardViewModelResponse> { get }
}

// MARK: - CommunityDashboardViewModel
public protocol CommunityDashboardViewModel: CommunityDashboardViewModelInput, CommunityDashboardViewModelOutput { }

// MARK: - DefaultCommunityDashboardViewModel
public final class DefaultCommunityDashboardViewModel: CommunityDashboardViewModel {

    // MARK: Dependency Variable
    weak var delegate: CommunityDashboardViewModelDelegate?
    let requestValue: CommunityDashboardViewModelRequestValue
    let route: CommunityDashboardViewModelRoute
    
    lazy var locationService = LocationService(delegate: self)

    // MARK: Output ViewModel Variable
    public let displayedLocation = PublishRelay<CLLocation>()
    public let displayedSearchLocationResult = PublishRelay<[MKMapItem]>()
    public let displayedResponse = PublishRelay<CommunityDashboardViewModelResponse>()

    init(
        requestValue: CommunityDashboardViewModelRequestValue,
        route: CommunityDashboardViewModelRoute
    ) {
        self.requestValue = requestValue
        self.route = route
    }

}

// MARK: Input ViewModel Function
public extension DefaultCommunityDashboardViewModel {

    func viewDidLoad() {
        self.locationService.updateLocation()
    }
    
    func doSearchLocation(location: String, in region: MKCoordinateRegion) {
        self.locationService.searchLocation(location, in: region) { result in
            self.displayedSearchLocationResult.accept(result)
        }
    }

}

// MARK: Private Function
private extension DefaultCommunityDashboardViewModel {

}

extension DefaultCommunityDashboardViewModel: LocationServiceDelegate {
    
    public func locationService(_ manager: CLLocationManager, didUpdateLocation location: CLLocation) {
        self.displayedLocation.accept(location)
    }

    public func locationServiceRequestWhenInUse(_ manager: CLLocationManager, with status: CLAuthorizationStatus) {
    
    }
    
}
