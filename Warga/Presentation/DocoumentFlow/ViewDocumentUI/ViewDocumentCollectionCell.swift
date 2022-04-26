//
//  ViewDocumentCollectionCell.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//

import UIKit

public class ViewDocumentCollectionCell: UICollectionViewCell {
    
    public static let reuseIdentifier = String(describing: ViewDocumentCollectionCell.self)
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    public lazy var documentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .systemGray5
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.documentImageView)
        self.titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(20)
        }
        self.documentImageView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.leading.bottom.trailing.equalToSuperview().inset(25)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with document: DocumentDTO) {
        self.titleLabel.text = document.file_name
        guard let data = Data(base64Encoded: document.base64EncodedString ?? ""), let image = UIImage(data: data) else { return }
        self.documentImageView.image = image
    }

    
}
