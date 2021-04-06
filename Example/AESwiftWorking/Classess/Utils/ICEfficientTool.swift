//
//  ICEfficientTool.swift
//  ICMS
//
//  Created by Adam on 2021/2/4.
//

import Foundation
import UIKit
//import HandyJSON  
//import SwiftyJSON
//import SAMKeychain

enum ICEncryptType {
    case none
    case outsideLanding
    case insideLanding/// 登陆内
}
func decodeDataToModel<T:Decodable>(_ json : String?, type: T.Type) -> T? {
    guard let json = json else { return nil }
    
//    guard let data = try? JSONSerialization.data(withJSONObject: json, options: [.fragmentsAllowed, .prettyPrinted]) else { return nil }
    guard let data = json.data(using: .utf8) else { return nil }
    do {
        let object = try JSONDecoder().decode(T.self, from: data)
        return object
    } catch  {
        print("Unable to decode----", error)
    }
    return nil
}
class ICEfficientTool {
    
//    func getUserImei() -> String {
//        var passWord: String? = nil
//        /// 创建新的
////        passWord = "E52C7C93-D08C-4684-8186-E4350E52AE35"
////        SAMKeychain.setPassword(passWord!, forService: "icms.com.cn", account: "ICMS")
//
//        #if arch(i386) || arch(x86_64)
//        return "E52C7C93-D08C-4684-8186-E4350E52AE35"
//        #endif
//
//        do {
//
//            passWord = try SAMKeychain.password(forService: "icms.com.cn", account: "ICMS")
//        } catch {
//            debugPrintLog("读取IMEI 出错")
//
//        }
//
//
//        if let uuid = passWord {
//            debugPrintLog("读取 passWord: \(String(describing: passWord))")
//            return uuid
//        } else {
//            passWord = UUID().uuidString
//
//
//            SAMKeychain.setPassword(passWord!, forService: "icms.com.cn", account: "ICMS")
//
//            debugPrintLog("新建 passWord: \(String(describing: passWord))")
//        }
//        return passWord!
////        return "E52C7C93-D08C-4684-8186-E4350E52AE35"
//    }
    
    func getAppVersion() -> String {
        let infoDic = Bundle.main.infoDictionary

        // 获取App的版本号
        let appVersion = infoDic?["CFBundleShortVersionString"]
        return appVersion as! String
    }
    
//    func getEncryptJSON(params: Dictionary<String, Any>, type: ICEncryptType = .insideLanding) -> String {
//        let jsonString = ICEfficientTool.getJSONStringFromData(obj: params)
//        if type == .insideLanding {
//            if let publicKey = ICAppManager.shared.aesKey {
//                let encryptedString = ICEncryptedTool.aesEncrypted(jsonString, publicKey: publicKey)
//                return encryptedString
//            }
//            return ""
//        }
//        let encryptedString = ICEncryptedTool.encrypted(jsonString, publicKey: ICEfficientTool.getPublicKey())
//        return encryptedString
//    }
    
//    class func getPublicKey() -> String {
//        if ICAppManager.shared.defaultServerName == "生产" {
//            /// 生产公钥
//            return ""
//        } else {
//
//            return "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0JbmpBR8odcIV3FwSSrfsYoV8kmT2H+XcsIz4ypBXvQFveGj4+JwinCbFKB2jVIfnbpCYZRfzyikUHwasCU6QI2VAo63w5OfYJHqyDzvHOUIMxqkHDtCZsRpwzu/M0AiJe1a6m3NMpDm4LJlDhWteMYUUDU2abMDosZpmarJIEqUeeVF8+/vC4inZTuTAjIGiMfWRhssgLY5Jzydj9UKChfGs5IC0FhuR5fRhKdlfUnurbZIRhD8cxbpZXFVBeyChJzHTYVekCIuc1Wio+2kYo8wckTSmp1OmkvJvdGrQCed1QrHT6f7mtzYTm90fe1Y05fQYi/h1SJ01q0JcRpiYQIDAQAB"
//        }
//    }
    
//    class func aesKey() -> String {
//        let aes_key = HYEncryptTool.randomlyGenerated16BitString()
//        return HYEncryptTool.hexString(from: aes_key)//16位格式字符串
//    }
    
//    class func restartAPP() -> Void {
//        debugPrintLog("restartAPP")
//        //取消所有请求
//        ICNetworkProvider.session.cancelAllRequests()
//        UIApplication.shared.resignFirstResponder()
//        let app = AppDelegate()
//        app.configEvents()
//        app.configUI()
//    }
    
    
    class func getDocumentsDirectory() -> String {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        let documentPath = documentPaths.first ?? ""
        return documentPath
    }
    class func saveImageFile(_ image: UIImage,_ imageName: String) {
        let name = "/\(imageName).jpg"
        let filePath = ICEfficientTool.getDocumentsDirectory()+name
        
        if let data = image.jpegData(compressionQuality: 0.5) {
            try? data.write(to: URL(fileURLWithPath: filePath))
        }
    }
    class func getImageFile(_ imageName: String) -> Data? {
        let name = "/\(imageName).jpg"
        let filePath = ICEfficientTool.getDocumentsDirectory()+name
        let imgData = try? Data.init(contentsOf: URL(fileURLWithPath: filePath))
        return imgData
    }
    class func getImageFile(imageName: String) -> UIImage? {
        if let imgData = ICEfficientTool.getImageFile(imageName) {
            return UIImage(data: imgData)
        }
        return nil
    }
    
}

extension String {
    ///
//    var md5 : String {
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//
//        CC_MD5(str!, strLen, result)
//
//        let hash = NSMutableString()
//        for i in 0 ..< digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        result.deinitialize(count: digestLen)
//
//        return String(format: hash as String)
//    }
}

extension ICEfficientTool {
    
    
    //将数组/字典 转化为字符串
       class func getJSONStringFromData(obj:Any) -> String {
           
           if (!JSONSerialization.isValidJSONObject(obj)) {
//               debugPrintLog("无法解析出JSONString")
               return ""
           }
           
           if let data : NSData = try? JSONSerialization.data(withJSONObject: obj, options: []) as NSData? {
               if let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue) {
                   return JSONString as String
               }
           }
           return ""
       }

       //将字符串转化为 数组/字典
       class func getArrayOrDicFromJSONString(jsonString:String) -> Any {
           
           let jsonData:Data = jsonString.data(using: .utf8)!
           
           //可能是字典也可能是数组，再转换类型就好了
           if let info = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) {
               return info
           }
           return ""
       }
}



extension UIColor {
    /// 设置随机颜色
    class func randomColor() -> UIColor {
            let color: UIColor = UIColor.init(red: (((CGFloat)((arc4random() % 256)) / 255.0)), green: (((CGFloat)((arc4random() % 256)) / 255.0)), blue: (((CGFloat)((arc4random() % 256)) / 255.0)), alpha: 1.0);
            return color;
    }

    /// 设置颜色 示例：UIColorHex(0x26A7E8)
    class func colorHex(_ value:UInt32) -> UIColor {
        return colorHex_Alpha(value: value, alpha: 1.0);
    }

    /// 设置颜色与透明度 示例：UIColorHEX_Alpha(0x26A7E8, 0.5)
    class func colorHex_Alpha(value:UInt32, alpha:CGFloat) -> UIColor {
            let color = UIColor.init(red: (((CGFloat)((value & 0xFF0000) >> 16)) / 255.0), green: (((CGFloat)((value & 0x00FF00) >> 8)) / 255.0), blue: (((CGFloat)((value & 0x0000FF) >> 0)) / 255.0), alpha: alpha)
            return color
    }


}

extension NSObject {
    // MARK: - 返回类名
    var className: String {
        get {
            let name = type(of: self).description()
            if name.contains(".") {
                return name.components(separatedBy: ".")[1]
            } else {
                return name
            }
            
        }
    }
}

