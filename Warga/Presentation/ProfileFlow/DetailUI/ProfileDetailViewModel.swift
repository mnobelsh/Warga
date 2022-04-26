//
//  ProfileDetailViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation

// MARK: ProfileDetailViewModelResponse
public enum ProfileDetailViewModelResponse {
}

// MARK: ProfileDetailViewModelDelegate
public protocol ProfileDetailViewModelDelegate: AnyObject {
}

// MARK: - ProfileDetailViewModelRequestValue
public struct ProfileDetailViewModelRequestValue {
}

// MARK: - ProfileDetailViewModelRoute
public struct ProfileDetailViewModelRoute {
}

// MARK: - ProfileDetailViewModelInput
public protocol ProfileDetailViewModelInput {
    func viewDidLoad()
}

// MARK: - ProfileDetailViewModelOutput
public protocol ProfileDetailViewModelOutput {
}

// MARK: - ProfileDetailViewModel
public protocol ProfileDetailViewModel: ProfileDetailViewModelInput, ProfileDetailViewModelOutput { }

// MARK: - DefaultProfileDetailViewModel
public final class DefaultProfileDetailViewModel: ProfileDetailViewModel {

    // MARK: Dependency Variable
    weak var delegate: ProfileDetailViewModelDelegate?
    let requestValue: ProfileDetailViewModelRequestValue
    let route: ProfileDetailViewModelRoute

    // MARK: Output ViewModel Variable

    init(
        requestValue: ProfileDetailViewModelRequestValue,
        route: ProfileDetailViewModelRoute
    ) {
        self.requestValue = requestValue
        self.route = route
    }

}

// MARK: Input ViewModel Function
public extension DefaultProfileDetailViewModel {

    func viewDidLoad() {
    }

}

// MARK: Private Function
private extension DefaultProfileDetailViewModel {

}
