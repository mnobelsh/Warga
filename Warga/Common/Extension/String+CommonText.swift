//
//  String+CommonText.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 21/09/21.
//

import Foundation

extension String {
    
    static var passwordCharactersWarning: String {
        return "Kata sandi harus terdiri dari huruf besar, alfabet dan angka."
    }
    static var emptyStringWarning: String {
        return "Harap melengkapi data berikut."
    }
    static func invalidField(_ field: String) -> String {
        return "\(field) tidak valid."
    }
    static func minimumCharacters(of field: String,_ minimumCharacters: Int) -> String {
        return "\(field) harus terdiri dari \(minimumCharacters) karakter atau lebih."
    }

    
}
