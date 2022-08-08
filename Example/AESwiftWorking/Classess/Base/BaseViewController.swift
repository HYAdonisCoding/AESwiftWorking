//
//  BaseViewController.swift
//  Adam_Surely_Swift
//
//  Created by Adam on 2021/3/24.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self) viewDidLoad")
        configEvent()
        configUI()
    }
    
    deinit {
        
        print("\(self) deinit")
    }
}
extension BaseViewController: ICBaseProtocol {
    @objc func configUI() {
        self.view.backgroundColor = UIColor.white
    }
    @objc func configEvent() {
    }
}
