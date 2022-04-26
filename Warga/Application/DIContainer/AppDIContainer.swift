//
//  AppDIContainer.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//

import UIKit
import SwiftMessages

public typealias Factory = PresentationFactory & FlowCoordinatorFactory
public typealias PresentationFactory =
    AuthFlowCoordinatorFactory &
    InitialFlowCoordinatorFactory &
    LaunchpadFlowCoordinatorFactory &
    HomeFlowCoordinatorFactory &
    ProfileFlowCoordinatorFactory &
    CitizenshipFlowCoordinatorFactory &
    CommunityFlowCoordinatorFactory &
    DialogFlowCoordinatorFactory &
    DocumentFlowCoordinatorFactory

public class AppDICointainer {
    
    var navigationController: UINavigationController
    lazy var firestoreStorage: FirebaseFirestoreStorage = {
        return FirebaseFirestoreStorage.shared
    }()
    lazy var newsStorage: NewsStorage = {
        return DefaultNewsStorage(newsNetworkService: DefaultNewsAPINetworkService())
    }()
    lazy var weatherStorage: ForecastStorage = {
        return DefaultForecastStorage(weatherNetworkService: DefaultForecastAPINetworkService())
    }()
    
    public enum Instructor {
        case landing
        case mainApp
        case launchpad
    }
    
    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
    
    public func start(_ instructor: Instructor) {
        self.observeNetworkStatus()
        switch instructor {
        case .landing:
            let requestValue = LandingViewModelRequestValue()
            self.instantiateInitialFlowCoordinator().start(with: .landing(requestValue: requestValue))
        case .mainApp:
            self.instantiateAuthFlowCoordinator(navigationController: self.navigationController).start(with: .signIn(requestValue: .init()))
        case .launchpad:
            self.instantiateLaunchpadFlowCoordinator().start(with: .launchpad)
        }
    }
    
}

private extension AppDICointainer {
    
    func observeNetworkStatus() {
        let alertId = UUID().uuidString
        NetworkReachability.shared.whenUnreachable = { [weak self] _ in
            guard let self = self else { return }
            let request = AlertDialogViewRequestValue(alertType: .networkFailure, id: alertId, title: "Gagal memuat konten", description: "Perangkat anda tidak terhubung dengan koneksi internet, pastikan anda terhubung dengan koneksi internet.")
            self.instantiateDialogFlowCoordinator(navigationController: self.navigationController).start(with: .alert(requestValue: request))
        }
        
        NetworkReachability.shared.whenReachable = { _ in
            SwiftMessages.hide(id: alertId)
        }
    }
    
}
