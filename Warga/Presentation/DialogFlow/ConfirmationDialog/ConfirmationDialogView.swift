//
//  ConfirmationDialogView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 18/12/21.
//

import UIKit
import SwiftMessages

public struct ConfirmationDialogRequestValue {
    var id: String = UUID().uuidString
    var title: String = " "
    var content: String = ""
    var confirmButtonAction: (() -> Void)?
}

public class ConfirmationDialogView: MessageView {
    
    public lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .heading3
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    public lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .body1
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    public lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(self.onCancelButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    public lazy var cancelButton: UIButton = .roundedStrokedButton(title: "Batal", color: .softRed)
    public lazy var confirmButton: UIButton = .roundedFilledButton(title: "Ya", color: .primaryPurple)
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.cancelButton,self.confirmButton])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    private var confirmAction: (() -> Void)?
    private lazy var navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(self.customTitleLabel)
        view.addSubview(self.closeButton)
        view.dropShadow(color: .lightGray, offset: CGSize(width: 0, height: 0), radius: 3, opacity: 0.35)
        
        self.closeButton.snp.makeConstraints {
            $0.height.width.equalTo(25)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
        self.customTitleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(16).priority(999)
            $0.trailing.lessThanOrEqualTo(self.closeButton.snp.leading).offset(-5).priority(999)
        }
        return view
    }()
    
    init(requestValue: ConfirmationDialogRequestValue) {
        super.init(frame: UIScreen.main.bounds)
        self.id = requestValue.id
        self.confirmAction = requestValue.confirmButtonAction
        self.customTitleLabel.text = requestValue.title
        self.contentLabel.text = requestValue.content
        self.cancelButton.addTarget(self, action: #selector(self.onCancelButtonTapped(_:)), for: .touchUpInside)
        self.confirmButton.addTarget(self, action: #selector(self.onConfirmButtonTapped(_:)), for: .touchUpInside)
        
        
        self.backgroundColor = .white
        
        self.addSubview(self.navigationView)
        self.addSubview(self.contentLabel)
        self.addSubview(self.buttonStackView)
        
        self.navigationView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
        self.contentLabel.snp.makeConstraints {
            $0.top.equalTo(self.navigationView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.buttonStackView.snp.top).offset(-20)
        }
        self.buttonStackView.snp.makeConstraints {
            $0.height.equalTo(48).priority(999)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func onCancelButtonTapped(_ sender: UIButton) {
        SwiftMessages.hide(id: self.id)
    }
    
    @objc
    private func onConfirmButtonTapped(_ sender: UIButton) {
        self.confirmAction?()
        SwiftMessages.hide(id: self.id)
    }
    
}
