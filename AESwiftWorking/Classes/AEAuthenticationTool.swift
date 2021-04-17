//
//  AEAuthenticationTool
//  Adam_20190423_TouchID_Swift
//
//  Created by HYAdonisCoding on 2019/4/23.
//  Copyright (c) 2021 HYAdonisCoding. All rights reserved.
//

import UIKit
import LocalAuthentication

public class AEAuthenticationTool: NSObject {
    ///闭包
    public var completionHandlers: [(_ success: Bool, _ type: HYAuthenticationVerifyType, _ descString: String,  _ error: Error?) -> Void] = []
    

    ///ID验证枚举
    public enum HYAuthenticationVerifyType {
        case FaceID
        case TouchID
        case SecretCode
        case NullID
    }
    
    ///是否是第一次验证
    private var isFirstVerify = true
    
    private let context = LAContext()
    
    ///
    private var type = HYAuthenticationVerifyType.TouchID
    
    
    public func authenticatedByBiometryOrDevicePasscode (completionHandlers: @escaping (_ success: Bool, _ type: HYAuthenticationVerifyType, _ descString: String, _ error: Error?) -> Void) -> Void {
        
        if isIPhoneXSeries() {
            self.type = HYAuthenticationVerifyType.FaceID
        }

        self.authenticatedByBiometryOrDevicePasscodeVerify { (secretCodeVerifySuccess, type, descString, error) in
            if secretCodeVerifySuccess {
                completionHandlers(true, self.type, "Verify success", error)
            } else {
                if let error = error as NSError? {
                    self.callBackWithFaceIDOrTouchID(context: self.context, error: error, completionHandlers: { (success, type, descString1, error) in
                            completionHandlers(success, type, descString1, error!)
                    })
                }
            }
        }
        
    }
    
    private func authenticatedByBiometryOrDevicePasscodeVerify(completionHandlers: @escaping (_ success: Bool, _ type: HYAuthenticationVerifyType, _ descString: String, _ errorX: Error?) -> Void) -> Void {
        var error1 : NSError?

        //开始识别
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error1) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "请使用\(type)验证") { (success, errorSys) in
                if success {
                  completionHandlers(true, self.type, "verify success", errorSys)
                } else {
                    if let error2 = errorSys as NSError? {
                        self.callBackWithFaceIDOrTouchID(context: self.context, error: error2, completionHandlers: { (success, type, descString, error3) in
                            completionHandlers(success, type, descString, error3!)
                        })
                    }
                }
            }
        } else {
            
            self.type = HYAuthenticationVerifyType.NullID
            //不支持指纹识别
            completionHandlers(false, self.type, "no support", error1!)
        }
        
    }
    
    
    ///     系统回调
    ///
    /// - Parameters:
    ///   - context: 上下文

    ///   - error: 错误
    ///   - completionHandlers: 回调
    private func callBackWithFaceIDOrTouchID(context: LAContext, error: NSError, completionHandlers: @escaping (_ success: Bool, _ type: HYAuthenticationVerifyType, _ descString: String, _ error: Error?) -> Void) -> Void {
        var type = HYAuthenticationVerifyType.TouchID
        if isIPhoneXSeries() {
            type = HYAuthenticationVerifyType.FaceID
        }
        if self.isFirstVerify == false {
            type = HYAuthenticationVerifyType.SecretCode
        }
        if self.isFirstVerify == true {
            self.isFirstVerify = false
        }
        
        switch error.code {
        case LAError.appCancel.rawValue:
            completionHandlers(false, type, "Authentication was cancelled by application", error)
        case LAError.authenticationFailed.rawValue:
            debugPrint("The user failed to provide valid credentials")
            if type != HYAuthenticationVerifyType.SecretCode {
                self.authenticatedByBiometryOrDevicePasscodeVerify { (secretCodeVerifySuccess, type, descString, error) in
                    completionHandlers(secretCodeVerifySuccess, type, descString, error)
                }
            }
        case LAError.invalidContext.rawValue:
            completionHandlers(false, type, "The context is invalid", error)
        case LAError.passcodeNotSet.rawValue:
            completionHandlers(false, type, "Passcode is not set on the device", error)
        case LAError.systemCancel.rawValue:
            completionHandlers(false, type, "Authentication was cancelled by the system", error)
        case LAError.touchIDLockout.rawValue:
            debugPrint("Too many failed attempts.")
            self.authenticatedByBiometryOrDevicePasscodeVerify { (secretCodeVerifySuccess, type, descString, error) in
                completionHandlers(secretCodeVerifySuccess, type, descString, error)
            }
        case LAError.touchIDNotAvailable.rawValue:
            completionHandlers(false, type, "TouchID is not available on the device", error)
        case LAError.userCancel.rawValue:
            completionHandlers(false, type, "The user did cancel", error)
        case LAError.userFallback.rawValue:
            debugPrint("The user chose to use the fallback")
            self.authenticatedByBiometryOrDevicePasscodeVerify { (secretCodeVerifySuccess, type, descString, error) in
                completionHandlers(secretCodeVerifySuccess, type, descString, error)
            }
        default:
            completionHandlers(false, type, "Did not find error code on LAError object", error)
            
        }
    }
    
    private func isIPhoneXSeries() -> Bool {
        var iPhonesXSeries: Bool = false
        
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
            return iPhonesXSeries
        }
        
        if #available(iOS 11.0, *) {
            if Float((UIApplication.shared.keyWindow?.safeAreaInsets.bottom)!) > 0.0 {
                iPhonesXSeries = true
            }
        }
        return iPhonesXSeries;
    }
}
