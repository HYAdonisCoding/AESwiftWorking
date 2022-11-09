//
//  HybridHandleViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2022/9/9.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import WebKit

class HybridHandleViewController: BaseViewController {
    private var webView: WKWebView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func configEvent() {
        super.configEvent()
    }
    override func configUI() {
        super.configUI()
        
        // 设置webView的配置
        let config = WKWebViewConfiguration.init()
        // 注入名字
//        config.userContentController.add(self, name: "JSBridge")
        if #available(iOS 11.0, *) {
            config.setURLSchemeHandler(self, forURLScheme: "baidu")
//            config.setURLSchemeHandler(self, forURLScheme: "https")
        } else {
            // Fallback on earlier versions
        }
        //创建webView
        webView =  WKWebView.init(frame: self.view.bounds, configuration: config)
        //导航代理
        webView?.navigationDelegate = self
        //交互代理
        webView?.uiDelegate = self
        //加载网页
//        let filePath = Bundle.main.path(forResource: "index", ofType: "html") ?? ""
        //获取代码
//        let pathURL =  URL(fileURLWithPath: filePath)
        let request = URLRequest.init(url: URL(string: "https://www.baidu.com")! )
        //webView.allowsBackForwardNavigationGestures = true
        webView?.load(request)
        view.addSubview(webView!)
    }



}


@available(iOS 11.0, *)
extension HybridHandleViewController: WKURLSchemeHandler {
    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        print("start", urlSchemeTask)
    }
    

    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
        print("stop", urlSchemeTask)
    }
    
    
}

extension HybridHandleViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
    }
    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        decisionHandler(.allow)
//    }
//    // MARK: - 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
//
//
//    // MARK: - 接收到服务器跳转请求即服务重定向时之后调用
//    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
//        debugPrintLog(webView)
//    }
    // MARK: - 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    // MARK: - 页面加载完成时调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    // MARK: - 页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    // MARK: - 提交发生错误时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
}


extension HybridHandleViewController: WKUIDelegate {
    // MARK: - 打开新窗口委托
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        //开发者实现这个方法，返回一个新的WKWebView，让 WKNavigationAction 在新的webView中打开。如果你没有设置 WKUIDelegate代理，或者没有实现这个协议。那么WKWebView将什么事情都不会做，也就是你点那个按钮没反应。
        //注意：返回的这个WKWebView不能和原来的WKWebView是同一个。如果你返回了原来的webView，将会抛出异常。
        if let frameInfo = navigationAction.targetFrame, !frameInfo.isMainFrame {
            webView.load(navigationAction.request)
        }
        return nil;
    }
    
    // MARK: - web界面中有弹出警告框时调用
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        debugPrintLog(message)
        completionHandler()
    }
    // MARK: - 确认框
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        debugPrintLog(message)
        completionHandler(true)
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        
    }
}
