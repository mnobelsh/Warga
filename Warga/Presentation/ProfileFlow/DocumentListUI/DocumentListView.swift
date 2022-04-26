//
//  DocumentListView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//  Copyright (c) 2022 All rights reserved.

import UIKit

// MARK: DocumentListViewDelegate
public protocol DocumentListViewDelegate: AnyObject {
}

// MARK: DocumentListViewFunction
public protocol DocumentListViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
}

// MARK: DocumentListViewSubview
public protocol DocumentListViewSubview {
    var collectionView: UICollectionView { get set }
}

// MARK: DocumentListViewVariable
public protocol DocumentListViewVariable {
    var asView: UIView! { get }
    var delegate: DocumentListViewDelegate? { get set }
}

// MARK: DocumentListView
public protocol DocumentListView: DocumentListViewFunction, DocumentListViewSubview, DocumentListViewVariable { }

// MARK: DefaultDocumentListView
public final class DefaultDocumentListView: UIView, DocumentListView {
    
    // MARK: DocumentListViewSubview
    public lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 15
        flow.minimumInteritemSpacing = 15
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flow)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 24, bottom: 20, right: 24)
        collectionView.register(DocumentListCollectionCell.self, forCellWithReuseIdentifier: DocumentListCollectionCell.reuseIdentifier)
        return collectionView
    }()
    
    // MARK: DocumentListViewVariable
    public var asView: UIView!
    public weak var delegate: DocumentListViewDelegate?
    
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
public extension DefaultDocumentListView {
    
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
private extension DefaultDocumentListView {
    
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
