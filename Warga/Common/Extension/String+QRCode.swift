//
//  String+QRCode.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 31/10/21.
//

import UIKit

fileprivate extension String {
    static let CIQRCodeGenratorName = "CIQRCodeGenerator"
    static let inputMessageKey = "inputMessage"
}


extension String {
    
    public func generateQRCode() -> UIImage? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        if let filter = CIFilter(name: .CIQRCodeGenratorName) {
            filter.setValue(data, forKey: .inputMessageKey)
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            if let outputImage = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: outputImage)
            }
            return nil
        }
        return nil
    }
    
    
}
