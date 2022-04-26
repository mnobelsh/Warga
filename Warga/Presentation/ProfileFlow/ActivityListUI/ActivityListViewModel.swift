//
//  ActivityListViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//  Copyright (c) 2022 All rights reserved.

import Foundation

// MARK: ActivityListViewModelResponse
public enum ActivityListViewModelResponse {
}

// MARK: ActivityListViewModelDelegate
public protocol ActivityListViewModelDelegate: AnyObject {
}

// MARK: - ActivityListViewModelRequestValue
public struct ActivityListViewModelRequestValue {
}

// MARK: - ActivityListViewModelRoute
public struct ActivityListViewModelRoute {
}

// MARK: - ActivityListViewModelInput
public protocol ActivityListViewModelInput {
    func viewDidLoad()
}

// MARK: - ActivityListViewModelOutput
public protocol ActivityListViewModelOutput {
}

// MARK: - ActivityListViewModel
public protocol ActivityListViewModel: ActivityListViewModelInput, ActivityListViewModelOutput { }

// MARK: - DefaultActivityListViewModel
public final class DefaultActivityListViewModel: ActivityListViewModel {

    // MARK: Dependency Variable
    weak var delegate: ActivityListViewModelDelegate?
    let requestValue: ActivityListViewModelRequestValue
    let route: ActivityListViewModelRoute

    // MARK: Output ViewModel Variable

    init(
        requestValue: ActivityListViewModelRequestValue,
        route: ActivityListViewModelRoute
    ) {
        self.requestValue = requestValue
        self.route = route
    }

}

// MARK: Input ViewModel Function
public extension DefaultActivityListViewModel {

    func viewDidLoad() {
    }

}

// MARK: Private Function
private extension DefaultActivityListViewModel {

}
