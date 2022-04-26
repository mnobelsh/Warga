//
//  WeatherCollectionCell.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 18/10/21.
//

import UIKit

public final class WeatherCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: WeatherCollectionCell.self)
    
    // MARK: - SubViews
    lazy var containerView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0.7
        view.clipsToBounds = true
        view.dropShadow()
        
        view.contentView.addSubview(self.weatherIconImageView)
        view.contentView.addSubview(self.timeLabel)
        
        self.weatherIconImageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(1)
            $0.bottom.equalTo(self.timeLabel.snp.top)
        }
        self.timeLabel.snp.makeConstraints {
            $0.height.equalTo(12)
            $0.leading.trailing.bottom.equalToSuperview().inset(4)
        }
        return view
    }()
    lazy var weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .heading2.withSize(10)
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = 6
        self.configureSkeletonable()
        self.contentView.addSubview(self.containerView)
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with forecast: ForecastDomain) {
        let iconUrl = DefaultForecastAPINetworkService.imageBaseUrl+forecast.weather.icon+"@4x.png"
        self.weatherIconImageView.downloadImage(from: iconUrl)
        self.timeLabel.text = forecast.date.toString(format: [.hour,.colon,.minute])
    }
    
}
