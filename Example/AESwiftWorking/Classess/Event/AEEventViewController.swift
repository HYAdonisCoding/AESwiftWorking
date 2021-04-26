//
//  AEEventViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEEventViewController: BaseViewController {
    private lazy var baseView: AETestAView = {
        let name = AETestAView()
        name.backgroundColor = UIColor.systemBlue
//        name.frame = CGRect(x: 10, y: 20, width: 300, height: 400)
        self.view.addSubview(name)
        name.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(self.topLayoutGuide.snp.top).offset(0)
                make.bottom.equalTo(self.bottomLayoutGuide.snp.bottom)
            }
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        return name
    }()
    private lazy var testView: AETestBView = {
        let name = AETestBView()
        name.backgroundColor = UIColor.brown
//        name.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        baseView.addSubview(name)
        name.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
        return name
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
    }
    override func configEvent() {
        super.configEvent()
    }
    override func configUI() {
        super.configUI()
        let _ = baseView
        
        let _ = testView
    }

    

}
