//
//  WebViewView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 26/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import WebKit

// MARK: WebViewViewDelegate
public protocol WebViewViewDelegate: AnyObject {
    func onBackButtonDidTap(_ sender: UITapGestureRecognizer)
}

// MARK: WebViewViewFunction
public protocol WebViewViewFunction {
    func viewWillAppear(title: String,
                        navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
    func configureProgressBar(progress: Float)
}

// MARK: WebViewViewSubview
public protocol WebViewViewSubview {
    var progressView: UIProgressView { get set }
    var webView: WKWebView { get set }
}

// MARK: WebViewViewVariable
public protocol WebViewViewVariable {
    var asView: UIView! { get }
    var delegate: WebViewViewDelegate? { get set }
}

// MARK: WebViewView
public protocol WebViewView: WebViewViewFunction, WebViewViewSubview, WebViewViewVariable { }

// MARK: DefaultWebViewView
public final class DefaultWebViewView: UIView, WebViewView, WKUIDelegate  {
    
    // MARK: WebViewViewSubview
    private var leftBarView: UIView?
    public lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.progressTintColor = .primaryPurple
        return progressView
    }()
    public lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let view = WKWebView(frame: self.frame, configuration: config)
        view.allowsBackForwardNavigationGestures = true
        view.uiDelegate = self
        return view
    }()
    
    // MARK: WebViewViewVariable
    public var asView: UIView!
    public weak var delegate: WebViewViewDelegate?
    
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
public extension DefaultWebViewView {
    
    func viewWillAppear(
        title: String,
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    ) {
        navigationBar?.setBackgroundColor(.white)
        self.leftBarView = .makeLeftBarView(icon: .chevronLeft, title: title, action: (target: self, selector: #selector(self.onBackButtonDidTap(_:))))
        navigationItem.setLeftBarButton(UIBarButtonItem(customView: self.leftBarView!), animated: true)
    }
    
    func viewWillDisappear() {
        self.webView.stopLoading()
    }
    
    func configureProgressBar(progress: Float) {
        guard progress < 1 else {
            self.progressView.progress = 1
            UIView.animate(withDuration: 0.2) {
                self.progressView.alpha = 0
            }
            return
        }
        self.progressView.progress = progress
    }
    
}

// MARK: Private Function
private extension DefaultWebViewView {
    
    func subviewDidLayout() {
    }
    
    func subviewWillAdd() {
        self.addSubview(self.webView)
        self.addSubview(self.progressView)
    }
    
    func subviewConstraintWillMake() {
        self.webView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        self.progressView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(1.5)
        }
    }
    
    func viewDidInit() {
        self.asView = self
        self.progressView.progress = 0.0
    }
    
    @objc
    func onBackButtonDidTap(_ sender: UITapGestureRecognizer) {
        self.delegate?.onBackButtonDidTap(sender)
    }
    
}
