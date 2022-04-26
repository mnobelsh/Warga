//
//  String+Validation.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 21/09/21.
//

import Foundation

public extension String {
    
    func isValidEmail() -> Bool {
        guard !self.isEmpty else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidName() -> Bool {
        guard !self.isEmpty else { return false }
        let nameRegEx = "^[a-zA-Z]+(([`‘’´',. -][a-zA-Z ])?[`‘’´',. -][a-zA-Z]*)*$"
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return namePred.evaluate(with: self) && self.count > 4
    }
    
    func isValidNikNumber() -> Bool {
        guard !self.isEmpty else { return false }
        return self.first != "0" && CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self)) && self.count == 16
    }
    
    func isValidPhoneNumber() -> Bool {
        guard !self.isEmpty else { return false }
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self)) && self.count >= 10
    }
    
    func isValidPassword() -> Bool {
        guard !self.isEmpty else { return false }
        return !self.containing([.emoji,.whiteSpacesAndNewlines]) && self.containing([.upperCasedLetters,.lowerCasedLetters,.numbers]) && self.count >= 6
    }
    
    enum ValidationCharacter {
        case whiteSpacesAndNewlines
        case emoji
        case numbers
        case letters
        case lowerCasedLetters
        case upperCasedLetters
        case symbols
    }
    
    func containing(_ characters: [ValidationCharacter]) -> Bool {
        var count = 0
        characters.forEach { character in
            switch character {
            case .emoji:
                guard self.contains(where: { $0.unicodeScalars.first?.value ?? .zero > 0x238C }) else { return
                }
                count += 1
            case .lowerCasedLetters:
                guard let range = self.rangeOfCharacter(from: .lowercaseLetters), !range.isEmpty else {
                    return
                }
                count += 1
            case .upperCasedLetters:
                guard let range = self.rangeOfCharacter(from: .uppercaseLetters), !range.isEmpty else {
                    return
                }
                count += 1
            case .numbers:
                guard let range = self.rangeOfCharacter(from: .decimalDigits), !range.isEmpty else {
                    return
                }
                count += 1
            case .symbols:
                guard let range = self.rangeOfCharacter(from: .symbols), !range.isEmpty else {
                    return
                }
                count += 1
            case .whiteSpacesAndNewlines:
                guard let range = self.rangeOfCharacter(from: .whitespacesAndNewlines), !range.isEmpty else {
                    return
                }
                count += 1
            case .letters:
                guard let range = self.rangeOfCharacter(from: .letters), !range.isEmpty else {
                    return
                }
                count += 1
            }
        }
        return count == characters.count
    }
    
}
