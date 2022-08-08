//
//  AEEmptyViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/3/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEEmptyViewController: HomeViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configEvent() {
        self.dataArray = ["AEEmptyTViewController", "AEEmptyCViewController", "AEEmptyDataSetTViewController"]
        navigationItem.title = "Empty_Test"
    }

}
