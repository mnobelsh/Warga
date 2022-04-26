//
//  CitizenshipServiceCollectionCell.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 02/11/21.
//

import UIKit
import ChameleonFramework

public final class CitizenshipServiceCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: CitizenshipServiceCollectionCell.self)
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .heading2
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .body2
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView(image: .chevronRight.withTintColor(.white, renderingMode: .alwaysOriginal))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.dropShadow()
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.chevronImageView)
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalTo(self.chevronImageView.snp.leading).offset(-6)
        }
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(self.titleLabel)
            $0.bottom.equalToSuperview().inset(16)
        }
        self.chevronImageView.snp.makeConstraints {
            $0.height.width.equalTo(28)
            $0.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
        }
        self.backgroundColor = .primaryPurple
        self.titleLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: self.backgroundColor ?? .white, isFlat: true)
        self.descriptionLabel.textColor = UIColor(contrastingBlackOrWhiteColorOn: self.backgroundColor ?? .white, isFlat: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
    }
    
}
