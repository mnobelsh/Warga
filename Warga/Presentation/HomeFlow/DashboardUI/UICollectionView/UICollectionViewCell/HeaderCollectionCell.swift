//
//  HeaderCollectionCell.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 11/10/21.
//

import UIKit
import SkeletonView

public final class HeaderCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: HeaderCollectionCell.self)
    private var hourlyForecasts = [ForecastDomain]()
    
    // MARK: - SubViews
    lazy var weatherTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .heading2.withSize(14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 2
        label.textColor = .black
        label.setSkeletonable()
        return label
    }()
    lazy var weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .body1.withSize(12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 0
        label.textColor = .black
        label.setSkeletonable()
        return label
    }()
    lazy var weatherIconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.7)
        view.layer.cornerRadius = 20
        view.addSubview(self.weatherIconImageView)
        self.weatherIconImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(self.weatherIconImageView.snp.width)
            $0.center.equalToSuperview()
        }
        return view
    }()
    lazy var weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.configureSkeletonable()
        return imageView
    }()
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .heading1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.setSkeletonable()
        return label
    }()
    lazy var currentWeatherContainerView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0.7
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.dropShadow()
        
        let label = UILabel()
        label.font = .body2.withSize(14)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Saat ini"
        
        view.contentView.addSubview(self.temperatureLabel)
        view.contentView.addSubview(self.weatherIconContainerView)
        view.contentView.addSubview(label)
        self.temperatureLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(15)
            $0.height.equalTo(26)
        }
        self.weatherIconContainerView.snp.makeConstraints {
            $0.top.equalTo(self.temperatureLabel.snp.bottom).offset(15)
            $0.width.equalTo(self.weatherIconContainerView.snp.height)
            $0.bottom.equalTo(label.snp.top).offset(-15)
            $0.centerX.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.leading.trailing.equalTo(self.temperatureLabel)
            $0.bottom.equalToSuperview().inset(6)
        }
        return view
    }()
    lazy var weatherDescriptionContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.dropShadow(offset: CGSize(width: 1.5, height: 1.5))
        
        view.addSubview(self.weatherTitleLabel)
        view.addSubview(self.weatherDescriptionLabel)
        self.weatherTitleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(6)
            $0.height.equalTo(22)
        }
        self.weatherDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.weatherTitleLabel.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview().inset(6)
        }
        return view
    }()
    lazy var hourlyWeatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 7
        layout.minimumInteritemSpacing = 7
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.bounces = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(WeatherCollectionCell.self, forCellWithReuseIdentifier: WeatherCollectionCell.reuseIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 24)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.configureSkeletonable()
        return collectionView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellDidInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configureCurrentForecast(_ forecast: ForecastDomain) {
        let iconUrl = DefaultForecastAPINetworkService.imageBaseUrl+forecast.weather.icon+"@4x.png"
        self.weatherIconImageView.downloadImage(from: iconUrl)
        self.temperatureLabel.text = "\(forecast.temp.rounded(.towardZero)) ℃"
        self.weatherTitleLabel.text = forecast.weather.title.capitalized
        self.weatherDescriptionLabel.text = forecast.weather.description
    }
    
    public func configureHourlyForecasts(_ forecasts: [ForecastDomain]) {
        self.hourlyForecasts = forecasts
        self.hourlyWeatherCollectionView.reloadData()
    }
    
    public func configureCellByResponse(_  response: HomeDashboardViewModelResponse) {
        switch response {
        case .fetchForecastDidFail:
            self.hideLoadingAnimation()
            self.weatherIconImageView.image = .brokenImage
            self.temperatureLabel.text = "~℃"
            self.weatherTitleLabel.text = "Tidak dapat memuat informasi cuaca."
            self.weatherDescriptionLabel.text = "Pastikan anda mengizinkan aplikasi untuk mengakses informasi lokasi anda."
        case .fetchingAllData:
            self.showLoadingAnimation()
        case .fetchForecastDidSuccess:
            self.hideLoadingAnimation()
        default:
            break
        }
    }
    
}

private extension HeaderCollectionCell {
    
    func cellDidInit() {
        self.backgroundColor = .background
        self.layer.cornerRadius = 12
        self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        self.dropShadow(offset: CGSize(width: 0, height: 6))
        
        self.contentView.addSubview(self.hourlyWeatherCollectionView)
        self.contentView.addSubview(self.currentWeatherContainerView)
        self.contentView.addSubview(self.weatherDescriptionContainerView)
        
        self.currentWeatherContainerView.snp.makeConstraints {
            $0.top.bottom.leading.equalTo(self.safeAreaLayoutGuide).inset(24)
            $0.width.equalTo(self.currentWeatherContainerView.snp.height).multipliedBy(0.75)
        }
        self.weatherDescriptionContainerView.snp.makeConstraints {
            $0.top.equalTo(self.currentWeatherContainerView)
            $0.leading.equalTo(self.currentWeatherContainerView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(self.currentWeatherContainerView.snp.height).multipliedBy(0.5)
        }
        self.hourlyWeatherCollectionView.snp.makeConstraints {
            $0.top.equalTo(self.weatherDescriptionContainerView.snp.bottom).offset(15)
            $0.trailing.equalToSuperview()
            $0.leading.equalTo(self.currentWeatherContainerView.snp.trailing)
            $0.bottom.equalTo(self.currentWeatherContainerView)
        }
    }
    
    func showLoadingAnimation() {
        self.weatherTitleLabel.showAnimatedGradientSkeleton()
        self.temperatureLabel.showAnimatedGradientSkeleton()
        self.hourlyWeatherCollectionView.showAnimatedGradientSkeleton()
        self.weatherDescriptionLabel.showAnimatedGradientSkeleton()
    }
    
    func hideLoadingAnimation() {
        self.weatherTitleLabel.stopSkeleton()
        self.temperatureLabel.stopSkeleton()
        self.hourlyWeatherCollectionView.stopSkeleton()
        self.weatherDescriptionLabel.stopSkeleton()
    }
    
}

extension HeaderCollectionCell: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hourlyForecasts.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionCell.reuseIdentifier, for: indexPath) as? WeatherCollectionCell else { return UICollectionViewCell() }
        cell.configureCell(with: self.hourlyForecasts[indexPath.row])
        return cell
    }
    
    
}

extension HeaderCollectionCell: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/5, height: collectionView.frame.height)
    }
    
}

extension HeaderCollectionCell: SkeletonCollectionViewDataSource {

    public func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return 1
    }

    public func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    public func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return WeatherCollectionCell.reuseIdentifier
    }

}

