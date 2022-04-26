//
//  RequestDocumentTableCell.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//

import UIKit

public protocol RequestDocumentTableCellDelegate: AnyObject {
    func cellDidTap(uploadDocumentButton button: UIButton, forDocument: DocumentRequiredDomain)
}

public final class RequestDocumentTableCell: UITableViewCell {

    public static let reuseIdentifier = String(describing: RequestDocumentTableCell.self)
    
    weak var delegate: RequestDocumentTableCellDelegate?
    var document: DocumentRequiredDomain?
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryPurple
        label.font = .latoBold(withSize: 16)
        label.numberOfLines = 0
        return label
    }()
    public lazy var completeLabel: UILabel = {
        let label = UILabel()
        label.text = "Dokumen lengkap"
        label.textColor = .primaryPurple
        label.font = .latoBold(withSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    public lazy var uploadDocumentButton: UIButton = .roundedFilledButton(title: "Pindai Dokumen", color: .primaryPurple)
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.dropShadow(color: .darkGray, offset: CGSize(width: 2, height: 2), radius: 3, opacity: 0.35)
        view.addSubview(self.titleLabel)
        view.addSubview(self.completeLabel)
        view.addSubview(self.uploadDocumentButton)
        return view
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.addSubview(self.containerView)
        self.uploadDocumentButton.titleLabel?.font = .latoBold(withSize: 12)
        self.uploadDocumentButton.addTarget(self, action: #selector(self.onUploadDocumentButtonDidTap(_:)), for: .touchUpInside)
        
        self.containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.bottom.equalToSuperview().inset(16).priority(999)
            make.trailing.equalToSuperview().inset(120)
        }
        self.completeLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.titleLabel).priority(999)
            make.leading.equalTo(self.titleLabel.snp.trailing).offset(10).priority(999)
            make.trailing.equalToSuperview().inset(10)
        }
        self.uploadDocumentButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.titleLabel).priority(999)
            make.leading.equalTo(self.titleLabel.snp.trailing).offset(10).priority(999)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with document: DocumentRequiredDomain) {
        self.document = document
        self.titleLabel.text = document.type.title

        self.completeLabel.isHidden = !document.isUserOwned
        self.uploadDocumentButton.isHidden = document.isUserOwned
        
        self.containerView.backgroundColor = document.isUserOwned ? .primaryGreen.withAlphaComponent(0.65) : .systemGray4
    }
    
    @objc
    func onUploadDocumentButtonDidTap(_ sender: UIButton) {
        guard let document = self.document else { return }
        self.delegate?.cellDidTap(uploadDocumentButton: sender, forDocument: document)
    }
    
}
