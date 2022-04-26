//
//  SignInView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import SnapKit

// MARK: SignInViewDelegate
public protocol SignInViewDelegate: AnyObject {
}

// MARK: SignInViewFunction
public protocol SignInViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
}

// MARK: SignInViewSubview
public protocol SignInViewSubview {
    var titleLabel: UILabel { get set }
    var registerButton: UIButton { get set }
    var signInButton: UIButton { get set }
    var usernameFormView: UIView { get set }
    var tableView: UITableView { get set }
}

// MARK: SignInViewVariable
public protocol SignInViewVariable {
    var asView: UIView! { get }
    var delegate: SignInViewDelegate? { get set }
}

// MARK: SignInView
public protocol SignInView: SignInViewFunction, SignInViewSubview, SignInViewVariable { }

// MARK: DefaultSignInView
public final class DefaultSignInView: UIView, SignInView {
    
    // MARK: SignInViewSubview
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Masuk",
            attributes: [.font: UIFont.heading1, .foregroundColor: UIColor.primaryPurple]
        )
        text.append(
            NSAttributedString(
                string: "\nMasuk dan nikamti kemudahan yang ditawarkan oleh Warga.",
                attributes: [.font: UIFont.body2, .foregroundColor: UIColor.darkGray]
            )
        )
        label.numberOfLines = 0
        label.attributedText = text
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    public lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Daftar", for: .normal)
        button.setTitleColor(.primaryPurple, for: .normal)
        button.titleLabel?.font = .body2
        return button
    }()
    public lazy var signInButton: UIButton = .roundedFilledButton(title: "Masuk")
    public lazy var usernameFormView: UIView = {
        let view = FormTextFieldCell(style: .default, reuseIdentifier: FormTextFieldCell.reuseIdentifier)
        
        return view
    }()
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.bounds, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = FormTextFieldCell.estimatedHeight
        tableView.register(FormTextFieldCell.self, forCellReuseIdentifier: FormTextFieldCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: .signInImage)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: SignInViewVariable
    public var asView: UIView!
    public weak var delegate: SignInViewDelegate?
    
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
public extension DefaultSignInView {
    
    func viewWillAppear(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    ) {
        
    }
    
    func viewWillDisappear() {
        
    }
    
}

// MARK: Private Function
private extension DefaultSignInView {
    
    func subviewDidLayout() {
    }
    
    func subviewWillAdd() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.imageView)
        self.addSubview(self.signInButton)
        self.addSubview(self.registerButton)
        self.addSubview(self.tableView)
    }
    
    func subviewConstraintWillMake() {
        
        self.titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(75)
        }
        
        self.imageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(35)
            $0.bottom.equalTo(self.tableView.snp.top).offset(-45)
        }
        
        self.signInButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(35)
        }
        
        self.registerButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.signInButton.snp.top).inset(-25)
            $0.width.equalTo(150)
            $0.height.equalTo(48)
        }
        
        self.tableView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(self.imageView.snp.bottom).offset(35)
            $0.height.equalTo(FormTextFieldCell.estimatedHeight*2)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.registerButton.snp.top).offset(-15)
        }

        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func viewDidInit() {
        self.asView = self
        self.backgroundColor = .background
    }

    
}
