//
//  AEEmptyTViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/3/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEEmptyTViewController: HomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configUI() {
        super.configUI()
        dataArray = []
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(reloadAction(item:)))
        
        
        let empty = AEEmptyTool()
        empty.setEmptyView(tableView) {
            print("reload")
        }

        let header = AETableHeaderView()
        header.backgroundColor = UIColor.green
        header.titleLabel.text = "我是组头"
        tableView.tableHeaderView = header
        
//        let foot = AETableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200))
//        foot.backgroundColor = UIColor.red
//        foot.titleLabel.text = "我是foot"
//        tableView.tableFooterView = foot
        
    }
    
}

extension AEEmptyTViewController {
    @objc func reloadAction(item: UIBarButtonItem) {
        item.style =  item.style == .done ? .plain : .done
        if item.style == .done {
            dataArray = ["1", "2", "3"]
        } else {
            dataArray = []
            // 一般情况下 再数据返回来之后再将其设置为true
        }
        AEEmptyTool.reloadDataSource(tableView)
    }
    
}
