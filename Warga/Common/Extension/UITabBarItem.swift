//
//  UITabBarItem.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//

import UIKit

extension UITabBarItem {
    
    func configureItem(withTitle title: String, andImage image: UIImage) {
        self.title = title
        self.selectedImage = image.withTintColor(.primaryPurple)
        self.image = image.withTintColor(.gray)
        self.setTitleTextAttributes([
            .foregroundColor: UIColor.gray,
            .font: UIFont.latoBold(withSize: 12)
        ], for: .normal)
        self.setTitleTextAttributes([
            .foregroundColor: UIColor.primaryPurple,
            .font: UIFont.latoBold(withSize: 12)
        ], for: .selected)
    }
    
}
