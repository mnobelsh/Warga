//
//  DocumentDTO.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 08/10/21.
//

import Foundation

public enum DocumentType: CaseIterable {
    case ktp, kartuKeluarga, skck, pengantarRT, pengantarRW, suratKetPindah, aktaNikah, aktaLahir, suratKetLahir
    var id: String {
        switch self {
        case .ktp: return "ktp"
        case .kartuKeluarga: return "kk"
        case .skck: return "skck"
        case .pengantarRT: return "pengantar_rt"
        case .pengantarRW: return "pengantar_rw"
        case .suratKetPindah: return "keterangan_pindah"
        case .aktaNikah: return "akta_nikah"
        case .aktaLahir: return "akta_lahir"
        case .suratKetLahir: return "keterangan_lahir"
        }
    }
    var title: String {
        switch self {
        case .ktp: return "Kartu Tanda Penduduk"
        case .kartuKeluarga: return "Kartu Keluarga"
        case .skck: return "Surat Keterangan Catatan Kepolisian"
        case .pengantarRT: return "Surat Pengantar Rukun Tetangga"
        case .pengantarRW: return "Surat Pengantar Rukun Warga"
        case .suratKetPindah: return "Surat Keterangan Pindah"
        case .aktaNikah: return "Akta Pernikahan"
        case .aktaLahir: return "Akta Kelahiran"
        case .suratKetLahir: return "Surat Keterangan Lahir"
        }
    }
}

public struct DocumentDTO: Codable {

    var id: String? = nil
    var file_name: String? = nil
    var base64EncodedString: String? = nil
    
}
