//
//  SPPermissionsTableViewCell.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 21/10/21.
//

import SPPermissions

public extension SPPermissionsTableViewCell {
    
    func configureCell(forPermission permission: SPPermissions.Permission) {
        self.permissionButton.allowTitle = "Izinkan"
        self.permissionButton.allowedTitle = "Diizinkan"
        switch permission {
        case .camera:
            self.permissionTitleLabel.text = "Kamera"
            self.permissionDescriptionLabel.text = "Dibutuhkan dalam pemindaian dokumen dan data terkait."
        case .locationWhenInUse:
            self.permissionTitleLabel.text = "Lokasi"
            self.permissionDescriptionLabel.text = "Dibutuhkan dalam fitur yang berkaitan dengan lokasi anda seperti informasi cuaca, aktivitas lingkungan, dan lain sebagainya."
        case .notification:
            self.permissionTitleLabel.text = "Notifikasi"
            self.permissionDescriptionLabel.text = "Untuk mendapatkan informasi terkini melalui notifikasi."
        case .photoLibrary:
            self.permissionTitleLabel.text = "Galeri Penyimpanan"
            self.permissionDescriptionLabel.text = "Untuk mengunduh dan mengunggah dokumen yang tersimpan pada perangkat anda."
        default:
            break
        }
    }
    
}

