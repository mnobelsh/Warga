//
//  MapView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 11/10/21.
//

import UIKit
import MapKit
import CoreLocation

public final class MapView: MKMapView {
    
    static let shared = MapView(frame: UIScreen.main.bounds)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.mapType = .standard
        self.showsCompass = false
        self.showsTraffic = false
        self.showsUserLocation = false
        self.setUserTrackingMode(.none, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureMapView(withLocation location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: CLLocationDegrees(0.0012), longitudeDelta: CLLocationDegrees(0.0012))
        var region = MKCoordinateRegion(center: location.coordinate, span: span)
        region.span = span
        self.setRegion(region, animated: false)
    }
    
}
