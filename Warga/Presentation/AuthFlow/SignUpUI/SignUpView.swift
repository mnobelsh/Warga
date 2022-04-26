//
//  SignUpView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import WeScan

// MARK: SignUpViewDelegate
public protocol SignUpViewDelegate: AnyObject {
}

// MARK: SignUpViewFunction
public protocol SignUpViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
    func configureSignUpButtonEnabled(_ isEnable: Bool)
}

// MARK: SignUpViewSubview
public protocol SignUpViewSubview {
    var titleLabel: UILabel { get set }
    var tableView: UITableView { get set }
    var scanButton: UIButton { get set }
    var signUpButton: UIButton { get set }
}

// MARK: SignUpViewVariable
public protocol SignUpViewVariable {
    var asView: UIView! { get }
    var delegate: SignUpViewDelegate? { get set }
}

// MARK: SignUpView
public protocol SignUpView: SignUpViewFunction, SignUpViewSubview, SignUpViewVariable { }

// MARK: DefaultSignUpView
public final class DefaultSignUpView: UIView, SignUpView {
    
    // MARK: SignUpViewSubview
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Daftar",
            attributes: [.font: UIFont.heading1, .foregroundColor: UIColor.primaryPurple]
        )
        text.append(
            NSAttributedString(
                string: "\nLengkapi form dibawah ini dengan memindai KTP (Kartu Tanda Penduduk) anda",
                attributes: [.font: UIFont.body2, .foregroundColor: UIColor.darkGray]
            )
        )
        label.numberOfLines = 0
        label.attributedText = text
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.bounds, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = FormTextFieldCell.estimatedHeight
        tableView.register(FormTextFieldCell.self, forCellReuseIdentifier: FormTextFieldCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
        return tableView
    }()
    public lazy var scanButton: UIButton = .roundedStrokedButton(title: "Pindai KTP")
    public lazy var signUpButton: UIButton = .roundedFilledButton(title: "Daftar", color: .lightGray)
    private lazy var headerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        let separatorView = UIView()
        separatorView.backgroundColor = .softPurple
        separatorView.layer.cornerRadius = 0.7
        
        let footerLabel = UILabel()
        footerLabel.font = .body2
        footerLabel.textColor = .darkGray
        footerLabel.text = "Pastikan data anda sesuai"
        footerLabel.textAlignment = .center
        footerLabel.backgroundColor = .background
            
        view.addSubview(self.titleLabel)
        view.addSubview(self.scanButton)
        view.addSubview(separatorView)
        view.addSubview(footerLabel)
        self.titleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(25)
        }
        self.scanButton.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        separatorView.snp.makeConstraints {
            $0.leading.trailing.equalTo(self.titleLabel)
            $0.height.equalTo(1.5)
            $0.centerY.equalTo(footerLabel)
        }
        footerLabel.snp.makeConstraints {
            $0.top.equalTo(self.scanButton.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(200)
        }
        
        view.snp.makeConstraints {
            $0.bottom.equalTo(footerLabel)
        }
        return view
    }()
    private lazy var buttonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.dropShadow()
        view.addSubview(self.signUpButton)
        self.signUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(35)
        }
        view.snp.makeConstraints {
            $0.top.equalTo(self.signUpButton).offset(-25)
        }
        return view
    }()
    

    // MARK: SignUpViewVariable
    public var asView: UIView!
    public weak var delegate: SignUpViewDelegate?
    
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
public extension DefaultSignUpView {
    
    func viewWillAppear(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    ) {

    }
    
    func viewWillDisappear() {
        
    }
    
    func configureSignUpButtonEnabled(_ isEnable: Bool) {
        self.signUpButton.isEnabled = isEnable
        self.signUpButton.backgroundColor = isEnable ? .primaryPurple : .lightGray
    }
    
}

// MARK: Private Function
private extension DefaultSignUpView {
    
    func subviewDidLayout() {
    }
    
    func subviewWillAdd() {
        self.addSubview(self.headerContainerView)
        self.addSubview(self.tableView)
        self.addSubview(self.buttonContainerView)
    }
    
    func subviewConstraintWillMake() {
        self.headerContainerView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.headerContainerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.buttonContainerView.snp.top)
        }
        self.buttonContainerView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func viewDidInit() {
        self.asView = self
        self.backgroundColor = .background
    }
    
}
