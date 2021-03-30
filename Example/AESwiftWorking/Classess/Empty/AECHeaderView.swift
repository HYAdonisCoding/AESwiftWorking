//
//  AECHeaderView.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/3/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AECHeaderView: AECollectionReusableView {
    override class func loadCode(collectionView: UICollectionView, kind: String, index: IndexPath) -> AECHeaderView {
        let identifier: String = String(describing: self)
        collectionView.register(AECHeaderView.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        let cell: AECHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: index) as! AECHeaderView
        cell.indexPath = index
        cell.configEvent()
        cell.configUI()
        
        return cell
    }
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
//            make.bottom.equalTo(-20)
        }
        return titleLabel
    }()
    

    override func configUI() {
        super.configUI()
        let _ = titleLabel
        
    }
}
