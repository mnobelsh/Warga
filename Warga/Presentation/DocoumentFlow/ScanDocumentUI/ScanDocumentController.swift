//
//  ScanDocumentController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 23/10/21.
//  Copyright (c) 2021 All rights reserved.

import UIKit
import WeScan
import SwiftMessages

// MARK: ScanDocumentController
public final class ScanDocumentController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: Dependency Variable
    var viewModel: ScanDocumentViewModel!
    
    public lazy var scannerController: ImageScannerController = ImageScannerController()
    
    class func create(with viewModel: ScanDocumentViewModel) -> ScanDocumentController {
        let controller = ScanDocumentController()
        controller.viewModel = viewModel
        return controller
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
        self.bind(to: self.viewModel)
        self.viewModel.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViewWillAppear()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupViewDidAppear()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setupViewWillDisappear()
    }
    
}

// MARK: Private Function
private extension ScanDocumentController {
    
    func bind(to viewModel: ScanDocumentViewModel) {
    }
    
    func setupViewDidLoad() {
        self.scannerController.isModalInPresentation = true
        self.scannerController.imageScannerDelegate = self
    }
    
    func setupViewWillAppear() {
        self.present(self.scannerController, animated: false)
    }
    
    func setupViewDidAppear() {
        let id = UUID().uuidString
        let requestValue = InstructionDialogViewRequestValue(id: id, title: "Letakan dokumen pada posisi yang benar seperti gambar dibawah ini", image: UIImage(named: "id-card"), confirmationButton: (title: "Ok, saya mengerti", action: {
            SwiftMessages.hide(id: id)
        }), duration: .seconds(seconds: 10))
        self.viewModel.showInstructionDialog(requestValue: requestValue)
    }
    
    func setupViewWillDisappear() {
        self.scannerController.dismiss(animated: false)
    }
    
}

extension ScanDocumentController: ImageScannerControllerDelegate {
    
    public func imageScannerController(_ scanner: ImageScannerController, didFinishScanningWithResults results: ImageScannerResults) {
        results.croppedScan.image.recognizeText { [weak self] textGroup in
            guard let self = self else { return }
            self.viewModel.didRecognizeText(textGroup: textGroup)
        }
        guard let compressedImage = results.croppedScan.image.jpegData(compressionQuality: 0.1) else { return }
        self.viewModel.didScanDocument(pdfData: compressedImage)
//        results.croppedScan.generatePDFData { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let data):
//                self.viewModel.didScanDocument(pdfData: data)
//            case .failure(let error):
//                self.viewModel.didFailWithError(error)
//            }
//        }
        DispatchQueue.main.async {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    public func imageScannerControllerDidCancel(_ scanner: ImageScannerController) {
        DispatchQueue.main.async {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    public func imageScannerController(_ scanner: ImageScannerController, didFailWithError error: Error) {
        self.viewModel.didFailWithError(error)
    }
    
    
}
