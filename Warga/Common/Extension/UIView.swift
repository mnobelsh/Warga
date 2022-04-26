//
//  UIView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//

import UIKit
import SnapKit
import SkeletonView

extension UIView {
    
    open class func makeLeftBarView(icon: UIImage = .appIcon, title: String, action: (target: Any, selector: Selector)? = nil) -> UIView {
        let view = UIView()
        view.isUserInteractionEnabled = true
        
        let iconImageView = UIImageView(image: icon)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 4
        if let action = action {
            iconImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: action.target, action: action.selector)
            iconImageView.addGestureRecognizer(tapGesture)
        }

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .heading3.withSize(17)
        titleLabel.textColor = .primaryPurple
        titleLabel.numberOfLines = 1
        
        view.addSubview(iconImageView)
        view.addSubview(titleLabel)
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(iconImageView.snp.height)
        }
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(8)
        }
        view.snp.makeConstraints {
            $0.trailing.equalTo(titleLabel)
        }
        
        return view
    }
    
    public func dropShadow(color: UIColor = UIColor.lightGray, offset: CGSize = CGSize(width: 2, height: 2), radius: CGFloat = 4, opacity: Float = 0.5) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
 
    func configureSkeletonable() {
        self.isSkeletonable = true
        self.skeletonCornerRadius = 6
    }
    
    func stopSkeleton() {
        self.stopSkeletonAnimation()
        self.hideSkeleton(transition: .crossDissolve(0.5))
    }
    
}
