//
//  UIButton.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//

import UIKit
import SnapKit

extension UIButton {
    
    open class func roundedFilledButton(title: String, color: UIColor = .primaryPurple) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .heading2.withSize(18)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = color
        button.layer.cornerRadius = 10
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        button.snp.makeConstraints {
            $0.height.equalTo(45)
        }
        return button
    }
    
    open class func roundedStrokedButton(title: String, color: UIColor = .primaryPurple) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .heading2.withSize(18)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.7
        button.setTitleColor(color, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderColor = color.cgColor
        button.layer.borderWidth = 1.5
        button.snp.makeConstraints {
            $0.height.equalTo(45)
        }
        return button
    }
    
}
