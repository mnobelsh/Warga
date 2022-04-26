//
//  CommunityDashboardController+UISearchBar.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 28/10/21.
//

import UIKit
import MapKit

extension CommunityDashboardController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.doSearchLocation(location: searchText, in: self._view.mapView.region)
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self._view.showSearchResultPanel(at: self)
    }
    
    
}
