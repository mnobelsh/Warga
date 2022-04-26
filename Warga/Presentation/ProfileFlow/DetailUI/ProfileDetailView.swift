//
//  ProfileDetailView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: ProfileDetailViewDelegate
public protocol ProfileDetailViewDelegate: AnyObject {
}

// MARK: ProfileDetailViewFunction
public protocol ProfileDetailViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
}

// MARK: ProfileDetailViewSubview
public protocol ProfileDetailViewSubview {
}

// MARK: ProfileDetailViewVariable
public protocol ProfileDetailViewVariable {
    var asView: UIView! { get }
    var delegate: ProfileDetailViewDelegate? { get set }
}

// MARK: ProfileDetailView
public protocol ProfileDetailView: ProfileDetailViewFunction, ProfileDetailViewSubview, ProfileDetailViewVariable { }

// MARK: DefaultProfileDetailView
public final class DefaultProfileDetailView: UIView, ProfileDetailView {
    
    // MARK: ProfileDetailViewSubview
    
    // MARK: ProfileDetailViewVariable
    public var asView: UIView!
    public weak var delegate: ProfileDetailViewDelegate?
    
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
public extension DefaultProfileDetailView {
    
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
private extension DefaultProfileDetailView {
    
    func subviewDidLayout() {
    }
    
    func subviewWillAdd() {
    }
    
    func subviewConstraintWillMake() {
    }
    
    func viewDidInit() {
        self.asView = self
    }
    
}
