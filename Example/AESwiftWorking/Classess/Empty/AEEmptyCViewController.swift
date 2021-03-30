//
//  AEEmptyCViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/3/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEEmptyCViewController: AEBaseCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configUI() {
        super.configUI()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(reloadAction(item:)))
        let empty = AEEmptyTool()
        empty.setEmptyView(collectionView) {
            print("reload")
        }
        let layout = UICollectionViewFlowLayout.init()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: (Int(ScreenWidth)-30)/2, height:80)
        layout.headerReferenceSize = CGSize(width: 375, height: 130)
        layout.footerReferenceSize = CGSize(width: 375, height: 130)
        collectionView.setCollectionViewLayout(layout, animated: true)

    }

}

extension AEEmptyCViewController {
    @objc func reloadAction(item: UIBarButtonItem) {
        item.style =  item.style == .done ? .plain : .done
        if item.style == .done {
            dataArray = ["1", "2", "3"]
        } else {
            dataArray = []
            // 一般情况下 再数据返回来之后再将其设置为true
        }
        AEEmptyTool.reloadDataSource(collectionView)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = AEBaseCollectionViewCell.loadCode(collectionView: collectionView, index: indexPath)
        cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.brown : UIColor.magenta
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = AECHeaderView.loadCode(collectionView: collectionView, kind: kind, index: indexPath)
        
        header.titleLabel.text = kind
        header.titleLabel.backgroundColor = UIColor.magenta
        header.backgroundColor = UIColor.purple
        return header
    }
}
