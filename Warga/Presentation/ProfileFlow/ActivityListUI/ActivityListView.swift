//
//  ActivityListView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//  Copyright (c) 2022 All rights reserved.

import UIKit

// MARK: ActivityListViewDelegate
public protocol ActivityListViewDelegate: AnyObject {
}

// MARK: ActivityListViewFunction
public protocol ActivityListViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
}

// MARK: ActivityListViewSubview
public protocol ActivityListViewSubview {
    var collectionView: UICollectionView { get set }
}

// MARK: ActivityListViewVariable
public protocol ActivityListViewVariable {
    var asView: UIView! { get }
    var delegate: ActivityListViewDelegate? { get set }
}

// MARK: ActivityListView
public protocol ActivityListView: ActivityListViewFunction, ActivityListViewSubview, ActivityListViewVariable { }

// MARK: DefaultActivityListView
public final class DefaultActivityListView: UIView, ActivityListView {
    
    // MARK: ActivityListViewSubview
    public lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 15
        flow.minimumInteritemSpacing = 15
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flow)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 24, bottom: 20, right: 24)
        collectionView.register(DocumentListCollectionCell.self, forCellWithReuseIdentifier: DocumentListCollectionCell.reuseIdentifier)
        return collectionView
    }()
    
    // MARK: ActivityListViewVariable
    public var asView: UIView!
    public weak var delegate: ActivityListViewDelegate?
    
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
public extension DefaultActivityListView {
    
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
private extension DefaultActivityListView {
    
    func subviewDidLayout() {
    }
    
    func subviewWillAdd() {
        self.addSubview(self.collectionView)
    }
    
    func subviewConstraintWillMake() {
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func viewDidInit() {
        self.asView = self
        self.backgroundColor = .white
    }
    
}
