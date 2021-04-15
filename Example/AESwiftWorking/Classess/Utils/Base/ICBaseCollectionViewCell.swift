//
//  ICBaseCollectionViewCell.swift
//  ICMS
//
//  Created by Adam on 2021/2/11.
//

import Foundation
import UIKit

class ICBaseCollectionViewCell: UICollectionViewCell {
    var indexPath: IndexPath?
    
    class func loadCode(collectionView: UICollectionView, index: IndexPath) -> ICBaseCollectionViewCell {
        let identifier: String = String(describing: self)
        collectionView.register(ICBaseCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        let cell: ICBaseCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: index as IndexPath) as! ICBaseCollectionViewCell
        cell.indexPath = index
        cell.configEvent()
        cell.configUI()
        
        return cell
    }
    
    func configUI() {
    }
    func configEvent() {
    }

}
