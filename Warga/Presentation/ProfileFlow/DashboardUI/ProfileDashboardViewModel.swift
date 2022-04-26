//
//  ProfileDashboardViewModel.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//  Copyright (c) 2021 All rights reserved.

import Foundation
import RxSwift
import RxRelay

// MARK: ProfileDashboardViewModelResponse
public enum ProfileDashboardViewModelResponse {
}

// MARK: ProfileDashboardViewModelDelegate
public protocol ProfileDashboardViewModelDelegate: AnyObject {
}

// MARK: - ProfileDashboardViewModelRequestValue
public struct ProfileDashboardViewModelRequestValue {
}

// MARK: - ProfileDashboardViewModelRoute
public struct ProfileDashboardViewModelRoute {
    var startProfileFlow: (_ instructor: ProfileFlowCoordinatorInstructor) -> Void
    var startInitialFlow: (_ instructor: InitialFlowCoordinatorInstructor) -> Void
    var startDialogFlow: (_ instructor: DialogFlowCoordinatorInstructor) -> Void
}

// MARK: - ProfileDashboardViewModelInput
public protocol ProfileDashboardViewModelInput {
    func viewDidLoad()
    func viewWillAppear()
    func setShowInMap(_ isShow: Bool)
    func setNotification(_ isEnable: Bool)
    func didSelect(_ menu: ProfileDashboardMenu)
    func showConfirmationDialog(requestValue: ConfirmationDialogRequestValue)
    func doSignOut()
}

// MARK: - ProfileDashboardViewModelOutput
public protocol ProfileDashboardViewModelOutput {
    var displayedProfile: PublishRelay<ProfileDTO> { get }
    var displayedLoadingState: PublishRelay<LoadingView.State> { get }
}

// MARK: - ProfileDashboardViewModel
public protocol ProfileDashboardViewModel: ProfileDashboardViewModelInput, ProfileDashboardViewModelOutput { }

// MARK: - DefaultProfileDashboardViewModel
public final class DefaultProfileDashboardViewModel: ProfileDashboardViewModel {

    // MARK: Dependency Variable
    weak var delegate: ProfileDashboardViewModelDelegate?
    let requestValue: ProfileDashboardViewModelRequestValue
    let route: ProfileDashboardViewModelRoute

    // MARK: Output ViewModel Variable
    public let displayedProfile = PublishRelay<ProfileDTO>()
    public let displayedLoadingState = PublishRelay<LoadingView.State>()
    
    // MARK: - Use Case
    private let fetchUserProfileUseCase: FetchUserProfileUseCase

    init(
        requestValue: ProfileDashboardViewModelRequestValue,
        route: ProfileDashboardViewModelRoute,
        fetchUserProfileUseCase: FetchUserProfileUseCase
    ) {
        self.requestValue = requestValue
        self.route = route
        self.fetchUserProfileUseCase = fetchUserProfileUseCase
    }

}

// MARK: Input ViewModel Function
public extension DefaultProfileDashboardViewModel {

    func viewDidLoad() {
        guard let currentUser = UserPreference.shared.currentProfile else { return }
        let request = FetchUserProfileUseCaseRequest(parameter: .byId(currentUser.id))
        self.fetchUserProfileUseCase.execute(request) { [weak self] res in
            guard let self = self else { return }
            switch res {
            case .success(let profile):
                guard let profile = profile else { return }
                self.displayedProfile.accept(profile)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func viewWillAppear() {
    }
    
    func setShowInMap(_ isShow: Bool) {
        UserPreference.shared.showInMap = isShow
    }
    
    func setNotification(_ isEnable: Bool) {
        UserPreference.shared.allowNotification = isEnable
    }
    
    func didSelect(_ menu: ProfileDashboardMenu) {
        switch menu.type {
        case .familyMembers:
            let requestValue = FamilyMemberViewModelRequestValue()
            self.route.startProfileFlow(.familyMember(requestValue: requestValue))
        case .documents:
            let requestValue = DocumentListViewModelRequestValue()
            self.route.startProfileFlow(.documentList(requestValue: requestValue))
        case .activites:
            let requestValue = ActivityListViewModelRequestValue()
            self.route.startProfileFlow(.activityList(requestValue: requestValue))
        default:
            break
        }
    }
    
    func showConfirmationDialog(requestValue: ConfirmationDialogRequestValue) {
        self.route.startDialogFlow(.confirmationDialog(requestValue: requestValue))
    }
    
    func doSignOut() {
        self.displayedLoadingState.accept(.show)
        
        FirebaseService.shared.signOut { error in
            guard error == nil else { return }
            let requestValue = LandingViewModelRequestValue()
            self.displayedLoadingState.accept(.hide)
            self.route.startInitialFlow(.landing(requestValue: requestValue))
            UserPreference.shared.currentProfile = nil
        }
        
    }
}

// MARK: Private Function
private extension DefaultProfileDashboardViewModel {


    
}
