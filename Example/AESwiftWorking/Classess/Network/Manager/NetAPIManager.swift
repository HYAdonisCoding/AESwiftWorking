//
//  NetAPIManager.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2022/11/9.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

enum NetAPIManager{
    case Show
    case upload(bodyData: Data)
    case download
    case request(isTouch: Bool, body: Dictionary<String, Any>? , isShow: Bool)
}

//extension NetAPIManager: TargetType {
//    var baseURL: URL {//服务器地址
//        
//        switch self {
//        case .request( _, _, _):
//            return URL(string: "http://127.0.0.1:8080")!
//        default:
//            return URL(string: "https://httpbin.org")!
//        }
//        
//        
//    }
//    
//    var path: String {//具体某个方法的路径
//        switch self {
//        case .Show:
//            return ""
//        case .upload(_):
//            return ""
//        case .request(_, _, _):
//            return "/app/json.do"
//        case .download:
//            return ""
//        }
//    }
//    
//    var method: Moya.Method {//请求的方法 get或者post之类的
//        switch self {
//        case .Show:
//            return .get
//        case .request(_, _, _):
//            return .post
//        default:
//            return .post
//        }
//    }
//    
//    var parameters: [String: Any]? {//请求的get post给服务器的参数
//        switch self {
//        case .Show:
//            return nil
//        case .request(_, _, _):
//            return ["msg":"H4sIAAAAAAAAA11SSZJFIQi7EqPAEgTvf6TP62W7sMoSQhKSWDrs6ZUKVWogLwYV7RjHFBZJlNlzloN6LVqID4a+puxqRdUKVNLwE1TRcZIC/fjF2rPotuXmb84r1gMXbiASZIZbhQdKEewJlz41znDkujCHuQU3dU7G4/PmVRnwArMLXukBv0J23XVahNO3VX35wlgce6TLUzzgPQJFuHngAczl6VhaNXpmRLxJBlMml6gdLWiXxTdO7I+iEyC7XuTirCQXOk4dotgArgkH/InxVjfNTnE/uY46++hyAiLFuFL4cv1Z8WH5DgB2GnvFXMh5gm53Tr13vqqrEYtcdXfkNsMwKB+9sAQ77grNJmquFWOhfXA/DELlMB0KKFtHOc/ronj1ml+Z7qas82L3VWiCVQ+HEitjTVzoFw8RisFN/jJxBY4awvq427McXqnyrfCsl7oeEU6wYgW9yJtj1lOkx0ELL5Fw4z071NaVzRA9ebxWXkFyothgbB445cpRmTC+//F73r1kOyQ3lTpec12XNDR00nnq5/YmJItW3+w1z27lSOLqgVctrxG4xdL9WVPdkH1tkiZ/pUKBGhADAAA="]
//        default:
//            return nil
//        
//        }
//    }
//    
//    var sampleData: Data { //编码转义
//       return "{}".data(using: String.Encoding.utf8)!
//    }
//    
//    var task: Task { //一个请求任务事件
//        
//        switch self {
//
//        
//        case let .upload(data):
//        return .upload(.multipart([MultipartFormData(provider: .data(data), name: "file", fileName: "gif.gif", mimeType: "image/gif")]))
//            
//        default:
//            return .request
//
//       }
//
//     }
//    
//    var parameterEncoding: ParameterEncoding {//编码的格式
//        switch self {
//        case .request(_, _, _):
//            return URLEncoding.default
//        default:
//            return URLEncoding.default
//        }
//        
//    }
//    //以下两个参数是我自己写，用来控制网络加载的时候是否允许操作，跟是否要显示加载提示，这两个参数在自定义插件的时候会用到
//    var touch: Bool { //是否可以操作
//        
//        switch self {
//        case .request(let isTouch, _, _):
//            return isTouch
//        default:
//            return false
//        }
//        
//    }
//    
//    var show: Bool { //是否显示转圈提示
//        
//        switch self {
//        case .request( _, _,let isShow):
//            return isShow
//        default:
//            return false
//        }
//        
//    }
//    
//    
//}
