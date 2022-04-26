//
//  FormTextFieldCell.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 12/09/21.
//

import UIKit
import SnapKit

public class FormTextFieldItem {
    
    public enum RightIconType {
        case chevronDown
    }
    
    var title: String = ""
    var value: String?
    var isValid: Bool = false
    var keyboardType: UIKeyboardType = .default
    var supplementaryText: String?
    var rightIcon: RightIconType? = nil
    var secureTextEntry: Bool = false
    var onFinish: ((_ cell: FormTextFieldCell,_ item: FormTextFieldItem) -> Void)?
    var onEditing: ((_ cell: FormTextFieldCell,_ item: FormTextFieldItem) -> Void)?
}

public class FormTextFieldCell: UITableViewCell {
    
    static let estimatedHeight: CGFloat = 100

    static let reuseIdentifier = String(describing: FormTextFieldCell.self)
    
    var item: FormTextFieldItem?
    
    // MARK: - SubViews
    lazy var supplementaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .body3
        label.textColor = .systemRed
        label.alpha = 0
        return label
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = .heading3.withSize(14)
        return label
    }()
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = .body2
        textField.delegate = self
        return textField
    }()
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.border.cgColor
        
        view.addSubview(self.titleLabel)
        view.addSubview(self.textField)
        view.addSubview(self.rightIconImageView)

        self.rightIconImageView.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        return view
    }()
    lazy var rightIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.isHidden = true
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onRightIconDidTap(_:)))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cellDidInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureFilledFormUI() {
        self.titleLabel.snp.remakeConstraints {
            $0.top.trailing.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().offset(10)
        }
        self.textField.snp.remakeConstraints {
            $0.trailing.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalTo(35)
            $0.bottom.equalToSuperview().inset(5)
        }
        if let rightIcon = self.item?.rightIcon {
            switch rightIcon {
            case .chevronDown:
                self.textField.snp.updateConstraints {
                    $0.trailing.equalToSuperview().inset(55)
                }
            }
        }
    }
    
    private func configureEmptyFormUI() {
        self.titleLabel.snp.remakeConstraints {
            $0.top.trailing.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalTo(0)
        }
        self.textField.snp.remakeConstraints {
            $0.trailing.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalTo(35)
            $0.centerY.equalToSuperview()
        }
        if let rightIcon = self.item?.rightIcon {
            switch rightIcon {
            case .chevronDown:
                self.textField.snp.updateConstraints {
                    $0.trailing.equalToSuperview().inset(55)
                }
            }
        }
    }
    
    private func configureSupplementaryLabel() {
        guard let item = self.item else { return }
        self.supplementaryLabel.text = item.supplementaryText
        if !item.isValid && self.item?.value != nil  {
            UIView.animate(withDuration: 0.15) {
                self.supplementaryLabel.alpha = 1
                self.containerView.layer.borderColor = UIColor.softRed.cgColor
            }
        } else {
            UIView.animate(withDuration: 0.15) {
                self.supplementaryLabel.alpha = 0
                self.containerView.layer.borderColor = UIColor.border.cgColor
            }
        }
    }
    
    public func fill(with item: FormTextFieldItem) {
        self.item = item
        
        self.textField.isSecureTextEntry = item.secureTextEntry
        self.textField.text = item.value
        self.textField.keyboardType = item.keyboardType
        self.titleLabel.text = item.title
        self.textField.attributedPlaceholder =  NSAttributedString(
            string: item.title,
            attributes: [.font: UIFont.body2, .foregroundColor: UIColor.lightGray]
        )
        if let value = item.value, !value.isEmpty {
            self.configureFilledFormUI()
        } else {
            self.configureEmptyFormUI()
        }
        
        self.rightIconImageView.isHidden = true
        if let rightIcon = item.rightIcon {
            switch rightIcon {
            case .chevronDown:
                self.rightIconImageView.image = .chevronDown.withTintColor(.primaryPurple)
                self.rightIconImageView.isHidden = false
            }
        }
        
        self.configureSupplementaryLabel()
    }
    
}

private extension FormTextFieldCell {
    
    func cellDidInit() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.addSubview(self.containerView)
        self.contentView.addSubview(self.supplementaryLabel)
        
        self.containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(60)
        }
        self.supplementaryLabel.snp.makeConstraints {
            $0.top.equalTo(self.containerView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(15)
            $0.height.equalTo(14)
        }
    }
    
    @objc
    func onRightIconDidTap(_ sender: UITapGestureRecognizer) {
        if let rightIcon = self.item?.rightIcon {
            switch rightIcon {
            case .chevronDown:
                self.textField.becomeFirstResponder()
            }
        } else {
            
        }
    }
    
}

extension FormTextFieldCell: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
       
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text, currentText.isEmpty && string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        UIView.animate(withDuration: 0.2) {
            self.configureFilledFormUI()
            self.contentView.setNeedsLayout()
            self.contentView.layoutIfNeeded()
        }
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            UIView.animate(withDuration: 0.2) {
                self.configureEmptyFormUI()
                self.contentView.setNeedsLayout()
                self.contentView.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.configureFilledFormUI()
                self.contentView.setNeedsLayout()
                self.contentView.layoutIfNeeded()
            }
        }
        guard let item = self.item else { return }
        item.value = textField.text
        self.item?.onFinish?(self,item)
    }
    
}
