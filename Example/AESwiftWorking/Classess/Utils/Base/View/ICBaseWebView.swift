//
//  ICBaseWebView.swift
//  ICMS
//
//  Created by Adam on 2021/3/19.
//

import Foundation
import WebKit

class ICBaseWebView: AEBaseView {
    private lazy var showHUDAndAlet: Bool = {
        let name = true
        
        return name
    }()
    private lazy var mutableURLRequest: NSMutableURLRequest = {
        let mutableURLRequest = NSMutableURLRequest(url: URL.init(string: "")!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 15)
        
        return mutableURLRequest
    }()
    


    lazy var webView: WKWebView = {
        let userContentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        config.userContentController = userContentController
        
        let processpool = WKProcessPool()
        if processpool != nil {
            config.processPool = processpool
        }
        let webView = WKWebView(frame: CGRect.zero, configuration: config)
        webView.allowsBackForwardNavigationGestures = true
        self.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.edges.equalToSuperview()
        }
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()
    
    deinit {
        webView.stopLoading()
        webView.uiDelegate = nil
        webView.navigationDelegate = nil
        
    }
}

extension ICBaseWebView {
    /// 是否展示提示
    func hideHUDAndAlert(_ show: Bool) {
        showHUDAndAlet = show
    }
    /// 直接加载地址
    func requestUrlString(_ url: String) -> NSMutableURLRequest {
        mutableURLRequest.url = URL.init(string: url)
        webView.load(mutableURLRequest as URLRequest)
        return mutableURLRequest
    }
    /// 直接加载本地
    func requestFileURLWithPath(_ path: String) -> NSMutableURLRequest {
        mutableURLRequest.url = URL.init(fileURLWithPath: path)
        webView.load(mutableURLRequest as URLRequest)
        return mutableURLRequest
    }
}

extension ICBaseWebView: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if showHUDAndAlet {
            webView.showBusy()
        }
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        debugPrintLog(webView)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if showHUDAndAlet {
            webView.hideBusyHUD()
        }
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrintLog(error.localizedDescription)
        if showHUDAndAlet {
            webView.hideBusyHUD()
        }
    }
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        if showHUDAndAlet {
            ICSystemAlert.alertWith(message: prompt) { (idx, title) in
                
            } cancelHandler: {
                
            }

        }
        completionHandler(defaultText)
    }
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
}

extension ICBaseWebView {
    override func configEvent() {
        super.configEvent()
    }
    override func configUI() {
        super.configUI()
        
        let _ = webView
//        layoutIfNeeded()
    }
}
