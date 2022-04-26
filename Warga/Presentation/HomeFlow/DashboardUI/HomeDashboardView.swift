//
//  HomeDashboardView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: HomeDashboardViewDelegate
public protocol HomeDashboardViewDelegate: AnyObject {
}

// MARK: HomeDashboardViewFunction
public protocol HomeDashboardViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
    func reloadSection(at section: HomeDashboardCollectionView.Section)
}

// MARK: HomeDashboardViewSubview
public protocol HomeDashboardViewSubview {
    var collectionView: HomeDashboardCollectionView { get }
}

// MARK: HomeDashboardViewVariable
public protocol HomeDashboardViewVariable {
    var asView: UIView! { get }
    var delegate: HomeDashboardViewDelegate? { get set }
}

// MARK: HomeDashboardView
public protocol HomeDashboardView: HomeDashboardViewFunction, HomeDashboardViewSubview, HomeDashboardViewVariable { }

// MARK: DefaultHomeDashboardView
public final class DefaultHomeDashboardView: UIView, HomeDashboardView {
    
    // MARK: HomeDashboardViewSubview
    public lazy var leftBarView: UIView = .makeLeftBarView(title: "Warga")
    public lazy var collectionView: HomeDashboardCollectionView = HomeDashboardCollectionView(frame: self.frame)
    
    // MARK: HomeDashboardViewVariable
    public var asView: UIView!
    public weak var delegate: HomeDashboardViewDelegate?
    
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
public extension DefaultHomeDashboardView {
    
    func viewWillAppear(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    ) {
        navigationBar?.setTransparentBackground()
        navigationItem.setLeftBarButton(UIBarButtonItem(customView: self.leftBarView), animated: true)
    }
    
    func viewWillDisappear() {
        
    }
    
    func reloadSection(at section: HomeDashboardCollectionView.Section) {
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates {
                guard let index = self.collectionView.sections.firstIndex(of: section) else { return }
                self.collectionView.reloadSections(IndexSet(integer: index))
            }
        }
    }
    
}

// MARK: Private Function
private extension DefaultHomeDashboardView {
    
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
        self.backgroundColor = .background
    }
    
}
