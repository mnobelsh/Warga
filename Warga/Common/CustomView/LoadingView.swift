//
//  LoadingView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/09/21.
//

import UIKit
import SVProgressHUD

public class LoadingView {
    
    public enum State {
        case show
        case hide
    }
    
    public enum Status {
        case success
        case error
    }
    
    static func show(withStatus status: String? = nil) {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.isUserInteractionEnabled = false
            SVProgressHUD.show(withStatus: status)
        }
    }
    
    static func show(withProgress progress: Float,andStatus status: String? = nil) {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.isUserInteractionEnabled = false
            SVProgressHUD.showProgress(progress, status: status)
        }
    }
    
    static func show(withState state: Status, andStatus status: String? = nil) {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.isUserInteractionEnabled = false
            switch state {
            case .success:
                SVProgressHUD.showSuccess(withStatus: status)
            case .error:
                SVProgressHUD.showError(withStatus: status)
            }
        }
    }
    
    static func hide(completion: SVProgressHUDDismissCompletion? = nil) {
        DispatchQueue.main.async {
            UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.isUserInteractionEnabled = true
            SVProgressHUD.dismiss(completion: completion)
        }
    }
    
    
}
