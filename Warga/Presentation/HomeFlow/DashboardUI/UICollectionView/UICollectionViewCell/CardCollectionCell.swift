//
//  CardCollectionCell.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/10/21.
//

import UIKit

class CardCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: CardCollectionCell.self)
    
    // MARK: - SubViews
    lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .softPurple
        view.addSubview(self.iconImageView)
        view.addSubview(self.contentContainerView)
        self.iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.bottom.trailing.equalToSuperview().inset(20)
        }
        self.contentContainerView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(view.snp.height).multipliedBy(0.45)
        }
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .heading2.withSize(18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .heading2.withSize(10)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    lazy var contentContainerView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterialLight)
        let view = UIVisualEffectView(effect: blurEffect)
        view.contentView.addSubview(self.titleLabel)
        view.contentView.addSubview(self.descriptionLabel)
        
        self.titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(5)
        }
        self.descriptionLabel.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview().inset(5)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(2)
        }
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellDidInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconImageView.image = nil
    }
    
    public func configureCell(with menu: DashboardCovidMenu) {
        self.titleLabel.text = menu.title
        self.iconImageView.image = menu.icon
    }
    
}

private extension CardCollectionCell {
    
    func cellDidInit() {
        self.backgroundColor = .clear
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
}

