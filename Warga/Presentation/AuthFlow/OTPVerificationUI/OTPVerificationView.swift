//
//  OTPVerificationView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 20/09/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: OTPVerificationViewDelegate
public protocol OTPVerificationViewDelegate: AnyObject {
}

// MARK: otpVerificationViewFunction
public protocol otpVerificationViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
    func showContainerFieldBorder(for textField: UITextField)
    func hideContainerFieldBorder(for textField: UITextField)
}

// MARK: otpVerificationViewSubview
public protocol otpVerificationViewSubview {
    var titleLabel: UILabel { get set }
    var firstOTPTextField: UITextField { get set }
    var secondOTPTextField: UITextField { get set }
    var thirdOTPTextField: UITextField { get set }
    var forthOTPTextField: UITextField { get set }
    var fifthOTPTextField: UITextField { get set }
    var sixthOTPTextField: UITextField { get set }
    var resendButton: UIButton { get set }
    var otpImageView: UIImageView { get set }
}

// MARK: otpVerificationViewVariable
public protocol otpVerificationViewVariable {
    var asView: UIView! { get }
    var delegate: OTPVerificationViewDelegate? { get set }
}

// MARK: otpVerificationView
public protocol OTPVerificationView: otpVerificationViewFunction, otpVerificationViewSubview, otpVerificationViewVariable { }

// MARK: DefaultOTPVerificationView
public final class DefaultOTPVerificationView: UIView, OTPVerificationView {
    
    // MARK: otpVerificationViewSubview
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Verifikasi OTP",
            attributes: [.font: UIFont.heading1, .foregroundColor: UIColor.primaryPurple]
        )
        text.append(
            NSAttributedString(
                string: "\n\nMasukan kode OTP (One Time Password) yang telah kami kirimkan melalui SMS. Pastikan nomor telepon anda sudah benar.",
                attributes: [.font: UIFont.body2, .foregroundColor: UIColor.darkGray]
            )
        )
        label.numberOfLines = 0
        label.attributedText = text
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    public lazy var firstOTPTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.tag = .firstTextFieldTag
        textField.font = .heading1
        textField.textColor = .darkGray
        textField.textAlignment = .center
        textField.clearsOnBeginEditing = false
        return textField
    }()
    private lazy var firstOTPContainerView: UIView = .makeOTPContainerView(for: self.firstOTPTextField)
    public lazy var secondOTPTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.tag = .firstTextFieldTag+1
        textField.font = .heading1
        textField.textColor = .darkGray
        textField.textAlignment = .center
        textField.clearsOnBeginEditing = false
        return textField
    }()
    private lazy var secondOTPContainerView: UIView = .makeOTPContainerView(for: self.secondOTPTextField)
    public lazy var thirdOTPTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.tag = .firstTextFieldTag+2
        textField.font = .heading1
        textField.textColor = .darkGray
        textField.textAlignment = .center
        textField.clearsOnBeginEditing = false
        return textField
    }()
    private lazy var thirdOTPContainerView: UIView = .makeOTPContainerView(for: self.thirdOTPTextField)
    public lazy var forthOTPTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.tag = .firstTextFieldTag+3
        textField.font = .heading1
        textField.textColor = .darkGray
        textField.textAlignment = .center
        textField.clearsOnBeginEditing = false
        return textField
    }()
    private lazy var forthOTPContainerView: UIView = .makeOTPContainerView(for: self.forthOTPTextField)
    public lazy var fifthOTPTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.tag = .firstTextFieldTag+4
        textField.font = .heading1
        textField.textColor = .darkGray
        textField.textAlignment = .center
        textField.clearsOnBeginEditing = false
        return textField
    }()
    private lazy var fifthOTPContainerView: UIView = .makeOTPContainerView(for: self.fifthOTPTextField)
    public lazy var sixthOTPTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.tag = .firstTextFieldTag+5
        textField.font = .heading1
        textField.textColor = .darkGray
        textField.textAlignment = .center
        textField.clearsOnBeginEditing = false
        return textField
    }()
    private lazy var sixthOTPContainerView: UIView = .makeOTPContainerView(for: self.sixthOTPTextField)
    private lazy var otpStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.firstOTPContainerView, self.secondOTPContainerView, self.thirdOTPContainerView, self.forthOTPContainerView, self.fifthOTPContainerView, self.sixthOTPContainerView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    public lazy var resendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Kirim ulang", for: .normal)
        button.setTitleColor(.primaryPurple, for: .normal)
        button.titleLabel?.font = .body2
        return button
    }()
    public lazy var otpImageView: UIImageView = {
        let imageView = UIImageView(image: .otpImage.withTintColor(.lightGray, renderingMode: .alwaysOriginal))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: otpVerificationViewVariable
    public var asView: UIView!
    public weak var delegate: OTPVerificationViewDelegate?
    
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
public extension DefaultOTPVerificationView {
    
    func viewWillAppear(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    ) {
        navigationBar?.isHidden = false
        navigationItem.title = "Verifikasi OTP"
        self.firstOTPTextField.becomeFirstResponder()
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            UIView.animate(withDuration: 0.5) {
                self.otpImageView.image = .otpImage
                self.otpImageView.layoutIfNeeded()
            }
        }
    }
    
    func viewWillDisappear() {
        
    }
    
    func showContainerFieldBorder(for textField: UITextField) {
        guard let containerView = textField.superview, let separatorView = containerView.subviews.first(where: { $0.tag == .topSeparatorTag }) else { return }
        UIView.animate(withDuration: 0.25) {
            separatorView.snp.remakeConstraints {
                $0.height.equalTo(3)
                $0.leading.bottom.trailing.equalToSuperview()
            }
            containerView.layoutIfNeeded()
        }
    }
    
    func hideContainerFieldBorder(for textField: UITextField) {
        guard let containerView = textField.superview, let separatorView = containerView.subviews.first(where: { $0.tag == .topSeparatorTag }) else { return }
        UIView.animate(withDuration: 0.25) {
            separatorView.snp.remakeConstraints {
                $0.height.equalTo(3)
                $0.leading.bottom.equalToSuperview()
                $0.trailing.equalTo(containerView.snp.leading)
            }
            containerView.layoutIfNeeded()
        }
    }
}

// MARK: Private Function
private extension DefaultOTPVerificationView {
    
    func subviewDidLayout() {
    }
    
    func subviewWillAdd() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.otpStackView)
        self.addSubview(self.resendButton)
        self.addSubview(self.otpImageView)
    }
    
    func subviewConstraintWillMake() {
        self.titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(120)
        }
        self.otpImageView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(30)
            $0.bottom.equalTo(self.otpStackView.snp.top).offset(-50)
            $0.leading.trailing.equalToSuperview().inset(120)
        }
        self.otpStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(self.frame.width/4)
            $0.bottom.equalTo(self.resendButton.snp.top).offset(-25)
        }
        self.resendButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(25)
            $0.bottom.equalToSuperview().inset(60)
        }
    }
    
    func viewDidInit() {
        self.asView = self
        self.backgroundColor = .background
    }
    
}

fileprivate extension UIView {
    
    static func makeOTPContainerView(for textField: UITextField) -> UIView {
        let containerView = UIView()
        containerView.clipsToBounds = true
        containerView.backgroundColor = .clear
        let baseSeparatorView = UIView()
        baseSeparatorView.tag = 100
        baseSeparatorView.backgroundColor = .lightGray
        baseSeparatorView.layer.cornerRadius = 1.25
        
        let topSeparatorView = UIView()
        topSeparatorView.tag = .topSeparatorTag
        topSeparatorView.backgroundColor = .primaryPurple
        topSeparatorView.layer.cornerRadius = 1.25

        containerView.addSubview(baseSeparatorView)
        containerView.addSubview(topSeparatorView)
        containerView.addSubview(textField)
        textField.snp.makeConstraints {
            $0.height.equalToSuperview().dividedBy(2)
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.bottom.equalTo(baseSeparatorView.snp.top).offset(-4)
        }
        baseSeparatorView.snp.makeConstraints {
            $0.height.equalTo(3)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        topSeparatorView.snp.makeConstraints {
            $0.height.equalTo(3)
            $0.leading.bottom.equalToSuperview()
            $0.trailing.equalTo(containerView.snp.leading)
        }
        return containerView
    }
    
}

fileprivate extension Int {
    
    static let firstTextFieldTag = 101
    static let topSeparatorTag = 200
    
}
