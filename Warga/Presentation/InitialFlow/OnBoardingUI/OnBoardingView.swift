//
//  OnBoardingView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit

// MARK: OnBoardingViewDelegate
public protocol OnBoardingViewDelegate: AnyObject {
}

// MARK: OnBoardingViewFunction
public protocol OnBoardingViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
}

// MARK: OnBoardingViewSubview
public protocol OnBoardingViewSubview {
}

// MARK: OnBoardingViewVariable
public protocol OnBoardingViewVariable {
    var asView: UIView! { get }
    var delegate: OnBoardingViewDelegate? { get set }
}

// MARK: OnBoardingView
public protocol OnBoardingView: OnBoardingViewFunction, OnBoardingViewSubview, OnBoardingViewVariable { }

// MARK: DefaultOnBoardingView
public final class DefaultOnBoardingView: UIView, OnBoardingView {
    
    // MARK: OnBoardingViewSubview
    
    // MARK: OnBoardingViewVariable
    public var asView: UIView!
    public weak var delegate: OnBoardingViewDelegate?
    
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
public extension DefaultOnBoardingView {
    
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
private extension DefaultOnBoardingView {
    
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
