//
//  UILabel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//

import UIKit
import SkeletonView

extension UILabel {
    
    public func setSkeletonable() {
        self.isSkeletonable = true
        self.lastLineFillPercent = 65
        self.linesCornerRadius = 4
        self.skeletonCornerRadius = 4
        self.skeletonLineSpacing = 2
    }
    
}
