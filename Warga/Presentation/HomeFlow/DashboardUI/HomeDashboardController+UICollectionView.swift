//
//  HomeDashboardController+UICollectionView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//

import UIKit
import SkeletonView

extension HomeDashboardController: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self._view.collectionView.sections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self._view.collectionView.sections[section] {
        case .header:
            return 1
        case .infoTerkini:
            return 2
        case .covid19:
            return 4
        case .berita:
            return self.displayedNews.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self._view.collectionView.sections[indexPath.section] {
        case .header:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionCell.reuseIdentifier, for: indexPath) as? HeaderCollectionCell else { return UICollectionViewCell() }
            if let currentForecast = self.displayedCurrentForecast {
                cell.configureCurrentForecast(currentForecast)
            }
            cell.configureHourlyForecasts(self.displayedHourlyForecasts)
            cell.configureCellByResponse(self.response)
            return cell
        case .infoTerkini:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionCell.reuseIdentifier, for: indexPath) as? BannerCollectionCell else { return UICollectionViewCell() }
            if indexPath.row == 0 {
                cell.configureCell(bannerImage: UIImage(named: "pendaftaran-vaksin") ?? .appIcon)
            } else {
                cell.configureCell(bannerImage: UIImage(named: "3m") ?? .appIcon)
            }
            return cell
        case .covid19:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionCell.reuseIdentifier, for: indexPath) as? CardCollectionCell else { return UICollectionViewCell() }
            cell.configureCell(with: self.covidMenu[indexPath.row])
            return cell
        case .berita:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionCell.reuseIdentifier, for: indexPath) as? NewsCollectionCell else { return UICollectionViewCell() }
            cell.configureCellByResponse(self.response)
            if !self.displayedNews.isEmpty {
                cell.configureCell(with: self.displayedNews[indexPath.row])
            }
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionTitleView.reuseIdentifier, for: indexPath) as? SectionTitleView else { return UICollectionReusableView() }
            headerView.isSkeletonable = false
            switch self._view.collectionView.sections[indexPath.section] {
            case .infoTerkini:
                headerView.configureView(title: "Info Terkini", titleIcon: .jakiIcon)
            case .covid19:
                headerView.configureView(title: "Warga Tanggap Covid-19", titleIcon: .jakiIcon)
            case .berita:
                headerView.configureView(title: "Berita Warga")
            default:
                break
            }
            return headerView
        case UICollectionView.elementKindSectionFooter:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionPageControlView.reuseIdentifier, for: indexPath) as? SectionPageControlView else { return UICollectionReusableView() }
            footerView.pageControl.pageCount = self.displayedNews.count
            return footerView
        default:
            return UICollectionReusableView()
        }
    }
    
}

extension HomeDashboardController: UICollectionViewDelegate {
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        switch self._view.collectionView.sections[indexPath.section] {
        case .infoTerkini:
            break
        case .covid19:
            self.viewModel.didSelect(self.covidMenu[index])
        case .berita:
            self.viewModel.didSelect(self.displayedNews[index])
        default:
            break
        }
    }
    
}


// MARK: - Skeleton View

extension HomeDashboardController: SkeletonCollectionViewDataSource {

    public func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return self._view.collectionView.sections.count
    }

    public func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self._view.collectionView.sections[section] {
        case .covid19:
            return 4
        default:
            return 1
        }
    }

    public func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch self._view.collectionView.sections[indexPath.section] {
        case .header:
            return HeaderCollectionCell.reuseIdentifier
        case .covid19:
            return CardCollectionCell.reuseIdentifier
        case .berita:
            return NewsCollectionCell.reuseIdentifier
        default:
            return BannerCollectionCell.reuseIdentifier
        }
    }

    public func collectionSkeletonView(_ skeletonView: UICollectionView, supplementaryViewIdentifierOfKind: String, at indexPath: IndexPath) -> ReusableCellIdentifier? {
        switch supplementaryViewIdentifierOfKind {
        case UICollectionView.elementKindSectionHeader:
            return SectionTitleView.reuseIdentifier
        default:
            return nil
        }
    }

}

extension HomeDashboardController: HomeDashboardCollectionViewDelegate {
    
    public func collectionViewSection(_ section: HomeDashboardCollectionView.Section, scrollTo index: Int, progress: CGFloat) {
        guard let footerView = self._view.collectionView.visibleSupplementaryViews(ofKind: SectionPageControlView.elementKind).first as? SectionPageControlView else { return }
        footerView.pageControl.progress = progress
    }
    
}
