//
//  OnBoardingViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation

// MARK: OnBoardingViewModelResponse
public enum OnBoardingViewModelResponse {
}

// MARK: OnBoardingViewModelDelegate
public protocol OnBoardingViewModelDelegate: AnyObject {
}

// MARK: - OnBoardingViewModelRequestValue
public struct OnBoardingViewModelRequestValue {
}

// MARK: - OnBoardingViewModelRoute
public struct OnBoardingViewModelRoute {
}

// MARK: - OnBoardingViewModelInput
public protocol OnBoardingViewModelInput {
    func viewDidLoad()
}

// MARK: - OnBoardingViewModelOutput
public protocol OnBoardingViewModelOutput {
}

// MARK: - OnBoardingViewModel
public protocol OnBoardingViewModel: OnBoardingViewModelInput, OnBoardingViewModelOutput { }

// MARK: - DefaultOnBoardingViewModel
public final class DefaultOnBoardingViewModel: OnBoardingViewModel {

    // MARK: Dependency Variable
    weak var delegate: OnBoardingViewModelDelegate?
    let requestValue: OnBoardingViewModelRequestValue
    let route: OnBoardingViewModelRoute

    // MARK: Output ViewModel Variable

    init(
        requestValue: OnBoardingViewModelRequestValue,
        route: OnBoardingViewModelRoute
    ) {
        self.requestValue = requestValue
        self.route = route
    }

}

// MARK: Input ViewModel Function
public extension DefaultOnBoardingViewModel {

    func viewDidLoad() {
    }

}

// MARK: Private Function
private extension DefaultOnBoardingViewModel {

}
