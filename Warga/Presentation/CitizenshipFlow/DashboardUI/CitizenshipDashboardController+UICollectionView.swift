//
//  CitizenshipDashboardController+UICollectionView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 24/10/21.
//

import UIKit
import ChameleonFramework

extension CitizenshipDashboardController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self._view.collectionView.sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self._view.collectionView.sections[section] {
        case .ongoingApplication:
            return 1
        default:
            return DocumentDomain.documentsService.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self._view.collectionView.sections[indexPath.section] {
        case .serviceMenu:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CitizenshipServiceCollectionCell.reuseIdentifier, for: indexPath) as? CitizenshipServiceCollectionCell else { return UICollectionViewCell() }
            cell.titleLabel.text = DocumentDomain.documentsService[indexPath.row].title
            cell.descriptionLabel.text = DocumentDomain.documentsService[indexPath.row].description.prefix(100) + "..."
            return cell
        case .ongoingApplication:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CitizenshipHeaderCollectionCell.reuseIdentifier, for: indexPath) as? CitizenshipHeaderCollectionCell else { return UICollectionViewCell() }
            if let doc = self.ongoingDocument {
                cell.configureCell(requestDocument: doc)
            } else {
                cell.configureEmptyCell()
            }
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionTitleView.reuseIdentifier, for: indexPath) as? SectionTitleView else { return UICollectionReusableView() }
        switch self._view.collectionView.sections[indexPath.section] {
        case .ongoingApplication:
            headerView.titleLabel.text = "Status Pengajuan"
        case .serviceMenu:
            headerView.titleLabel.text = "Dokumen Kependudukan dan Sipil"
        }
        return headerView
    }
    
    
}


extension CitizenshipDashboardController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let document = DocumentDomain.documentsService[indexPath.row]
        self.viewModel.showDocumentDetailUI(selectedDocument: document)
    }
    
}
