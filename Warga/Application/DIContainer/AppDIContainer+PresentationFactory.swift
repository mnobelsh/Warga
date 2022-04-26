//
//  AppDIContainer+PresentationFactory.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//

import Foundation

extension AppDICointainer: PresentationFactory {

    // MARK: - Auth Flow Coordinator Factory
    public func makeSignInController(requestValue: SignInViewModelRequestValue, route: SignInViewModelRoute) -> SignInController {
        let viewModel = DefaultSignInViewModel(
            requestValue: requestValue,
            route: route,
            fetchUserProfileUseCase: self.makeFetchUserProfileUseCase()
        )
        return SignInController.create(with: viewModel)
    }
    
    public func makeSignUpController(requestValue: SignUpViewModelRequestValue, route: SignUpViewModelRoute) -> SignUpController {
        let viewModel = DefaultSignUpViewModel(
            requestValue: requestValue,
            route: route,
            fetchUserProfileUseCase: self.makeFetchUserProfileUseCase(),
            saveUserProfileUseCase: self.makeSaveUserProfileUseCase()
        )
        return SignUpController.create(with: viewModel)
    }
    
    public func makeOTPVerificationController(requestValue: OTPVerificationViewModelRequestValue, route: OTPVerificationViewModelRoute) -> OTPVerificationController {
        let viewModel = DefaultOTPVerificationViewModel(requestValue: requestValue, route: route)
        return OTPVerificationController.create(with: viewModel)
    }
    
    // MARK: - Citizenship Flow Coordinator Factory
    public func makeCitizenshipDashboardController(requestValue: CitizenshipDashboardViewModelRequestValue, route: CitizenshipDashboardViewModelRoute) -> CitizenshipDashboardController {
        let viewModel = DefaultCitizenshipDashboardViewModel(requestValue: requestValue, route: route, fetchRequestDocumentUseCase: self.makeFetchRequestDocumentUseCase())
        return CitizenshipDashboardController.create(with: viewModel)
    }
    
    public func makeDocumentDetailController(requestValue: DocumentDetailViewModelRequestValue, route: DocumentDetailViewModelRoute) -> DocumentDetailController {
        let viewModel = DefaultDocumentDetailViewModel(requestValue: requestValue, route: route)
        return DocumentDetailController.create(with: viewModel)
    }
    
    public func makeRequestDocumentController(requestValue: RequestDocumentViewModelRequestValue, route: RequestDocumentViewModelRoute) -> RequestDocumentController {
        let viewModel = DefaultRequestDocumentViewModel(
            requestValue: requestValue,
            route: route,
            fetchUserProfileUseCase: self.makeFetchUserProfileUseCase(), saveUserProfileUseCase: self.makeSaveUserProfileUseCase(), requestDocumentUseCase: self.makeRequestDocumentUseCase()
        )
        return RequestDocumentController.create(with: viewModel)
    }
    
    // MARK: - Community Flow Coordinator Factory
    public func makeCommunityDashboardController(requestValue: CommunityDashboardViewModelRequestValue, route: CommunityDashboardViewModelRoute) -> CommunityDashboardController {
        let viewModel = DefaultCommunityDashboardViewModel(requestValue: requestValue, route: route)
        return CommunityDashboardController.create(with: viewModel)
    }
    
    // MARK: - Initial Flow Coordinator Factory
    public func makeLandingController(requestValue: LandingViewModelRequestValue, route: LandingViewModelRoute) -> LandingController {
        let viewModel = DefaultLandingViewModel(requestValue: requestValue, route: route)
        return LandingController.create(with: viewModel)
    }
    
    public func makeOnBoardingController(requestValue: OnBoardingViewModelRequestValue, route: OnBoardingViewModelRoute) -> OnBoardingController {
        let viewModel = DefaultOnBoardingViewModel(requestValue: requestValue, route: route)
        return OnBoardingController.create(with: viewModel)
    }
    
    // MARK: - Home Flow Coordinator Factory
    public func makeHomeDashboardController(requestValue: HomeDashboardViewModelRequestValue, route: HomeDashboardViewModelRoute) -> HomeDashboardController {
        let viewModel = DefaultHomeDashboardViewModel(
            requestValue: requestValue,
            route: route,
            fetchNewsUseCase: self.makeFetchNewsUseCase(),
            fetchForecastUseCase: self.makeFetchForecastUseCase()
        )
        return HomeDashboardController.create(with: viewModel)
    }
    
    // MARK: - Launchpad Flow Coordinator Factory
    public func makeLaunchpadController(requestValue: LaunchpadViewModelRequestValue, route: LaunchpadViewModelRoute) -> LaunchpadController {
        let viewModel = DefaultLaunchpadViewModel(requestValue: requestValue, route: route)
        return LaunchpadController.create(with: viewModel)
    }
    
    // MARK: - Profile Flow Coordinator Factory
    public func makeProfileDashboardController(requestValue: ProfileDashboardViewModelRequestValue, route: ProfileDashboardViewModelRoute) -> ProfileDashboardController {
        let viewModel = DefaultProfileDashboardViewModel(
            requestValue: requestValue,
            route: route,
            fetchUserProfileUseCase: self.makeFetchUserProfileUseCase()
        )
        return ProfileDashboardController.create(with: viewModel)
    }
    public func makeFamilyMemberController(requestValue: FamilyMemberViewModelRequestValue, route: FamilyMemberViewModelRoute) -> FamilyMemberController {
        let viewModel = DefaultFamilyMemberViewModel(requestValue: requestValue, route: route)
        return FamilyMemberController.create(with: viewModel)
    }
    public func makeActivityListController(requestValue: ActivityListViewModelRequestValue, route: ActivityListViewModelRoute) -> ActivityListController {
        let viewModel = DefaultActivityListViewModel(requestValue: requestValue, route: route)
        return ActivityListController.create(with: viewModel)
    }
    public func makeDocumentListController(requestValue: DocumentListViewModelRequestValue, route: DocumentListViewModelRoute) -> DocumentListController {
        let viewModel = DefaultDocumentListViewModel(requestValue: requestValue, route: route, fetchUserProfileUseCase: self.makeFetchUserProfileUseCase())
        return DocumentListController.create(with: viewModel)
    }
    

    // MARK: - Document Flow Coordinator Factory
    public func makeScanDocumentController(requestValue: ScanDocumentViewModelRequestValue, route: ScanDocumentViewModelRoute) -> ScanDocumentController {
        let viewModel = DefaultScanDocumentViewModel(requestValue: requestValue, route: route)
        return ScanDocumentController.create(with: viewModel)
    }
    
    public  func makeViewDocumentController(requestValue: ViewDocumentViewModelRequestValue, route: ViewDocumentViewModelRoute) -> ViewDocumentController {
        let viewModel = DefaultViewDocumentViewModel(requestValue: requestValue, route: route)
        return ViewDocumentController.create(with: viewModel)
    }
    
    // MARK: - Dialog Flow cOORDINATOR Factory
    public func makeWebViewController(requestValue: WebViewViewModelRequestValue, route: WebViewViewModelRoute) -> WebViewController {
        let viewModel = DefaultWebViewViewModel(requestValue: requestValue, route: route)
        return WebViewController.create(with: viewModel)
    }
    
    
    
    
}
