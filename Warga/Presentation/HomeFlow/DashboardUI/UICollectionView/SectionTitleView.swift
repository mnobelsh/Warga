//
//  SectionTitleView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//

import UIKit

public final class SectionTitleView: UICollectionReusableView {

    static let elementKind = UICollectionView.elementKindSectionHeader
    static let reuseIdentifier = String(describing: SectionTitleView.self)
    
    // MARK: - SubViews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .heading2
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    lazy var supplementaryTitleIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(self.titleLabel)
        self.addSubview(self.supplementaryTitleIconView)
        self.titleLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        self.supplementaryTitleIconView.snp.makeConstraints {
            $0.leading.equalTo(self.titleLabel.snp.trailing).offset(10)
            $0.bottom.top.equalToSuperview()
            $0.width.equalTo(self.supplementaryTitleIconView.snp.height)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
        self.configureSkeletonable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureView(title: String, titleIcon: UIImage? = nil) {
        self.titleLabel.text = title
        self.supplementaryTitleIconView.image = titleIcon
    }
    
}
