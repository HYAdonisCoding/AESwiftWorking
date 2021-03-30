//
//  AECollectionReusableView.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/3/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AECollectionReusableView: UICollectionReusableView {
    var indexPath: IndexPath?
    
    class func loadCode(collectionView: UICollectionView, kind: String, index: IndexPath) -> AECollectionReusableView {
        let identifier: String = String(describing: self)
        collectionView.register(AECollectionReusableView.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        
        let cell: AECollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: index) as! AECollectionReusableView
        cell.indexPath = index
        cell.configEvent()
        cell.configUI()
        
        return cell
    }
}

extension AECollectionReusableView: ICBaseProtocol {
    @objc func configUI() {
    }
    @objc func configEvent() {
    }
}

extension AECollectionReusableView {
    /// 设置headerview自适应
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            snp.remakeConstraints { (make) in
                make.width.equalTo(superview!)
                make.edges.equalTo(superview!)
            }
            layoutIfNeeded()
        }
    }
}
