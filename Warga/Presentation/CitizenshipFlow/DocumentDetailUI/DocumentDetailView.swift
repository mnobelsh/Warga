//
//  DocumentDetailView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 06/02/22.
//  Copyright (c) 2022 All rights reserved.

import UIKit

// MARK: DocumentDetailViewDelegate
public protocol DocumentDetailViewDelegate: AnyObject {
}

// MARK: DocumentDetailViewFunction
public protocol DocumentDetailViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
    func configureView(withDocument document: DocumentDomain)
}

// MARK: DocumentDetailViewSubview
public protocol DocumentDetailViewSubview {
    var documentImageView: UIImageView { get set }
    var titleLabel: UILabel { get set }
    var descriptionLabel: UILabel { get set }
    var stepsLabel: UILabel { get set }
    var requestButton: UIButton { get set }
    var scrollView: UIScrollView { get set }
}

// MARK: DocumentDetailViewVariable
public protocol DocumentDetailViewVariable {
    var asView: UIView! { get }
    var delegate: DocumentDetailViewDelegate? { get set }
}

// MARK: DocumentDetailView
public protocol DocumentDetailView: DocumentDetailViewFunction, DocumentDetailViewSubview, DocumentDetailViewVariable { }

// MARK: DefaultDocumentDetailView
public final class DefaultDocumentDetailView: UIView, DocumentDetailView {
    
    // MARK: DocumentDetailViewSubview
    private lazy var containerView: UIView = {
        let view = UIView()
        view.dropShadow(color: .darkGray, offset: CGSize(width: 0, height: -1), radius: 4, opacity: 0.3)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        view.addSubview(self.scrollView)
        return view
    }()
    public lazy var documentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .heading1.withSize(28)
        label.textColor = .white
        return label
    }()
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .latoBold(withSize: 18)
        label.textColor = .black
        return label
    }()
    public lazy var stepsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .body2.withSize(16)
        label.textColor = .black
        return label
    }()
    public lazy var requestButton: UIButton = UIButton.roundedFilledButton(title: "Ajukan dokumen", color: .primaryGreen)
    public lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.frame)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 115, right: 0)
        scrollView.addSubview(self.descriptionLabel)
        scrollView.addSubview(self.stepsLabel)
        return scrollView
    }()

    
    // MARK: DocumentDetailViewVariable
    public var asView: UIView!
    public weak var delegate: DocumentDetailViewDelegate?
    
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
public extension DefaultDocumentDetailView {
    
    func viewWillAppear(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    ) {
        
    }
    
    func viewWillDisappear() {
        
    }
    
    func configureView(withDocument document: DocumentDomain) {
        self.titleLabel.text = document.title
        self.descriptionLabel.text = document.description
        self.documentImageView.image = document.image
        self.stepsLabel.text = document.steps.joined(separator: "\n\n")
    }
    
}

// MARK: Private Function
private extension DefaultDocumentDetailView {
    
    func subviewDidLayout() {
    }
    
    func subviewWillAdd() {
        self.addSubview(self.documentImageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.containerView)
        self.addSubview(self.requestButton)
    }
    
    func subviewConstraintWillMake() {
        self.documentImageView.snp.makeConstraints {
            $0.top.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(self.containerView.snp.top).offset(-30)
            $0.width.equalTo(self.documentImageView.snp.height).multipliedBy(1.25)
        }
        self.titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(self.containerView.snp.top).offset(-5)
        }
        self.containerView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(UIScreen.main.bounds.width*0.55)
            $0.leading.bottom.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        self.requestButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(48).priority(999)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
        
        self.scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(25)
        }
        self.stepsLabel.snp.makeConstraints {
            $0.top.equalTo(self.descriptionLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(25)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    func viewDidInit() {
        self.asView = self
        self.backgroundColor = .primaryPurple
    }
    
}
