//
//  AEChartsTableViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/5/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEChartsTableViewController: HomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configEvent() {
        super.configEvent()
        dataArray = ["AEBarGraphViewController"]
    }
    
    override func configUI() {
        super.configUI()
        //
        navigationItem.title = "Charts Study"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
