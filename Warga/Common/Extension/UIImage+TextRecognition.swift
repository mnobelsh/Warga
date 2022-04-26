//
//  UIImage+TextRecognition.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/09/21.
//

import UIKit
import Vision

// MARK: - UIImage + Text Recognition
public extension UIImage {
    
    func recognizeText(completion: @escaping(_ text: [String]) -> Void) {
        guard let cgImage = self.cgImage else { return }
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNRecognizeTextRequest { request, error in
            guard error == nil else {
                completion([])
                return
            }
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            let text = observations.compactMap { $0.topCandidates(1).first?.string }
            completion(text)
        }
        request.recognitionLanguages = ["id"]
        do {
            try requestHandler.perform([request])
        } catch {
            completion([])
        }
    }
    
}
