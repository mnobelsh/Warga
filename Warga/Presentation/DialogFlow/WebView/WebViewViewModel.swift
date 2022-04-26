//
//  WebViewViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 26/10/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation

// MARK: WebViewViewModelResponse
public enum WebViewViewModelResponse {
}

// MARK: WebViewViewModelDelegate
public protocol WebViewViewModelDelegate: AnyObject {
}

// MARK: - WebViewViewModelRequestValue
public struct WebViewViewModelRequestValue {
    var title: String
    var source: String
}

// MARK: - WebViewViewModelRoute
public struct WebViewViewModelRoute {
    var pop: () -> Void
}

// MARK: - WebViewViewModelInput
public protocol WebViewViewModelInput {
    func viewDidLoad()
    func doBack()
}

// MARK: - WebViewViewModelOutput
public protocol WebViewViewModelOutput {
    var requestValue: WebViewViewModelRequestValue { get }
}

// MARK: - WebViewViewModel
public protocol WebViewViewModel: WebViewViewModelInput, WebViewViewModelOutput { }

// MARK: - DefaultWebViewViewModel
public final class DefaultWebViewViewModel: WebViewViewModel {

    // MARK: Dependency Variable
    weak var delegate: WebViewViewModelDelegate?
    let route: WebViewViewModelRoute

    // MARK: Output ViewModel Variable
    public let requestValue: WebViewViewModelRequestValue

    init(
        requestValue: WebViewViewModelRequestValue,
        route: WebViewViewModelRoute
    ) {
        self.requestValue = requestValue
        self.route = route
    }

}

// MARK: Input ViewModel Function
public extension DefaultWebViewViewModel {

    func viewDidLoad() {
    }

    func doBack() {
        self.route.pop()
    }
}

// MARK: Private Function
private extension DefaultWebViewViewModel {

}
