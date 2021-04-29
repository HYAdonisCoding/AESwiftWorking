//
//  AEOperationViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/29.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEOperationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func configEvent() {
        super.configEvent()
        
        
    }
    
    override func configUI() {
        super.configUI()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        AEArcSelectionView.shared(titleArray: ["排行榜", "纳米分析"], closure: { (idx, title) in
            print("idx:\(idx) title:\(title)")
            
            let vc = AEAnalysisViewController()
            vc.navigationItem.title = title
            if idx == 0 {
                // Ranking List
            } else if idx == 1 {
                // Nanoanalysis
            }
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }
}
