//
//  ICBaseWebVC.swift
//  ICMS
//
//  Created by Adam on 2021/3/19.
//

import Foundation

class ICBaseWebVC: ICBaseViewController {
    
    lazy var web: ICBaseWebView = {
        let web = ICBaseWebView()
        self.view.addSubview(web)
        web.snp.makeConstraints { (make) in
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
        return web
    }()
    

    override func configEvent() {
        super.configEvent()
    }
    
    override func configUI() {
        super.configUI()
        
        let _ = web
        
//        self.view.layoutIfNeeded()
    }
}

extension ICBaseWebVC {
    override func backItemPressed() {
        if web.webView.canGoBack {
            web.webView.goBack()
        } else {
            super.backItemPressed()
        }
    }
}
