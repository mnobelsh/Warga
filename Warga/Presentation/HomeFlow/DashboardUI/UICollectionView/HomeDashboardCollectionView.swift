//
//  HomeDashboardCollectionView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 10/10/21.
//

import UIKit

public protocol HomeDashboardCollectionViewDelegate: AnyObject {
    func collectionViewSection(_ section: HomeDashboardCollectionView.Section, scrollTo index: Int, progress: CGFloat)
}

public final class HomeDashboardCollectionView: UICollectionView {

    public enum Section: CaseIterable {
        case header
        case infoTerkini
        case covid19
        case berita
    }
    
    weak var sectionDelegate: HomeDashboardCollectionViewDelegate?
    public var sections: [Section] = Section.allCases

    public init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.collectionViewLayout = self.makeCompositionalLayout(with: self.sections)
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bounces = true
        self.register(BannerCollectionCell.self, forCellWithReuseIdentifier: BannerCollectionCell.reuseIdentifier)
        self.register(NewsCollectionCell.self, forCellWithReuseIdentifier: NewsCollectionCell.reuseIdentifier)
        self.register(CardCollectionCell.self, forCellWithReuseIdentifier: CardCollectionCell.reuseIdentifier)
        self.register(HeaderCollectionCell.self, forCellWithReuseIdentifier: HeaderCollectionCell.reuseIdentifier)
        self.register(SectionTitleView.self, forSupplementaryViewOfKind: SectionTitleView.elementKind, withReuseIdentifier: SectionTitleView.reuseIdentifier)
        self.register(SectionPageControlView.self, forSupplementaryViewOfKind: SectionPageControlView.elementKind, withReuseIdentifier: SectionPageControlView.reuseIdentifier)
        self.contentInsetAdjustmentBehavior = .never
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        let refreshControl =  UIRefreshControl()
        refreshControl.tintColor = .primaryPurple
        self.refreshControl = refreshControl
        self.configureSkeletonable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

private extension HomeDashboardCollectionView {
    
    func makeCompositionalLayout(with sections: [Section]) -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, env in
            switch sections[sectionIndex] {
            case .header:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(UIScreen.main.bounds.width*0.5)),
                    subitem: item,
                    count: 1
                )
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0)
                return section
            case .infoTerkini:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(UIScreen.main.bounds.width*0.35)),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: SectionTitleView.elementKind, alignment: .topLeading)
                section.boundarySupplementaryItems = [header ]
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 20, trailing: 24)
                section.orthogonalScrollingBehavior = .continuous
                return section
            case .covid19:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5)),
                    subitem: item,
                    count: 2
                )
                group.interItemSpacing = .fixed(10)
                let largeGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300)),
                    subitem: group,
                    count: 2
                )
                largeGroup.interItemSpacing = .fixed(10)
                let section = NSCollectionLayoutSection(group: largeGroup)
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: SectionTitleView.elementKind, alignment: .topLeading)
                section.boundarySupplementaryItems = [header ]
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 20, trailing: 24)
                return section
            case .berita:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(UIScreen.main.bounds.width*0.45)),
                    subitems: [item]
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
                let section = NSCollectionLayoutSection(group: group)
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: SectionTitleView.elementKind, alignment: .topLeading)
                let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(25)), elementKind: SectionPageControlView.elementKind, alignment: .bottomLeading)
                header.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
                footer.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
                section.visibleItemsInvalidationHandler = { items, offset, env in
                    let cellPosition = offset.x / env.container.contentSize.width
                    let index = Int(max(0, round(cellPosition)))
                    self.sectionDelegate?.collectionViewSection(.berita, scrollTo: index, progress: cellPosition)
                }
                section.boundarySupplementaryItems = [header,footer]
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 5, trailing: 0)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                return section
            }
        }
    }
    
    
}
