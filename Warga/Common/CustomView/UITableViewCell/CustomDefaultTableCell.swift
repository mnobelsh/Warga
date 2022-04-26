//
//  CustomDefaultTableCell.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 29/10/21.
//

import UIKit
import MapKit

public final class CustomDefaultTableCell: UITableViewCell {

    static let reuseIdentifier = String(describing: CustomDefaultTableCell.self)
    
    static let estimatedHeight: CGFloat = UIScreen.main.bounds.width/5
    
    // MARK: - SubViews
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: .locationIsometric)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .heading3.withSize(16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .body1.withSize(14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .border
        view.dropShadow(color: .lightGray, offset: CGSize(width: 0, height: 0), radius: 1, opacity: 0.3)
        return view
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cellDidInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.addressLabel.text = nil
    }
    
    public func configureCell(icon: UIImage, title: String?, subtitle: String?) {
        self.iconImageView.image = icon
        self.titleLabel.text = title
        self.addressLabel.text = subtitle
    }
    
}

private extension CustomDefaultTableCell {
    
    func cellDidInit() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.addressLabel)
        self.contentView.addSubview(self.separatorView)
        
        self.iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(self.iconImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(24)
        }
        self.addressLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalTo(self.titleLabel)
            $0.bottom.equalTo(self.separatorView.snp.top).offset(-10)
        }
        self.separatorView.snp.makeConstraints {
            $0.leading.equalTo(self.titleLabel)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0.75)
        }
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
}
