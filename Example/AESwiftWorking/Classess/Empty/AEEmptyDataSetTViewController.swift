//
//  AEEmptyDataSetTViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/13.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class AEEmptyDataSetTViewController: HomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "EmptyDataSet"

        dataArray = []
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(reloadAction(item:)))
        
        // Do any additional setup after loading the view.
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetView { [weak self] view in
            let customView = AEBaseView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            customView.backgroundColor = UIColor.red
            
            view.customView(customView)

        }
    }

}

extension AEEmptyDataSetTViewController: EmptyDataSetSource, EmptyDataSetDelegate {
    func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
        let view = AEBaseView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        view.backgroundColor = UIColor.red
        return view
    }
}
extension AEEmptyDataSetTViewController {
    @objc func reloadAction(item: UIBarButtonItem) {
        item.style =  item.style == .done ? .plain : .done
        if item.style == .done {
            dataArray = ["1", "2", "3"]
        } else {
            dataArray = []
            // 一般情况下 再数据返回来之后再将其设置为true
        }
        tableView.reloadData()
    }
    
}
