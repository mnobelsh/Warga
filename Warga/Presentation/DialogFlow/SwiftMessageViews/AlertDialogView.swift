//
//  AlertDialogView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 21/10/21.
//

import UIKit
import SwiftMessages
import ChameleonFramework

public struct AlertDialogViewRequestValue {
    
    public enum AlertType {
        case warning
        case success
        case failure
        case info
        case networkFailure
    }
    
    var alertType: AlertType
    var id: String = UUID().uuidString
    var title: String
    var description: String? = nil
    var duration: SwiftMessages.Duration = .seconds(seconds: 8)
    
}

public final class AlertDialogView: MessageView {
    
    // MARK: - SubViews
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.dropShadow(offset: CGSize(width: 2, height: 2), radius: 3, opacity: 0.5)
        
        view.addSubview(self.alertTitleLabel)

        return view
    }()
    lazy var alertIconImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .clear
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    lazy var alertTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .heading3.withSize(16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    lazy var alertDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .body1.withSize(13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    public init(requestValue: AlertDialogViewRequestValue) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150))
        self.viewDidInit(requestValue: requestValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension AlertDialogView {
    
    func viewDidInit(requestValue: AlertDialogViewRequestValue) {
        self.id = requestValue.id
        self.alertTitleLabel.text = requestValue.title
        self.backgroundColor = .clear
        self.addSubview(self.containerView)
        self.addSubview(self.alertIconImageView)
        self.containerView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.safeAreaLayoutGuide).inset(15)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        self.alertIconImageView.snp.makeConstraints {
            $0.top.equalTo(self.containerView).offset(-30)
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(70)
        }
        self.alertTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(self.alertIconImageView.snp.trailing).offset(15)
            $0.top.trailing.equalToSuperview().inset(10)
            $0.bottom.greaterThanOrEqualToSuperview().inset(10)
        }
        if let desc = requestValue.description {
            self.alertDescriptionLabel.text = desc
            self.containerView.addSubview(self.alertDescriptionLabel)
            self.alertTitleLabel.snp.remakeConstraints {
                $0.leading.equalTo(self.alertIconImageView.snp.trailing)
                $0.top.trailing.equalToSuperview().inset(10)
                $0.bottom.equalTo(self.alertDescriptionLabel.snp.top).offset(-2)
            }
            self.alertDescriptionLabel.snp.makeConstraints {
                $0.height.equalToSuperview().multipliedBy(0.4)
                $0.leading.trailing.equalTo(self.alertTitleLabel)
                $0.bottom.equalToSuperview().inset(10)
            }
        }
        switch requestValue.alertType {
        case .failure:
            self.alertIconImageView.image = .failureActionIcon
            self.containerView.backgroundColor = .init(gradientStyle: .leftToRight, withFrame: self.frame, andColors: [UIColor(hexString: "#ee9ca7") ?? .red,UIColor(hexString: "#ffdde1") ?? .softRed])
        case .info:
            self.alertIconImageView.image = .infoActionIcon
            self.containerView.backgroundColor = .init(gradientStyle: .leftToRight, withFrame: self.frame, andColors: [UIColor(hexString: "#C9D6FF") ?? .softPurple,UIColor(hexString: "#E2E2E2") ?? .white])
        case .success:
            self.alertIconImageView.image = .successActionIcon
            self.containerView.backgroundColor = .init(gradientStyle: .leftToRight, withFrame: self.frame, andColors: [UIColor(hexString: "#DCE35B") ?? .green,UIColor(hexString: "#93F9B9") ?? .primaryGreen])
        case .warning:
            self.alertIconImageView.image = .warningActionIcon
            self.containerView.backgroundColor = .init(gradientStyle: .leftToRight, withFrame: self.frame, andColors: [UIColor(hexString: "#EFEFBB") ?? .yellow,UIColor(hexString: "#D4D3DD") ?? .lightGray])
        case .networkFailure:
            self.alertIconImageView.image = .networkFailureActionIcon
            self.containerView.backgroundColor = .init(gradientStyle: .leftToRight, withFrame: self.frame, andColors: [UIColor(hexString: "#ee9ca7") ?? .red,UIColor(hexString: "#ffdde1") ?? .softRed])
        }
    }
    
}
