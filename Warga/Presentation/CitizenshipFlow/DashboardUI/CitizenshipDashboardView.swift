//
//  CitizenshipDashboardView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: CitizenshipDashboardViewDelegate
public protocol CitizenshipDashboardViewDelegate: AnyObject {
}

// MARK: CitizenshipDashboardViewFunction
public protocol CitizenshipDashboardViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
}

// MARK: CitizenshipDashboardViewSubview
public protocol CitizenshipDashboardViewSubview {
    var collectionView: CitizenshipDashboardCollectionView { get set }
}

// MARK: CitizenshipDashboardViewVariable
public protocol CitizenshipDashboardViewVariable {
    var asView: UIView! { get }
    var delegate: CitizenshipDashboardViewDelegate? { get set }
}

// MARK: CitizenshipDashboardView
public protocol CitizenshipDashboardView: CitizenshipDashboardViewFunction, CitizenshipDashboardViewSubview, CitizenshipDashboardViewVariable { }

// MARK: DefaultCitizenshipDashboardView
public final class DefaultCitizenshipDashboardView: UIView, CitizenshipDashboardView {
    
    // MARK: CitizenshipDashboardViewSubview
    lazy var leftBarView: UIView = .makeLeftBarView(title: "Kependudukan")
    public lazy var collectionView: CitizenshipDashboardCollectionView = CitizenshipDashboardCollectionView(frame: self.frame)

    // MARK: CitizenshipDashboardViewVariable
    public var asView: UIView!
    public weak var delegate: CitizenshipDashboardViewDelegate?
    
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
public extension DefaultCitizenshipDashboardView {
    
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
private extension DefaultCitizenshipDashboardView {
    
    func subviewDidLayout() {
    }
    
    func subviewWillAdd() {
        self.addSubview(self.collectionView)
    }
    
    func subviewConstraintWillMake() {
        self.collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func viewDidInit() {
        self.asView = self
    }
    
}
