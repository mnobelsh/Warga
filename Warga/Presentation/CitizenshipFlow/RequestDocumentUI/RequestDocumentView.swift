//
//  RequestDocumentView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//  Copyright (c) 2022 All rights reserved.

import UIKit

// MARK: RequestDocumentViewDelegate
public protocol RequestDocumentViewDelegate: AnyObject {
}

// MARK: RequestDocumentViewFunction
public protocol RequestDocumentViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
    func configureView(withDocument document: DocumentDomain)
    func setConfirmationButton(isEnabled: Bool)
}

// MARK: RequestDocumentViewSubview
public protocol RequestDocumentViewSubview {
    var tableView: UITableView { get set }
    var confirmationButton: UIButton { get set }
}

// MARK: RequestDocumentViewVariable
public protocol RequestDocumentViewVariable {
    var asView: UIView! { get }
    var delegate: RequestDocumentViewDelegate? { get set }
}

// MARK: RequestDocumentView
public protocol RequestDocumentView: RequestDocumentViewFunction, RequestDocumentViewSubview, RequestDocumentViewVariable { }

// MARK: DefaultRequestDocumentView
public final class DefaultRequestDocumentView: UIView, RequestDocumentView {
    
    // MARK: RequestDocumentViewSubview
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.frame, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(RequestDocumentTableCell.self, forCellReuseIdentifier: RequestDocumentTableCell.reuseIdentifier)
        return tableView
    }()
    public lazy var confirmationButton: UIButton = .roundedFilledButton(title: "Konfirmasi pengajuan dokumen", color: .systemGray3)
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .heading1.withSize(28)
        label.textColor = .primaryPurple
        return label
    }()
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .body1.withSize(14)
        label.textColor = .darkGray
        label.text = "Berikut ini merupakan dokumen penunjang yang anda butuhkan untuk melanjutkan proses pengajuan dokumen. Jika dokumen yang diperlukan telah tersimpan pada sistem maka anda tidak perlu mengupload ulang dokumen tersebut."
        return label
    }()
    
    // MARK: RequestDocumentViewVariable
    public var asView: UIView!
    public weak var delegate: RequestDocumentViewDelegate?
    
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
public extension DefaultRequestDocumentView {
    
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
    }
    
    func setConfirmationButton(isEnabled: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.confirmationButton.backgroundColor = isEnabled ? .primaryPurple : .systemGray3
            self.confirmationButton.isEnabled = isEnabled
        }
    }
    
}

// MARK: Private Function
private extension DefaultRequestDocumentView {
    
    func subviewDidLayout() {
        
    }
    
    func subviewWillAdd() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)
        self.addSubview(self.tableView)
        self.addSubview(self.confirmationButton)
    }
    
    func subviewConstraintWillMake() {
        self.titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(25)
        }
        self.subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(self.titleLabel)
        }
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.subtitleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.confirmationButton.snp.top).offset(-20)
        }
        self.confirmationButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
    }
    
    func viewDidInit() {
        self.asView = self
        self.backgroundColor = .white
        self.confirmationButton.isEnabled = false
    }
    
}
