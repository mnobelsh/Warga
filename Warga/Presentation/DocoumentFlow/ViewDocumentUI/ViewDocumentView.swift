//
//  ViewDocumentView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//  Copyright (c) 2022 All rights reserved.

import UIKit

// MARK: ViewDocumentViewDelegate
public protocol ViewDocumentViewDelegate: AnyObject {
}

// MARK: ViewDocumentViewFunction
public protocol ViewDocumentViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
}

// MARK: ViewDocumentViewSubview
public protocol ViewDocumentViewSubview {
    var collectionView: UICollectionView { get set }
}

// MARK: ViewDocumentViewVariable
public protocol ViewDocumentViewVariable {
    var asView: UIView! { get }
    var delegate: ViewDocumentViewDelegate? { get set }
}

// MARK: ViewDocumentView
public protocol ViewDocumentView: ViewDocumentViewFunction, ViewDocumentViewSubview, ViewDocumentViewVariable { }

// MARK: DefaultViewDocumentView
public final class DefaultViewDocumentView: UIView, ViewDocumentView {
    
    // MARK: ViewDocumentViewSubview
    public lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 15
        flow.minimumInteritemSpacing = 15
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flow)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 24, bottom: 20, right: 24)
        collectionView.register(ViewDocumentCollectionCell.self, forCellWithReuseIdentifier: ViewDocumentCollectionCell.reuseIdentifier)
        return collectionView
    }()
    
    // MARK: ViewDocumentViewVariable
    public var asView: UIView!
    public weak var delegate: ViewDocumentViewDelegate?
    
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
public extension DefaultViewDocumentView {
    
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
private extension DefaultViewDocumentView {
    
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
