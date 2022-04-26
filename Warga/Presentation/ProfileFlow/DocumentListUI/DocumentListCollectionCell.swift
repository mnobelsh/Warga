//
//  DocumentListCollectionCell.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 07/02/22.
//

import UIKit

public final class DocumentListCollectionCell: UICollectionViewCell {
    
    public static let reuseIdentifier = String(describing: DocumentListCollectionCell.self)
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .latoBold(withSize: 20)
        label.numberOfLines = 0
        label.textColor = .primaryPurple
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.dropShadow(color: .darkGray, offset: CGSize(width: 1.5, height: 1.5), radius: 3.5, opacity: 0.35)
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with document: DocumentDTO) {
        self.titleLabel.text = document.file_name
    }
    
}
