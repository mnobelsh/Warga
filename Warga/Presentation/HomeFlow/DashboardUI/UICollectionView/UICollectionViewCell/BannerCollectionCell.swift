//
//  BannerCollectionCell.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//

import UIKit

public final class BannerCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: BannerCollectionCell.self)
    
    public lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellDidInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(bannerImage: UIImage) {
        self.backgroundImageView.image = bannerImage
    }
    
}

private extension BannerCollectionCell {
    
    func cellDidInit() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.configureSkeletonable()
        
        self.addSubview(self.backgroundImageView)
        self.backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
