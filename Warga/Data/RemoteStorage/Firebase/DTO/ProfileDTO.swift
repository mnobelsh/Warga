//
//  ProfileDTO.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/09/21.
//

import Foundation

public struct ProfileDTO: Codable {
    
    static let id = "id"
    static let idKeluarga = "id_keluarga"
    static let nik = "nik"
    static let namaLengkap = "nama_lengkap"
    static let nomorTelepon = "nomor_telepon"
    static let dokumen = "dokumen"
    static let fotoProfil = "foto_profil"
    static let alamat = "alamat"
    static let tanggalLahir = "tanggal_lahir"
    static let email = "email"
    
    var id: String
    var email: String
    var nik: String
    var nama_lengkap: String
    var foto_profil: String?
    var alamat: AddressDTO
    var dokumen: [DocumentDTO]

}


public extension ProfileDTO {
    
    func synchronize(with profile: ProfileDTO) -> ProfileDTO {
        var updatedProfile = self
        guard updatedProfile.id == profile.id else {
            return profile
        }
        updatedProfile.alamat = profile.alamat
        updatedProfile.email = profile.email
        updatedProfile.dokumen = profile.dokumen
        updatedProfile.foto_profil = profile.foto_profil
        updatedProfile.nama_lengkap = profile.nama_lengkap
        updatedProfile.nik = profile.nik
        return updatedProfile
    }
    
    
}

