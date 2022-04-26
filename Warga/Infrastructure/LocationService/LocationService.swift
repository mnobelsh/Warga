//
//  LocationService.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 13/10/21.
//

import Foundation
import CoreLocation
import MapKit

@objc
public protocol LocationServiceDelegate: AnyObject {
    func locationService(_ manager: CLLocationManager, didUpdateLocation location: CLLocation)
    @objc optional func locationService(_ manager: CLLocationManager, didFailWithError error: Error)
    func locationServiceRequestWhenInUse(_ manager: CLLocationManager, with status: CLAuthorizationStatus)
}

public final class LocationService: NSObject {
    
    init(delegate: LocationServiceDelegate) {
        self.delegate = delegate
    }
    
    public weak var delegate: LocationServiceDelegate?
    private lazy var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()
    private var localSearchRequest: MKLocalSearch.Request = MKLocalSearch.Request()
    private var geocoder: CLGeocoder = CLGeocoder()

    public func updateLocation() {
        self.manager.startUpdatingLocation()
    }
    
    public func searchLocation(_ location: String, in region: MKCoordinateRegion, completion: @escaping([MKMapItem]) -> Void) {
        self.localSearchRequest.naturalLanguageQuery = location
        self.localSearchRequest.region = region
        self.localSearchRequest.resultTypes = [.pointOfInterest,.address]
        let localSearch = MKLocalSearch(request: self.localSearchRequest)
        localSearch.start { response, error in
            completion(response?.mapItems.filter { $0.placemark.countryCode == "ID" } ?? [])
        }
    }
    
    public func getPlaceMark(latitude: Double, longitude: Double, completion: @escaping(Result<[CLPlacemark], Error>) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        self.geocoder.reverseGeocodeLocation(location, preferredLocale: .autoupdatingCurrent) { placemarks, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(placemarks ?? []))
            }
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        guard let latestLocation = locations.last else { return }
        self.delegate?.locationService(manager, didUpdateLocation: latestLocation)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        self.delegate?.locationService?(manager, didFailWithError: error)
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            self.delegate?.locationServiceRequestWhenInUse(manager, with: status)
        }
    }
}
