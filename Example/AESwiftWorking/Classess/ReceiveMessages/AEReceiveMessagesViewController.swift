//
//  AEReceiveMessagesViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/27.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEReceiveMessagesViewController: AEBaseTableViewController {

    private lazy var header: AEGroupHeaderView = {
        let name = AEGroupHeaderView.headerView(value: nil) { (idx) in
            print(idx)
        }
        view.addSubview(name)
        name.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(self.bottomLayoutGuide.snp.top)
            }
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        return name
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "接收消息"
        let _ = header
        tableView.snp.remakeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(self.bottomLayoutGuide.snp.bottom)
            }
            make.left.right.equalToSuperview()
            make.top.equalTo(header.snp.bottom)
        }
    }
    

    
}
