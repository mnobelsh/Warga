//
//  SectionPageControlView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 26/10/21.
//

import UIKit
import PageControls

public final class SectionPageControlView: UICollectionReusableView {
        
    static let elementKind = UICollectionView.elementKindSectionFooter
    static let reuseIdentifier = String(describing: SectionPageControlView.self)
    
    // MARK: - SubViews
    public lazy var pageControl: SnakePageControl = {
        let pageControl = SnakePageControl(frame: self.frame)
        pageControl.progress = 0.0
        pageControl.activeTint = .primaryPurple
        pageControl.inactiveTint = .lightGray.withAlphaComponent(0.75)
        return pageControl
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.viewDidInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SectionPageControlView {
    
    func viewDidInit() {
        self.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
