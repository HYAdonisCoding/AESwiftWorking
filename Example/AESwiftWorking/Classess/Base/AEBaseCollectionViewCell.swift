//
//  AEBaseCollectionViewCell.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/3/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEBaseCollectionViewCell: UICollectionViewCell {
    var indexPath: IndexPath?
    
    class func loadCode(collectionView: UICollectionView, index: IndexPath) -> AEBaseCollectionViewCell {
        let identifier: String = String(describing: self)
        collectionView.register(AEBaseCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        let cell: AEBaseCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: index as IndexPath) as! AEBaseCollectionViewCell
        cell.indexPath = index
        cell.configEvent()
        cell.configUI()
        
        return cell
    }
}

extension AEBaseCollectionViewCell: ICBaseProtocol {
    @objc func configUI() {
    }
    @objc func configEvent() {
    }
}
