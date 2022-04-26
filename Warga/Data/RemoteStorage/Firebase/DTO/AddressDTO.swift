//
//  AddressDTO.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//

import Foundation

public struct AddressDTO: Codable {
    
    static let alamat = "alamat"
    static let rt = "rt"
    static let rw = "rw"
    static let kelurahan = "kelurahan"
    static let kecamatan = "kecamatan"
    static let kota = "kota"
    static let provinsi = "provinsi"

    
    var alamat: String
    var rt: String?
    var rw: String?
    var kelurahan: String?
    var kecamatan: String?
    var kota: String?
    var provinsi: String?
    var koordinat: CoordinateDTO?
    
}

public struct CoordinateDTO: Codable {
    var latitude: Double
    var longitude: Double
}
