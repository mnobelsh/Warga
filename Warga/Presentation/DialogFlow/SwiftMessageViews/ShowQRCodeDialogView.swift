//
//  ShowQRCodeDialogView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 29/10/21.
//

import UIKit
import SwiftMessages

public struct ShowQRCodeDialogViewRequestValue {
    
    var id: String = UUID().uuidString
    var code: String
    
}

public final class ShowQRCodeDialogView: MessageView {
    
    // MARK: - SubViews
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.dropShadow(color: .lightGray, offset: CGSize(width: 0, height: 0), radius: 10, opacity: 0.35)
        
        view.addSubview(self.customTitleLabel)
        view.addSubview(self.qrCodeImageView)
        view.addSubview(self.descriptionLabel)
        return view
    }()
    lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .heading3
        label.textColor = .primaryPurple
        label.numberOfLines = 0
        label.text = "Pindai kode QR dibawah ini untuk mendaftarkan anggota keluarga anda."
        return label
    }()
    lazy var qrCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .body2.withSize(14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = "Dengan memindai kode QR diatas maka pengguna secara otomatis akan terdaftar sebagai anggota keluarga anda."
        return label
    }()
    
    public init(requestValue: ShowQRCodeDialogViewRequestValue) {
        super.init(frame: UIScreen.main.bounds)
        self.viewDidInit(with: requestValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ShowQRCodeDialogView {
    
    func viewDidInit(with requestValue: ShowQRCodeDialogViewRequestValue) {
        self.configureSubviews()
        self.id = requestValue.id
        self.qrCodeImageView.image = requestValue.code.generateQRCode()
        self.backgroundColor = .primaryPurple
    }
    
    func configureSubviews() {
        self.addSubview(self.containerView)
        
        self.customTitleLabel.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview().inset(15)
        }
        self.qrCodeImageView.snp.makeConstraints {
            $0.top.equalTo(self.customTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(self.customTitleLabel).inset(30)
            $0.height.equalTo(self.qrCodeImageView.snp.width)
        }
        self.descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(self.qrCodeImageView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(self.customTitleLabel)
        }
        
        self.containerView.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width/1.5)
            $0.center.equalToSuperview()
            $0.bottom.equalTo(self.descriptionLabel).offset(20)
        }
    }
    
}
