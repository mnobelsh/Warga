//
//  CitizenshipDashboardCollectionView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 23/10/21.
//

import UIKit

public final class CitizenshipDashboardCollectionView: UICollectionView {
    
    public enum Section: CaseIterable {
        case ongoingApplication
        case serviceMenu
    }

    var sections: [Section] = Section.allCases
    
    init (frame: CGRect) {
        super.init(
            frame: frame,
            collectionViewLayout: CitizenshipDashboardCollectionView.makeCompositionalLayout(with: self.sections)
        )
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bounces = true
        self.register(CitizenshipServiceCollectionCell.self, forCellWithReuseIdentifier: CitizenshipServiceCollectionCell.reuseIdentifier)
        self.register(CitizenshipHeaderCollectionCell.self, forCellWithReuseIdentifier: CitizenshipHeaderCollectionCell.reuseIdentifier)
        self.register(SectionTitleView.self, forSupplementaryViewOfKind: SectionTitleView.elementKind, withReuseIdentifier: SectionTitleView.reuseIdentifier)
        self.contentInsetAdjustmentBehavior = .never
        let refreshControl =  UIRefreshControl()
        refreshControl.tintColor = .primaryPurple
        self.refreshControl = refreshControl
        self.configureSkeletonable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

public extension CitizenshipDashboardCollectionView {
    
    static func makeCompositionalLayout(with sections: [Section]) -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, env in
            switch sections[sectionIndex] {
            case .serviceMenu:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150)))
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150)),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 6
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(35)), elementKind: SectionTitleView.elementKind, alignment: .topLeading)
                header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
                section.boundarySupplementaryItems = [header]
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 15, trailing: 0)
                return section
            case .ongoingApplication:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150)))
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150)),
                    subitem: item,
                    count: 1
                )
                let section = NSCollectionLayoutSection(group: group)
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(35)), elementKind: SectionTitleView.elementKind, alignment: .topLeading)
                header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
                section.boundarySupplementaryItems = [header]
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0)
                return section
            }
        }
    }
    
}
