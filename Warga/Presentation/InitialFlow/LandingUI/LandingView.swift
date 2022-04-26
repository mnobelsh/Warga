//
//  LandingView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: LandingViewDelegate
public protocol LandingViewDelegate: AnyObject {
}

// MARK: LandingViewFunction
public protocol LandingViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
    func viewDidAppear()
}

// MARK: LandingViewSubview
public protocol LandingViewSubview {
    var leftBarView: UIView { get set }
    var signUpButton: UIButton { get set }
    var signInButton: UIButton { get set }
    var welcomingImageView: UIImageView { get set }
    var welcomingLabel: UILabel { get set }
    var policyLabel: UILabel { get set }
}

// MARK: LandingViewVariable
public protocol LandingViewVariable {
    var asView: UIView! { get }
    var delegate: LandingViewDelegate? { get set }
}

// MARK: LandingView
public protocol LandingView: LandingViewFunction, LandingViewSubview, LandingViewVariable { }

// MARK: DefaultLandingView
public final class DefaultLandingView: UIView, LandingView {
    
    // MARK: LandingViewSubview
    public lazy var leftBarView: UIView = .makeLeftBarView(title: "Warga")
    public lazy var signInButton: UIButton = .roundedFilledButton(title: "Masuk")
    public lazy var signUpButton: UIButton = .roundedStrokedButton(title: "Daftar")
    public lazy var welcomingImageView: UIImageView = {
        let imageView = UIImageView(image: .welcomingImage)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    public lazy var welcomingLabel: UILabel = {
        let label = UILabel()
        label.font = .heading2
        label.textColor = .darkGray
        let text = NSMutableAttributedString(
            string: "Selamat Datang!",
            attributes: [.font: UIFont.heading2, .foregroundColor: UIColor.darkGray]
        )
        text.append(
            NSAttributedString(
                string: "\nNikmati kemudahan pengajuan dokumen dan manajemen kemasyarakatan dengan aplikasi Warga.",
                attributes: [.font: UIFont.body2, .foregroundColor: UIColor.darkGray]
            )
        )
        label.attributedText = text
        label.numberOfLines = 0
        return  label
    }()
    public lazy var policyLabel: UILabel = {
        let label = UILabel()
        let muttableText = NSMutableAttributedString(
            string: "Dengan mendafatarkan diri atau masuk kedalam aplikasi ini anda menyetujui",
            attributes: [.foregroundColor: UIColor.darkGray, .font: UIFont.body3]
        )
        muttableText.append(
            NSAttributedString(
                string: " Kebijakan & Peraturan Terkait.",
                attributes: [.foregroundColor: UIColor.primaryPurple, .font: UIFont.heading3.withSize(12)]
            )
        )
        label.attributedText = muttableText
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 0
        return label
    }()
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.signInButton,
            self.signUpButton
        ])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    private lazy var imageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(self.welcomingImageView)
        view.addSubview(self.welcomingLabel)
        self.welcomingImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-30)
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(self.welcomingImageView.snp.width).multipliedBy(0.5)
        }
        self.welcomingLabel.snp.makeConstraints {
            $0.top.equalTo(self.welcomingImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.greaterThanOrEqualToSuperview().inset(15)
        }
        return view
    }()
    
    // MARK: LandingViewVariable
    public var asView: UIView!
    public weak var delegate: LandingViewDelegate?
    
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
public extension DefaultLandingView {
    
    func viewWillAppear(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    ) {
        navigationBar?.isHidden = false
        navigationBar?.setTransparentBackground()
        navigationItem.setLeftBarButton(UIBarButtonItem(customView: self.leftBarView), animated: true)
    }
    
    func viewWillDisappear() {
        
    }
    
    func viewDidAppear() {

    }
    
}

// MARK: Private Function
private extension DefaultLandingView {
    
    func subviewDidLayout() {
    }
    
    func subviewWillAdd() {
        self.addSubview(self.imageContainerView)
        self.addSubview(self.policyLabel)
        self.addSubview(self.buttonStackView)
    }
    
    func subviewConstraintWillMake() {
        self.imageContainerView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalTo(self.buttonStackView.snp.top).offset(-35)
        }
        self.policyLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(25)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        self.buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalTo(self.policyLabel.snp.top).offset(-35)
        }
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func viewDidInit() {
        self.asView = self
        self.backgroundColor = .background
    }
    
}
