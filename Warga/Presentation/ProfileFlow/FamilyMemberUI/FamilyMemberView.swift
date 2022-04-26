//
//  FamilyMemberView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: FamilyMemberViewDelegate
public protocol FamilyMemberViewDelegate: AnyObject {
    func onBackButtonDidTap(_ sender: UITapGestureRecognizer)
}

// MARK: FamilyMemberViewFunction
public protocol FamilyMemberViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
}

// MARK: FamilyMemberViewSubview
public protocol FamilyMemberViewSubview {
    var tableView: UITableView { get set }
    var addFamilyMemberButton: UIButton { get set }
}

// MARK: FamilyMemberViewVariable
public protocol FamilyMemberViewVariable {
    var asView: UIView! { get }
    var delegate: FamilyMemberViewDelegate? { get set }
}

// MARK: FamilyMemberView
public protocol FamilyMemberView: FamilyMemberViewFunction, FamilyMemberViewSubview, FamilyMemberViewVariable { }

// MARK: DefaultFamilyMemberView
public final class DefaultFamilyMemberView: UIView, FamilyMemberView {
    
    // MARK: FamilyMemberViewSubview
    private lazy var leftBarView: UIView = .makeLeftBarView(icon: .chevronLeft, title: "Anggota Keluarga", action: (target: self, selector: #selector(self.onBackButtonDidTap(_:))))
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.frame, style: .plain)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.bounces = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CustomDefaultTableCell.self, forCellReuseIdentifier: CustomDefaultTableCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 60, right: 0)
        return tableView
    }()
    public lazy var addFamilyMemberButton: UIButton = .roundedFilledButton(title: "Tambah anggota keluarga")
    
    // MARK: FamilyMemberViewVariable
    public var asView: UIView!
    public weak var delegate: FamilyMemberViewDelegate?
    
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
public extension DefaultFamilyMemberView {
    
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
    
}

// MARK: Private Function
private extension DefaultFamilyMemberView {
    
    func subviewDidLayout() {
    }
    
    func subviewWillAdd() {
        self.addSubview(self.tableView)
        self.addSubview(self.addFamilyMemberButton)
    }
    
    func subviewConstraintWillMake() {
        self.tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        self.addFamilyMemberButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(self.frame.width/4)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(15)
            $0.height.equalTo(45)
        }
    }
    
    func viewDidInit() {
        self.asView = self
        self.backgroundColor = .background
    }
    
    @objc
    func onBackButtonDidTap(_ sender: UITapGestureRecognizer) {
        self.delegate?.onBackButtonDidTap(sender)
    }
    
}
