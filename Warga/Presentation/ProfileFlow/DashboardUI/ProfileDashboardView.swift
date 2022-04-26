//
//  ProfileDashboardView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import SnapKit
import LetterAvatarKit
import SkeletonView

// MARK: ProfileDashboardViewDelegate
public protocol ProfileDashboardViewDelegate: AnyObject {
}

// MARK: ProfileDashboardViewFunction
public protocol ProfileDashboardViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
    func configureProfileData(with profile: ProfileDTO)
    func showLoadingContent()
    func hideLoadingContent()
}

// MARK: ProfileDashboardViewSubview
public protocol ProfileDashboardViewSubview {
    var tableView: UITableView { get }
    var cityImageView: UIImageView { get }
    var nameLabel: UILabel { get }
    var nikLabel: UILabel { get }
    var addressLabel: UILabel { get }
    var profileImageView: UIImageView { get }
    var dateOfBirthLabel: UILabel { get }
}

// MARK: ProfileDashboardViewVariable
public protocol ProfileDashboardViewVariable {
    var asView: UIView! { get }
    var delegate: ProfileDashboardViewDelegate? { get set }
}

// MARK: ProfileDashboardView
public protocol ProfileDashboardView: ProfileDashboardViewFunction, ProfileDashboardViewSubview, ProfileDashboardViewVariable { }

// MARK: DefaultProfileDashboardView
public final class DefaultProfileDashboardView: UIView, ProfileDashboardView {

    // MARK: ProfileDashboardViewSubview
    lazy var leftBarView: UIView = .makeLeftBarView(title: "Profil")
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.frame, style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = true
        tableView.alwaysBounceVertical = true
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        tableView.register(ProfileDashboardMenuTableCell.self, forCellReuseIdentifier: ProfileDashboardMenuTableCell.reuseIdentifier)
        tableView.tableHeaderView = self.tableHeaderView
        tableView.tableHeaderView?.frame.size = CGSize(width: tableView.frame.width, height: 250)
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 16, right: 0)
        let refreshControl =  UIRefreshControl()
        refreshControl.tintColor = .primaryPurple
        tableView.refreshControl = refreshControl
        tableView.isSkeletonable = true
        return tableView
    }()
    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.heading3
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "-"
        label.setSkeletonable()
        return label
    }()
    public lazy var nikLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.heading3
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 1
        label.textColor = .black
        label.text = "-"
        label.setSkeletonable()
        return label
    }()
    public lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.heading3.withSize(12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.text = "-"
        label.setSkeletonable()
        return label
    }()
    public var dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.heading3.withSize(12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.text = "-"
        label.setSkeletonable()
        return label
    }()
    public lazy var cityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    public lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.dropShadow(opacity: 0.8)
        imageView.layer.cornerRadius = 10
        imageView.isSkeletonable = true
        imageView.skeletonCornerRadius = 10
        return imageView
    }()
    lazy var tableHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        let containerView = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        containerView.alpha = 0.9
        containerView.effect = blurEffect
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 0.75
        containerView.layer.borderColor = UIColor.white.cgColor
        
        let countryImageView = UIImageView(image: .indonesiaMap)
        countryImageView.contentMode = .scaleAspectFit
        countryImageView.clipsToBounds = true
        
        view.addSubview(self.cityImageView)
        view.addSubview(countryImageView)
        view.addSubview(containerView)
        self.cityImageView.snp.makeConstraints {
            $0.height.equalTo(view.snp.height).multipliedBy(0.35)
            $0.width.equalTo(self.cityImageView.snp.height)
            $0.top.leading.equalToSuperview().inset(10)
        }
        countryImageView.snp.makeConstraints {
            $0.width.height.equalToSuperview().multipliedBy(0.7)
            $0.bottom.trailing.equalToSuperview()
        }
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(45)
        }
        
        containerView.contentView.addSubview(self.nameLabel)
        containerView.contentView.addSubview(self.nikLabel)
        containerView.contentView.addSubview(self.addressLabel)
        containerView.contentView.addSubview(self.profileImageView)
        containerView.contentView.addSubview(self.dateOfBirthLabel)
        
        self.nameLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(35)
        }
        self.nikLabel.snp.makeConstraints {
            $0.top.equalTo(self.nameLabel.snp.bottom)
            $0.leading.trailing.equalTo(self.nameLabel)
            $0.height.equalTo(15)
        }
        self.addressLabel.snp.makeConstraints {
            $0.top.equalTo(self.profileImageView).offset(5)
            $0.leading.equalTo(self.nameLabel)
            $0.trailing.equalTo(self.profileImageView.snp.leading).offset(-20)
        }
        self.dateOfBirthLabel.snp.makeConstraints {
            $0.leading.equalTo(self.profileImageView)
            $0.height.equalTo(15)
            $0.bottom.trailing.equalToSuperview().inset(15)
        }
        self.profileImageView.snp.makeConstraints {
            $0.trailing.equalTo(self.dateOfBirthLabel)
            $0.bottom.equalTo(self.dateOfBirthLabel.snp.top).offset(-10)
            $0.top.equalTo(self.nikLabel.snp.bottom).offset(10)
            $0.width.equalTo(self.profileImageView.snp.height)
        }
        
        return view
    }()

    
    // MARK: ProfileDashboardViewVariable
    public var asView: UIView!
    public weak var delegate: ProfileDashboardViewDelegate?
    
    // MARK: Init Function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: UIScreen.main.fixedCoordinateSpace.bounds)
        self.subviewWillAdd()
        self.subviewConstraintWillMake()
        self.viewDidInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.subviewDidLayout()
    }
    
}

// MARK: Input Function
public extension DefaultProfileDashboardView {
    
    func viewWillAppear(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    ) {
        navigationBar?.setBackgroundColor(.white)
        navigationItem.setLeftBarButton(UIBarButtonItem(customView: self.leftBarView), animated: true)
    }
    
    func viewWillDisappear() {
        
    }
    
    func configureProfileData(with profile: ProfileDTO) {
        self.cityImageView.downloadImage(from: "https://feriirawan-api.herokuapp.com/list/symbols/province/11/1080")
        self.nameLabel.text = profile.nama_lengkap
        self.nikLabel.text = profile.nik
        self.addressLabel.text = "\(profile.alamat.alamat)\nRT\(profile.alamat.rt ?? "")/RW\(profile.alamat.rw ?? "")\n\(profile.alamat.kecamatan ?? "")\n\n\(profile.alamat.provinsi ?? "")"

        if let encodedImage = profile.foto_profil, let imageData = Data(base64Encoded: encodedImage) {
            self.profileImageView.image = UIImage(data: imageData)
        } else {
            let placeHolderImage = LetterAvatarMaker()
                .setUsername(profile.nama_lengkap)
                .setLettersColor(.white)
                .setBackgroundColors([.primaryPurple.withAlphaComponent(0.75)])
                .setLettersFont(.heading3.withSize(16))
                .build()
            self.profileImageView.image = placeHolderImage
        }
    }
    
    func showLoadingContent() {
        self.nameLabel.showAnimatedGradientSkeleton()
        self.nikLabel.showAnimatedGradientSkeleton()
        self.addressLabel.showAnimatedGradientSkeleton()
        self.dateOfBirthLabel.showAnimatedGradientSkeleton()
        self.profileImageView.showAnimatedGradientSkeleton()
    }
    
    func hideLoadingContent() {
        self.nameLabel.stopSkeleton()
        self.nikLabel.stopSkeleton()
        self.addressLabel.stopSkeleton()
        self.dateOfBirthLabel.stopSkeleton()
        self.profileImageView.stopSkeleton()
    }
    
}

// MARK: Private Function
private extension DefaultProfileDashboardView {
    
    func subviewDidLayout() {
    }
    
    func subviewWillAdd() {
        self.addSubview(self.tableView)
    }
    
    func subviewConstraintWillMake() {
        self.tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func viewDidInit() {
        self.asView = self
        self.backgroundColor = .background
    }
    
}

public struct ProfileDashboardMenu {
    
    public enum `Type` {
        case myData
        case familyMembers
        case activites
        case documents
        case showInMap
        case termsAndConditions
        case signOut
    }
    
    public enum Section: CaseIterable {
        case profileInfo
        case appConfiguration
        case authConfiguration
    }
    
    public enum MenuAccessoryType {
        case switchButton(isOn: Bool)
        case disclosureIndicator
        case none
    }
    
    var type: `Type`
    var title: String
    var iconImage: UIImage? = nil
    var backgroundImage: UIImage? = nil
    var backgroundColor: UIColor = .white
    var accessoryType: MenuAccessoryType = .disclosureIndicator
    
}
