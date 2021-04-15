//
//  AEBaseViewController.swift
//  ICMS
//
//  Created by Adam on 2021/2/11.
//

import Foundation
import UIKit

class AEBaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrintLog("\(self) viewDidLoad")
        configEvent()
        configUI()
    }
    
    deinit {
        
        debugPrintLog("\(self) deinit")
    }
    func configUI() {
        self.view.backgroundColor = UIColor.white
//        /// 设置状态栏不透明 非全面屏手机 系统小于iOS 13
//        if #available(iOS 13, *) {
//            //高于 iOS13
//            
//        } else if #available(iOS 9, *) {
//            if let statusViewWindow =  UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow {
//                if let statusView = statusViewWindow.value(forKey: "statusBar") as? UIView {
//                    statusView.backgroundColor = UIColor.white
//                }
//            }
        //        }

        
        if (self.navigationController?.viewControllers.count ?? 0) > 1 {
            let leftBarBtn = UIBarButtonItem(title: "", style: .plain, target: self,action: #selector(backItemPressed))
            leftBarBtn.image = UIImage(named: "back_icon")
            //用于消除左边空隙，要不然按钮顶不到最前面
    //        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,action: nil)
    //        spacer.width = -10;
    //        self.navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
            self.navigationItem.leftBarButtonItem = leftBarBtn
        }
    }
    func configEvent() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        //修改导航栏文字颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        //修改导航栏按钮颜色
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
}

extension AEBaseViewController {
    /// 返回
    @objc func backItemPressed() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        }
    }
}
