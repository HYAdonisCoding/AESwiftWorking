//
//  HybridViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2022/9/9.
//  Copyright © 2022 CocoaPods. All rights reserved.
//  原生捕获webview的input的内容

import UIKit
import WebKit

class HybridViewController: BaseViewController {
    
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
        config.userContentController.add(self, name: "JSBridge")
        //创建webView
        webView =  WKWebView.init(frame: self.view.bounds, configuration: config)
        //导航代理
        webView?.navigationDelegate = self
        //交互代理
        webView?.uiDelegate = self
        //加载网页
        let filePath = Bundle.main.path(forResource: "index", ofType: "html") ?? ""
        //获取代码
        let pathURL =  URL(fileURLWithPath: filePath)
        let request = URLRequest.init(url: pathURL)
        //webView.allowsBackForwardNavigationGestures = true
        webView?.load(request)
        view.addSubview(webView!)
    }


}

extension HybridViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        //接收到js发送的消息
        //判断消息名字
        if message.name == "JSBridge" {
            guard let body = message.body as? [String : AnyObject] else{
                return
            }
            if body["id"] as! String == "sumit" {
                let value = body["value"] as! String
                //弹窗控制器
                let alertVC = UIAlertController.init(title: "提示", message: value, preferredStyle: UIAlertController.Style.alert)
                let canclelBtn = UIAlertAction.init(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
                alertVC.addAction(canclelBtn)
                self.present(alertVC, animated: true, completion: nil)
            }
            if body["id"] as! String == "searchKey" {
                let searchKey = body["value"] as! String
                print("输入中:\(searchKey)")
            }
            
        }
        
    }
}
extension HybridViewController: WKNavigationDelegate {
    //网页加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //注入监听输入框改变的方法和点击button的方法
        //获取js代码存放路径
        let filePath = Bundle.main.path(forResource: "bridge", ofType: "js") ?? ""
        //获取代码
        guard var jsString = try? String(contentsOfFile:filePath ) else {
            // 沒有讀取出來則不執行注入
            return
        }
        //在bridge.js文件里给输入框赋值是临时的,这里可以替换
        jsString = jsString.replacingOccurrences(of: "Placeholder_searchKey", with: "这里可以更换值")
        //获取到的代码 注入到web
        webView.evaluateJavaScript(jsString, completionHandler: { _, _ in
            print("代码注入成功")
        })
    }
}

extension HybridViewController: WKUIDelegate {
    
}
