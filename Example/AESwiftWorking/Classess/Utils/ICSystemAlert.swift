//
//  ICSystemAlert.swift
//  ICMS
//
//  Created by Adam on 2021/2/11.
//

import Foundation
import UIKit
import SwiftMessages
import PKHUD

class ICSystemAlert {
    
    typealias CIAlertActionBlock = (_ idx: UInt, _ name: String) -> Void
    typealias CICancelActionBlock = () -> Void

    class func promptMessage(_ message: String, confirmHandler: @escaping CIAlertActionBlock) {
        ICSystemAlert.alertWith(titleArray: ["确定"], message: message, preferredStyle: .alert, confirmHandler: confirmHandler, cancelHandler: nil)
    }

    class func alertWith(title: String = "提示", titleArray: [String] = ["确定"], message: String, preferredStyle: UIAlertController.Style = .alert, confirmHandler: @escaping CIAlertActionBlock, cancelHandler: CICancelActionBlock?) {
        //创建用于显示alertController的UIViewController
        
        let alertVC = UIViewController.init()
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for i in 0..<titleArray.count {
            let title = titleArray[i]
            
            let confirmAction = UIAlertAction(title: title, style: .default) { (action) in
                alertVC.view.removeFromSuperview()
                if confirmHandler != nil {
                    confirmHandler(UInt(i), title)
                }
            }
            alertController .addAction(confirmAction)
        }
        if preferredStyle == .actionSheet {
            let cancel = UIAlertAction(title: "取消", style: .cancel) { (canceAction) in
                alertVC.view.removeFromSuperview()
                if cancelHandler != nil {
                    cancelHandler!()
                }
            }
            alertController .addAction(cancel)
        }

        UIApplication.shared.keyWindow?.addSubview(alertVC.view)
        alertVC.present(alertController, animated: true) {
            
        }
    }

    class func actionSheet(title: String = "提示", titleArray: [String], message: String, confirmHandler: @escaping CIAlertActionBlock) {
        ICSystemAlert.alertWith(title: title, titleArray: titleArray, message: message, preferredStyle: .actionSheet, confirmHandler: confirmHandler, cancelHandler: nil)
    }
    class func actionSheet(title: String = "提示", titleArray: [String], message: String, confirmHandler: @escaping CIAlertActionBlock, cancelHandler: @escaping CICancelActionBlock) {
        ICSystemAlert.alertWith(title: title, titleArray: titleArray, message: message, preferredStyle: .actionSheet, confirmHandler: confirmHandler, cancelHandler: cancelHandler)
    }
    
    
    class func show(title: String = "提示", _ message: String, theme: Theme = .info) {
        let alert = MessageView.viewFromNib(layout: .cardView)
        alert.configureTheme(theme)
        
        alert.configureDropShadow()
        alert.configureContent(title: title, body: message)
        alert.button?.isHidden = true
        var config = SwiftMessages.defaultConfig
        config.presentationContext = .window(windowLevel: .alert)
        SwiftMessages.show(config: config, view: alert)
        
    }
}

let kShowWarningDelayDurationD: Float  = 0.15

extension UIView {
    typealias CIHUDCompleteHander = () -> Void
    func showBusy() {
        let hud = PKHUD.sharedHUD
        hud.contentView = PKHUDProgressView()
        hud.show()
    }
    func hideBusyHUD() {
        PKHUD.sharedHUD.hide()
    }
    func showProgress(_ word: String, completeHander: CIHUDCompleteHander?) {
        let hud = PKHUD.sharedHUD
        hud.contentView = PKHUDProgressView()
        hud.show()
        hud.hide(afterDelay: Double(kShowWarningDelayDurationD*Float(word.utf8.count))) { (success) in
            if completeHander != nil {
                completeHander!()
            }
        }

 
    }
    func showWarning(_ word: String, completeHander: CIHUDCompleteHander?) {
        let hud = PKHUD.sharedHUD
        hud.contentView = PKHUDProgressView()
        hud.show()
        hud.hide(afterDelay: Double(kShowWarningDelayDurationD*Float(word.utf8.count))) { (success) in
            if completeHander != nil {
                completeHander!()
            }
        }

 
    }
    func showSuccess(_ word: String, completeHander: CIHUDCompleteHander?) {
        let hud = PKHUD.sharedHUD
        hud.contentView = PKHUDSuccessView(subtitle: word)
        
        hud.show()
        hud.hide(afterDelay: Double(kShowWarningDelayDurationD*Float(word.utf8.count))) { (success) in
            if completeHander != nil {
                completeHander!()
            }
        }
        
    }
    func showError(_ word: String, completeHander: CIHUDCompleteHander?) {
        let hud = PKHUD.sharedHUD
        let view = PKHUDErrorView(subtitle: word)
        
        hud.contentView = view
        
        hud.show()
        hud.hide(afterDelay: Double(kShowWarningDelayDurationD*Float(word.utf8.count))) { (success) in
            if completeHander != nil {
                completeHander!()
            }
        }
        
    }
}

