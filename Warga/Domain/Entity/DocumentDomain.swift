//
//  DocumentDomain.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 06/02/22.
//

import Foundation
import UIKit

public struct DocumentDomain {
    
    public static let documentsService: [DocumentDomain] = [
        DocumentDomain(
            id: DocumentType.ktp.id,
            title: DocumentType.ktp.title,
            description: "Kartu Tanda Penduduk (KTP) adalah identitas resmi penduduk sebagai bukti diri yang diterbitkan oleh Kementerian Dalam Negeri yang berlaku di seluruh wilayah Negara Kesatuan Republik Indonesia.",
            steps: ["1. Penerbitan KTP-el baru Bagi Pemula (17 tahun) :\na. Fotokopi KK\nb. Fotokopi Akta Kelahiran\n Bagi Pemula (dibawah 17 tahun dan sudah menikah) :\na. KK asli\nb. Fotokopi Surat Nikah/Akta Perkawinan",  "2. Penerbitan KTP-el bagi pendatang dalam dan luar daerah: Diberikan bersamaan dalam proses penerbitan Kartu Keluarga (KK). Adapun proses penerbitan KK baru karena pindah domisili bisa dilihat di tautan ini.", "3. Penerbitan KTP-el karena perubahan Biodata:\na. KK dan KTP Asli\nb. Dokumen pendukung perubahan biodata (FC Surat Nikah/Akta Kematian/Akta Perceraian Akta Kelahiran /ijazah/ Penetapan Pengadilan/Surat Keterangan Pindah Agama)", "4. Penerbitan KTP-el karena hilang atau rusak:\na. Surat Keterangan hilang dari kepolisian\nb. KTP-el yang rusak\nc. Fotokopi KK"],
            image: UIImage(named: "ktp_image"),
            requiredDocuments: [
                .init(type: .kartuKeluarga, isUserOwned: false),
                .init(type: .pengantarRT, isUserOwned: false),
                .init(type: .pengantarRW, isUserOwned: false),
                .init(type: .suratKetPindah, isUserOwned: false),
            ]
        ),
        DocumentDomain(
            id: DocumentType.kartuKeluarga.id,
            title: DocumentType.kartuKeluarga.title,
            description: "Kartu Keluarga adalah Kartu Identitas Keluarga yang memuat data tentang nama, susunan, dan hubungan dalam keluarga serta identitas anggota keluarganya. Setiap Kartu Keluarga memiliki nomor seri yang akan tetap berlaku selama tidak terjadi perubahan Kepala Keluarga.",
            steps: ["1. Buka situs https://alpukat-dukcapil.jakarta.go.id/ atau mengunduh aplikasi Alpukat Betawi.","2. Jika sudah mengunduh aplikasi, lakukan registrasi.","3. Isi nama lengkap, NIK, tempat, tanggal, bulan, tahun lahir, hingga nomor telepon.","4. Jika sudah terdaftar, login menggunakan NIK dan kata sandi.","5. Setelah login, pilih pembuatan KK.","6. Isi formulir pembuatan serta unggah persyaratan yang diminta.","7. Setelah pengajuan diproses, tunggu pengambilan dokumen."],
            image: UIImage(named: "kk_image"),
            requiredDocuments: [
                .init(type: .pengantarRT, isUserOwned: false),
                .init(type: .pengantarRW, isUserOwned: false),
                .init(type: .suratKetPindah, isUserOwned: false),
                .init(type: .aktaNikah, isUserOwned: false),
            ]
        ),
        DocumentDomain(
            id: DocumentType.skck.id,
            title: DocumentType.skck.title,
            description: "SKCK adalah surat keterangan catatan kepolisian, berisi keterangan resmi yang diterbitkan oleh Kepolisian Republik Indonesia (Polri), sebagai bukti penting bahwa orang yang bersangkutan berperilaku baik atau tidak pernah melakukan tindak kejahatan kriminal. ... Kebanyakan SKCK digunakan untuk syarat mendaftar menjai CPNS.",
            steps: [
                    "Syarat pembuatan SKCK baru :\n1. Membawa Surat Pengantar dari Kantor Kelurahan tempat domisili pemohon.",
                    "2. Membawa fotocopy KTP/SIM sesuai dengan domisili yang tertera di surat pengantar dari Kantor Kelurahan.",
                    "3. Membawa fotocopy Kartu Keluarga.",
                    "4. Membawa fotocopy Akta Kelahiran/Kenal Lahir.",
                    "5. Membawa Pas Foto terbaru dan berwarna ukuran 4×6 sebanyak 6 lembar (latar belakang merah).",
                    "6. Mengisi Formulir Daftar Riwayat Hidup yang telah disediakan di kantor Polisi dengan jelas dan benar.",
                    "7. Pengambilan Sidik Jari oleh petugas.",
                    "------------------------------",
                    "Persyaratan membuat SKCK perpanjang :\n1. Membawa lembar SKCK lama yang asli/legalisir (maksimal telah habis masanya selama 1 tahun).",
                    "2. Membawa fotocopy KTP/SIM. Membawa fotocopy Kartu Keluarga.",
                    "3. Membawa fotocopy Akta Kelahiran/Kenal Lahir.",
                    "4. Membawa Pas Foto terbaru yang berwarna ukuran 4×6 sebanyak 3 lembar.",
                    "5. Mengisi formulir perpanjangan SKCK yang disediakan di kantor Polisi.",],
            image: UIImage(named: "skck_image"),
            requiredDocuments: [
                .init(type: .kartuKeluarga, isUserOwned: false),
                .init(type: .ktp, isUserOwned: false),
            ]
        ),
        DocumentDomain(
                id: DocumentType.aktaLahir.id,
                title: DocumentType.aktaLahir.title,
                description: "Akta kelahiran adalah suatu dokumen identitas autentik yang wajib dimiliki setiap warga negara Indonesia. Dokumen ini sebagai bukti sah terkait status dan peristiwa kelahiran seseorang dan termasuk hak setiap anak Indonesia.",
                steps: [
                    "1. Fotokopi KK",
                    "2. Fotokopi KTP-el orang tua (suami istri)",
                    "3. Surat Keterangan Kelahiran dari Rumah Sakit/Klinik Bersalin/Bidan Praktek (Asli)",
                    "4. Fotokopi Surat Nikah/Kutipan Akta Perkawinan yang sudah dilegalisir",
                    "5. Fotokopi KTP-el 2 (dua) orang saksi",
                    "6. Melampirkan Foto copy ijazah dan foto copy surat nikah yang bersangkutan (untuk akta kelahiran dewasa)",
                    "7. Persetujuan Kepala Dinas apabila kelahiran melebihi batas waktu berdasarkan peraturan yang berlaku",
                    "8. Mengisi formulir permohonan",
                ],
                image: UIImage(named: "akta_lahir"),
                requiredDocuments: [
                    .init(type: .kartuKeluarga, isUserOwned: false),
                    .init(type: .ktp, isUserOwned: false),
                    .init(type: .suratKetLahir, isUserOwned: false),
                    .init(type: .aktaNikah, isUserOwned: false),
                ]
        )
    ]
    
    var id: String
    var title: String
    var description: String
    var steps: [String]
    var image: UIImage?
    var requiredDocuments: [DocumentRequiredDomain]
    
}

public class DocumentRequiredDomain {
    var type: DocumentType
    var isUserOwned: Bool
    var base64EncodedContent: String?
    
    init(type: DocumentType, isUserOwned: Bool, base64EncodedContent: String? = nil) {
        self.type = type
        self.isUserOwned = isUserOwned
        self.base64EncodedContent = base64EncodedContent
    }
}


public struct RequestDocumentDTO: Codable {
    
    static let document_id = "document_id"
    static let profile_id = "profile_id"
    static let status = "status"

    var documentId: String
    var profileId: String
    var status: String
    
}


public enum RequestDocumentStatus: String {
    case requested = "REQUESTED",
    rejected = "REJECTED",
    completed = "COMPLETED"
}
