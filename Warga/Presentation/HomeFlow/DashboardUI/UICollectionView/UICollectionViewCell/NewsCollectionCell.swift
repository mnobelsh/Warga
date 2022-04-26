//
//  NewsCollectionCell.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/10/21.
//

import UIKit

public final class NewsCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: NewsCollectionCell.self)
    
    // MARK: - SubViews
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: .brokenImage)
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.configureSkeletonable()
        return imageView
    }()
    lazy var textContainerView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.layer.cornerRadius = 12
        view.alpha = 0.85
        view.contentView.addSubview(self.titleLabel)
        view.contentView.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.leading.bottom.trailing.equalToSuperview().inset(8)
        }
        self.titleLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(8)
            $0.bottom.equalTo(self.descriptionLabel.snp.top)
        }
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.heading1.withSize(16)
        label.numberOfLines = 0
        label.setSkeletonable()
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.body1.withSize(14)
        label.numberOfLines = 0
        label.setSkeletonable()
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellDidInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundImageView.kf.cancelDownloadTask()
    }
    
    public func configureCell(with news: NewsDomain) {
        self.titleLabel.text = news.title
        self.descriptionLabel.text = news.description
        self.backgroundImageView.downloadImage(from: news.imageUrl) { [weak self] _,_ in
            self?.backgroundImageView.showAnimatedGradientSkeleton()
        } completion: { [weak self] result in
            self?.backgroundImageView.stopSkeleton()
        }
    }
    
    public func configureCellByResponse(_ response: HomeDashboardViewModelResponse) {
        switch response {
        case .fetchingAllData:
            self.showAnimatedGradientSkeleton()
        case .fetchNewsDidSuccess,.fetchNewsDidFail:
            self.stopSkeleton()
        default:
            break
        }
    }
}

private extension NewsCollectionCell {
    
    func cellDidInit() {
        self.configureSkeletonable()
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.contentView.isSkeletonable = true
        self.layer.cornerRadius = 12
        
        self.contentView.addSubview(self.backgroundImageView)
        self.contentView.addSubview(self.textContainerView)

        self.backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.textContainerView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(self.backgroundImageView.snp.height).multipliedBy(0.5)
        }

    }
    
}
