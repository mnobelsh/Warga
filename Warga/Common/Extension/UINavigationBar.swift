//
//  UINavigationBar.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//

import UIKit

public extension UINavigationBar {
    
    func setTransparentBackground() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.backgroundColor = .clear
        self.barTintColor = .clear
        self.isTranslucent = true
        self.layer.shadowOpacity = 0
    }
    
    func setBackgroundColor(_ color: UIColor) {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.backgroundColor = color
        self.barTintColor = color
        self.isTranslucent = false
        self.dropShadow(opacity: 0.35)
    }
    
}
