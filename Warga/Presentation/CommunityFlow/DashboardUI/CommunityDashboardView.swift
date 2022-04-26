//
//  CommunityDashboardView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import FloatingPanel

// MARK: CommunityDashboardViewDelegate
public protocol CommunityDashboardViewDelegate: AnyObject {
}

// MARK: CommunityDashboardViewFunction
public protocol CommunityDashboardViewFunction {
    func viewWillAppear(navigationBar: UINavigationBar?,
                        navigationItem: UINavigationItem,
                        tabBarController: UITabBarController?)
    func viewWillDisappear()
    func viewDidAppear()
    func showActivityButtons(isShow: Bool)
    func showContentPanel(at parent: CommunityDashboardController)
    func showSearchResultPanel(at parent: CommunityDashboardController)
}

// MARK: CommunityDashboardViewSubview
public protocol CommunityDashboardViewSubview {
    var mapView: MapView { get set }
    var contentPanelController: FloatingPanelController { get set }
    var searchPanelController: FloatingPanelController { get set }
    var activityShortcutButton: UIButton {  get set  }
    var medicButton: UIView {  get set  }
    var dangerButton: UIView {  get set  }
    var suspiciousButton: UIView {  get set  }
    var quarantineButton: UIView {  get set  }
    var searchBar: UISearchBar { get set }
}

// MARK: CommunityDashboardViewVariable
public protocol CommunityDashboardViewVariable {
    var asView: UIView! { get }
    var delegate: CommunityDashboardViewDelegate? { get set }
    var activityButtonIsShown: Bool { get set }
}

// MARK: CommunityDashboardView
public protocol CommunityDashboardView: CommunityDashboardViewFunction, CommunityDashboardViewSubview, CommunityDashboardViewVariable { }

// MARK: DefaultCommunityDashboardView
public final class DefaultCommunityDashboardView: UIView, CommunityDashboardView {
    
    // MARK: CommunityDashboardViewSubview
    public lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 150, height: 35))
        searchBar.autocorrectionType = .no
        searchBar.autocapitalizationType = .none
        searchBar.barStyle = .default
        searchBar.returnKeyType = .search
        searchBar.isTranslucent = true
        searchBar.layer.cornerRadius = 6
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Cari lokasi...",
            attributes: [.foregroundColor: UIColor.placeholderText, .font: UIFont.urbanistLight(withSize: 16)]
        )
        searchBar.searchTextField.font = UIFont.latoBold(withSize: 16)
        return searchBar
    }()
    public lazy var mapView: MapView = MapView.shared
    public lazy var contentPanelController: FloatingPanelController = {
        let controller = FloatingPanelController()
        controller.layout = ContentFloatingPanelLayout()
        controller.delegate = self
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 18.0
        appearance.backgroundColor = .clear
        controller.surfaceView.appearance = appearance
        controller.surfaceView.grabberHandleSize = .init(width: 65.0, height: 5.0)
        controller.surfaceView.grabberHandle.barColor = .gray
        return controller
    }()
    public lazy var searchPanelController: FloatingPanelController = {
        let controller = FloatingPanelController()
        controller.layout = SearchFloatingPanelLayout()
        controller.delegate = self
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 18.0
        appearance.backgroundColor = .clear
        controller.surfaceView.appearance = appearance
        controller.surfaceView.grabberHandleSize = .init(width: 0, height: 0)
        controller.surfaceView.grabberHandle.barColor = .clear
        return controller
    }()
    lazy var leftBarButtonView: UIView = .makeLeftBarView(title: "Lingkungan")
    public lazy var activityShortcutButton: UIButton = {
        let button = UIButton(type: .system)
        button.bringSubviewToFront(self)
        button.setBackgroundImage(.boltCircleFillIcon.withTintColor(.primaryPurple), for: .normal)
        button.contentMode = .scaleAspectFill
        button.backgroundColor = .clear
        return button
    }()
    public lazy var medicButton: UIView = .makeActivityButton(title: "Kecelakaan", image: .medicalIcon, color: .softRed)
    public lazy var dangerButton: UIView = .makeActivityButton(title: "Keadaan Berbahaya", image: .dangerIcon, color: .red)
    public lazy var suspiciousButton: UIView = .makeActivityButton(title: "Kegiatan Mencurigakan", image: .suspiciousIcon, color: .darkGray)
    public lazy var quarantineButton: UIView = .makeActivityButton(title: "Isolasi Mandiri", image: .quarantineIcon, color: .orange)
    lazy var activityButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.medicButton,
            self.quarantineButton,
            self.dangerButton,
            self.suspiciousButton
        ])
        stackView.alpha = 0
        stackView.axis = .horizontal
        stackView.spacing = 18
        stackView.alignment = .trailing
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    // MARK: CommunityDashboardViewVariable
    public var asView: UIView!
    public weak var delegate: CommunityDashboardViewDelegate?
    public var activityButtonIsShown = false
    var targetState: FloatingPanelState = .tip
    
    // MARK: Init Function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: UIScreen.main.fixedCoordinateSpace.bounds)
        self.subviewWillAdd()
        self.subviewConstraintWillMake()
        self.viewDidInit()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.subviewDidLayout()
    }
    
}

// MARK: Input Function
public extension DefaultCommunityDashboardView {
    
    func viewWillAppear(
        navigationBar: UINavigationBar?,
        navigationItem: UINavigationItem,
        tabBarController: UITabBarController?
    ) {
        navigationBar?.setTransparentBackground()
        navigationItem.setLeftBarButton(UIBarButtonItem(customView: self.leftBarButtonView), animated: true)
    }
    
    func viewWillDisappear() {
        self.activityButtonIsShown = false
        self.hideShortcutButton()
    }
    
    func viewDidAppear() {
        self.activityButtonIsShown = false
        self.showShortcutButton()
    }
    
    func showActivityButtons(isShow: Bool) {
        let numOfSubViews = self.activityButtonStackView.arrangedSubviews.count
        for (index, view) in self.activityButtonStackView.arrangedSubviews.enumerated() {
            UIView.animate(withDuration: TimeInterval((Float(numOfSubViews-index)*0.2))) { [unowned self] in
                view.alpha = isShow ? 1 : 0
                self.layoutIfNeeded()
            }
        }
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.activityButtonStackView.alpha = isShow ? 1 : 0
            self.activityShortcutButton.transform = CGAffineTransform(rotationAngle: isShow ? (-90 * CGFloat.pi/180) : 0)
            if isShow {
                self.activityButtonStackView.snp.remakeConstraints {
                    $0.leading.greaterThanOrEqualToSuperview().offset(10)
                    $0.trailing.equalTo(self.activityShortcutButton.snp.leading)
                    $0.bottom.equalTo(self.activityShortcutButton.snp.top).offset(-8)
                }
            } else {
                self.activityButtonStackView.snp.remakeConstraints {
                    $0.leading.greaterThanOrEqualToSuperview().offset(10)
                    $0.trailing.equalTo(self.activityShortcutButton.snp.leading)
                    $0.centerY.equalTo(self.activityShortcutButton)
                }
            }
            self.layoutIfNeeded()
        }
    }
    
    func showContentPanel(at parent: CommunityDashboardController) {
        guard !self.contentPanelController.isBeingPresented else { return }
        DispatchQueue.main.async {
            self.searchPanelController.removePanelFromParent(animated: true) { [unowned self] in
                self.contentPanelController.addPanel(toParent: parent, at: 2, animated: true)
            }
        }
    }
    
    func showSearchResultPanel(at parent: CommunityDashboardController) {
        guard !self.searchPanelController.isBeingPresented else { return }
        DispatchQueue.main.async {
            self.contentPanelController.removePanelFromParent(animated: true) { [unowned self] in
                self.searchPanelController.addPanel(toParent: parent, at: 2, animated: true)
            }
        }
    }
}

// MARK: Private Function
private extension DefaultCommunityDashboardView {
    
    func subviewDidLayout() {
    }
    
    func subviewWillAdd() {
        self.addSubview(self.mapView)
        self.addSubview(self.searchBar)
        self.addSubview(self.activityShortcutButton)
        self.addSubview(self.activityButtonStackView)
    }
    
    func subviewConstraintWillMake() {
        self.mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.searchBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(35)
        }
        self.activityShortcutButton.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(15)
            $0.width.height.equalTo(60)
        }
        self.activityButtonStackView.snp.makeConstraints {
            $0.leading.greaterThanOrEqualToSuperview().offset(10)
            $0.trailing.equalTo(self.activityShortcutButton.snp.leading)
            $0.centerY.equalTo(self.activityShortcutButton)
        }
    }
    
    func viewDidInit() {
        self.asView = self
        self.backgroundColor = .background
    }
    
    func showShortcutButton() {
        self.activityShortcutButton.alpha = 1
        UIView.animate(withDuration: 0.35) {
            self.activityShortcutButton.snp.remakeConstraints { [unowned self] in
                $0.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(15)
                $0.width.height.equalTo(50)
            }
            self.layoutIfNeeded()
        }
    }
    
    func hideShortcutButton() {
        self.activityShortcutButton.alpha = 0
        self.activityButtonStackView.alpha = 0
        self.activityButtonStackView.arrangedSubviews.forEach {
            $0.alpha = 0
        }
        self.activityShortcutButton.transform = CGAffineTransform(rotationAngle: 0)
        UIView.animate(withDuration: 0.35) { [unowned self] in
            self.activityShortcutButton.snp.remakeConstraints {
                $0.top.equalTo(self.snp.bottom)
                $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(15)
                $0.width.height.equalTo(60)
            }
            self.layoutIfNeeded()
        }
    }
    
}

fileprivate extension UIView {
    
    static func makeActivityButton(title: String, image: UIImage, color: UIColor = .primaryPurple) -> UIView {
        let containerView = UIView()
        containerView.isUserInteractionEnabled = true
        containerView.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(70)
        }
        containerView.backgroundColor = .clear
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .black
        titleLabel.font = .heading3.withSize(10)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.7
        
        let imageContainerView = UIView()
        imageContainerView.layer.cornerRadius = 15
        imageContainerView.backgroundColor = .white
        imageContainerView.dropShadow(offset: CGSize(width: 1.5, height: 1.5), radius: 5, opacity: 0.4)
        
        let imageView = UIImageView(image: image.withTintColor(color))
        imageView.tintColor = color
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        imageContainerView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        containerView.addSubview(imageContainerView)
        containerView.addSubview(titleLabel)
        imageContainerView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(titleLabel.snp.top).offset(-3)
        }
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        return containerView
    }
    
    
}

extension DefaultCommunityDashboardView: FloatingPanelControllerDelegate {

    
}

class ContentFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 60.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.6, edge: .bottom, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 200.0, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}

class SearchFloatingPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .full
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(absoluteInset: 80.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 80.0, edge: .top, referenceGuide: .safeArea),
            .tip: FloatingPanelLayoutAnchor(absoluteInset: 80.0, edge: .top, referenceGuide: .safeArea),
        ]
    }
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        switch state {
        default: return 0.0
        }
    }
}

