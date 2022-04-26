//
//  OTPVerificationController+UITextFieldDelegate.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 22/09/21.
//

import UIKit

extension OTPVerificationController: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let numberString = string.rangeOfCharacter(from: .decimalDigits), !numberString.isEmpty {
            textField.text = string
            self._view.showContainerFieldBorder(for: textField)
            self.moveToNextResponder(from: textField)
        } else {
            textField.text = nil
            self._view.hideContainerFieldBorder(for: textField)
            self.moveToPreviousResponder(from: textField)
        }
        
        let currentText = textField.text ?? ""
        if let newTextRange = Range(range, in: currentText) {
            let newText = currentText.replacingCharacters(in: newTextRange, with: string)
            return newText.count <= 1
        }
        return false
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    private func moveToNextResponder(from textField: UITextField) {
        if textField.tag != 106 {
            guard let nextTextField = self._view.asView.viewWithTag(textField.tag+1) as? UITextField else { return }
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
    
    private func moveToPreviousResponder(from textField: UITextField) {        if textField.tag != 101 {
            guard let previousTextField = self._view.asView.viewWithTag(textField.tag-1) as? UITextField else { return }
            previousTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
    
}
