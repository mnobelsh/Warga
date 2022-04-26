//
//  InstructionDialogView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 22/10/21.
//

import UIKit
import SwiftMessages

public struct InstructionDialogViewRequestValue {
    
    enum AlertType {
        case warning
        case success
        case failure
        case info
    }
    
    var id: String = UUID().uuidString
    var title: String
    var image: UIImage? = nil
    var confirmationButton: (title: String?, action: (() -> Void)?)
    var duration: SwiftMessages.Duration = .forever
    
}

public class InstructionDialogView: MessageView {
    
    // MARK: - SubViews
    lazy var handImageView: UIImageView = {
        let imageView = UIImageView(image: .okHand3D)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    lazy var contentTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = .heading3.withSize(16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.addSubview(self.contentTitleLabel)
        view.addSubview(self.confirmationButton)
        return view
    }()
    lazy var confirmationButton: UIButton = {
        let button: UIButton = .roundedFilledButton(title: "Saya mengerti")
        button.addTarget(self, action: #selector(self.onConfirmationButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    var confirmationButtonAction: (() -> Void)?
    
    public init(requestValue: InstructionDialogViewRequestValue) {
        super.init(frame: UIScreen.main.bounds)
        self.cellDidInit(requestValue: requestValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension InstructionDialogView {
    
    func cellDidInit(requestValue: InstructionDialogViewRequestValue) {
        self.contentTitleLabel.text = requestValue.title
        if let buttonTitle = requestValue.confirmationButton.title {
            self.confirmationButton.setTitle(buttonTitle, for: .normal)
        }
        self.confirmationButtonAction = requestValue.confirmationButton.action
        
        self.backgroundColor = .clear
    
        self.addSubview(self.containerView)
        self.addSubview(self.handImageView)
        
        self.handImageView.snp.makeConstraints {
            $0.top.equalTo(self.confirmationButton.snp.top).offset(-30)
            $0.bottom.trailing.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width/5)
        }
        self.containerView.snp.makeConstraints {
            $0.top.equalTo(self.contentTitleLabel).offset(-15)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(25)
        }
        
        self.contentTitleLabel.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(40)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(self.handImageView.snp.leading)
            $0.bottom.equalTo(self.confirmationButton.snp.top).offset(-20)
        }
        self.confirmationButton.snp.remakeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(38)
            $0.bottom.equalToSuperview().inset(20)
        }
        
        if let image = requestValue.image {
            self.contentImageView.image = image
            self.containerView.addSubview(self.contentImageView)
            self.contentImageView.snp.makeConstraints {
                $0.width.equalToSuperview().multipliedBy(0.6)
                $0.centerX.equalToSuperview()
                $0.bottom.equalTo(self.confirmationButton.snp.top).offset(-10)
                $0.height.equalTo(self.contentImageView.snp.width).multipliedBy(0.7)
            }
            self.contentTitleLabel.snp.remakeConstraints {
                $0.height.lessThanOrEqualTo(40)
                $0.leading.equalToSuperview().inset(20)
                $0.trailing.equalTo(self.handImageView.snp.leading)
                $0.bottom.equalTo(self.contentImageView.snp.top).offset(-10)
            }
            
            self.containerView.setNeedsLayout()
            self.containerView.layoutIfNeeded()
        }
        
        self.snp.makeConstraints {
            $0.top.equalTo(self.containerView)
        }
        
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    @objc
    func onConfirmationButtonDidTap(_ sender: UIButton) {
        guard let action = self.confirmationButtonAction else {
            SwiftMessages.hide(id: self.id)
            return
        }
        action()
    }
    
}
