//
//  ICAppManager.swift
//  ICMS
//
//  Created by Adam on 2021/2/13.
//

import Foundation

class ICAppManager: NSObject {
    // 全局变量
    static let shared = ICAppManager()
    private override init() {}
    /// 版本模型
    var sysModel: ICNetworkBodyModel?
    /// 用户模型
    var userModel: ICLoginModel?
    
    var token: String?
    var aesKey: String?
    
    /// 服务器数组
//    var serverArrary: [ICDebugModel] {
//        get {
//            var arr: [ICDebugModel] = []
//            var model = ICDebugModel()
//            model.serverName = "渗透测试"
//            model.serverBaseUrl = "http://111.205.51.131:8876/apicolleweb/"
//            arr.append(model)
//            model = ICDebugModel()
//            model.serverName = "孙穆涛"
//            model.serverBaseUrl = "http://10.192.107.88:8002/apicolleweb/"
//            arr.append(model)
//            model = ICDebugModel()
//            model.serverName = "测试"
//            model.serverBaseUrl = "http://10.200.181.232:17202/apicolleweb/"
//            arr.append(model)
//            model = ICDebugModel()
//            model.serverName = "樊学涛"
//            model.serverBaseUrl = "http://10.192.107.221:17202/apicolleweb/"
//            arr.append(model)
//            return arr
//        }
//    }
    /// 默认服务
//    var defaultServerName: String = "渗透测试" {
//        didSet {
//            for (_, model) in ICAppManager.shared.serverArrary.enumerated() {
//                if model.serverName == ICAppManager.shared.defaultServerName {
//                    ICAppManager.shared.defaultSserverBaseUrl = model.serverBaseUrl!
//                    break
//                }
//            }
//        }
//    }
    /// 默认服务
    var defaultSserverBaseUrl: String = "http://111.205.51.131:8876/apicolleweb/" {
        didSet {
            /// 设置 url
//            WebService.shared.rootUrl = defaultSserverBaseUrl
        }
    }

}
