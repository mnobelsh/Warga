//
//  CitizenshipHeaderCollectionCell.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 24/10/21.
//

import UIKit

public final class CitizenshipHeaderCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: CitizenshipHeaderCollectionCell.self)
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.dropShadow(offset: CGSize(width: 1.5, height: 1.5), radius: 3, opacity: 0.5)
        
        view.addSubview(self.titleLabel)
        view.addSubview(self.descriptionLabel)
        return view
    }()
    lazy var imageContainerView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.makeImageView(image: .cardActionIcon),
            self.makeImageView(image: .assignmentActionIcon),
            self.makeImageView(image: .descriptionActionIcon)
        ])
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .heading1.withSize(18)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .body1.withSize(16)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellDidInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(requestDocument: RequestDocumentDTO) {
        let document = DocumentDomain.documentsService.first(where: { $0.id == requestDocument.documentId })
        switch RequestDocumentStatus(rawValue: requestDocument.status) {
        case .requested:
            self.titleLabel.text = "Pengajuan \(document?.title ?? "") Dalam Proses"
            self.descriptionLabel.text = "Anda sudah mengajukan dokumen dan dokumen sedang diproses."
            self.titleLabel.textColor = .black
        case .completed:
            self.titleLabel.text = "Pengajuan \(document?.title ?? "") Selesai"
            self.descriptionLabel.text = "Pengajuan dokumen berhasil dan sudah selesai."
            self.titleLabel.textColor = .primaryGreen
        case .rejected:
            self.titleLabel.text = "Pengajuan \(document?.title ?? "") Ditolak"
            self.descriptionLabel.text = "Pengajuan dokumen sudah selesai dan ditolak."
            self.titleLabel.textColor = .systemRed
        default:
            break
        }
    }
    
    public func configureEmptyCell() {
        self.titleLabel.text = "Anda tidak memiliki pengajuan dokumen"
        self.descriptionLabel.text = "Pilih jenis dokumen dibawah ini."
        self.titleLabel.textColor = .black
        self.descriptionLabel.textColor = .darkGray
    }
    
}

private extension CitizenshipHeaderCollectionCell {
    
    func cellDidInit() {
        self.backgroundColor = .clear
        
        self.contentView.addSubview(self.containerView)
        self.contentView.addSubview(self.imageContainerView)
       
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(24)
        }
        
        self.imageContainerView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.35)
            $0.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(self.imageContainerView.snp.width).multipliedBy(0.4)
        }
        
        self.makeContainerViewConstraints()

    }
    
    func makeContainerViewConstraints() {
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.trailing.equalTo(self.descriptionLabel)
        }
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().inset(25)
        }
    }
    
    
    
    func makeImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }
    
}

