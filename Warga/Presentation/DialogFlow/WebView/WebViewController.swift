//
//  WebViewController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 26/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import WebKit

// MARK: WebViewController
public final class WebViewController: UIViewController {
    
    // MARK: Dependency Variable
    lazy var _view: WebViewView = DefaultWebViewView()
    var viewModel: WebViewViewModel!
    
    private var progressObservation: NSKeyValueObservation?
    
    class func create(with viewModel: WebViewViewModel) -> WebViewController {
        let controller = WebViewController()
        controller.viewModel = viewModel
        return controller
    }
    
    public override func loadView() {
        self._view.delegate = self
        self.view = self._view.asView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
        self.bind(to: self.viewModel)
        self.viewModel.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViewWillAppear()
    }
    
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setupViewWillDisappear()
    }
    
}

// MARK: Private Function
private extension WebViewController {
    
    func bind(to viewModel: WebViewViewModel) {
    }
    
    func setupViewDidLoad() {
        guard let url = URL(string: self.viewModel.requestValue.source) else {
            return
        }
        let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: TimeInterval(60.0))
        self._view.webView.load(urlRequest)
        self.addObservers()
    }
    
    func setupViewWillAppear() {
        self._view.viewWillAppear(
            title: self.viewModel.requestValue.title,
            navigationBar: self.navigationController?.navigationBar,
            navigationItem: self.navigationItem,
            tabBarController: self.tabBarController
        )
    }
    
    func setupViewWillDisappear() {
        self._view.viewWillDisappear()
        self.removeObservers()
    }
    
    func addObservers() {
        self.progressObservation = self._view.webView.observe(\WKWebView.estimatedProgress, options: .new) { [weak self] webView, change in
            guard let self = self else { return }
            self._view.configureProgressBar(progress: Float(change.newValue ?? 0.0))
        }
    }
    
    func removeObservers() {
        self.progressObservation?.invalidate()
    }
    
}

// MARK: WebViewController+WebViewViewDelegate
extension WebViewController: WebViewViewDelegate {
    
    public func onBackButtonDidTap(_ sender: UITapGestureRecognizer) {
        self.viewModel.doBack()
    }
    
}
