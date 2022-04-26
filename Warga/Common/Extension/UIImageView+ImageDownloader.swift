//
//  UIImageView+ImageDownloader.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 17/10/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    public func downloadImage(from source: String, progressBlock: DownloadProgressBlock? = nil, completion: ((Result<KFCrossPlatformImage?, KingfisherError>) -> Void)? = nil) {
        let options: KingfisherOptionsInfo = [
            .transition(.fade(0.3)),
            .fromMemoryCacheOrRefresh,
            .cacheOriginalImage
        ]
        if ImageCache.default.isCached(forKey: source) {
            ImageCache.default.retrieveImage(forKey: source) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let imageResult):
                    self.image = imageResult.image
                    completion?(.success(imageResult.image))
                case .failure(let error):
                    self.image = .brokenImage
                    completion?(.failure(error))
                }
            }
        } else {
            guard let url = URL(string: source) else {
                let error = KingfisherError.requestError(reason: .invalidURL(request: URLRequest(url: URL(string: source)!)))
                completion?(.failure(error))
                return
            }
            self.kf.setImage(with: url, options: options, progressBlock: progressBlock) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let imageResult):
                    self.image = imageResult.image
                    completion?(.success(imageResult.image))
                case .failure(let error):
                    self.image = .brokenImage
                    completion?(.failure(error))
                }
            }
        }
    }
    
}
