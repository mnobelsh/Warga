//
//  CommunityDashboardContentPanelController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/10/21.
//

import UIKit

public final class CommunityDashboardContentPanelController: UIViewController {

    // MARK: Dependency Variable
    var viewModel: CommunityDashboardViewModel!
    
    class func create(with viewModel: CommunityDashboardViewModel) -> CommunityDashboardContentPanelController {
        let controller = CommunityDashboardContentPanelController()
        controller.viewModel = viewModel
        return controller
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white.withAlphaComponent(0.3)
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds
        self.view.addSubview(blurView)
        self.viewModel.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
}
