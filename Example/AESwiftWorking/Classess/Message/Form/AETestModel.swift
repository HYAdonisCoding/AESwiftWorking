//
//  AETestModel.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

@objcMembers class AETestModel: AEBaseModel, PropertyLoopable {
    var name: String?
    var age: String?
    
    var height: String?
    
    var work: String?
    
    var type: String?
    
    
}

struct AETestStruct: PropertyLoopable, Codable {
//    static let instance: AETestStruct = AETestStruct()
    
    var name: String?
    var age: String?
    
    var height: String?
    
    var work: String?
    func set(_ value: String, forKey: String) {
        
    }
}


extension NSObject {
    
    /**
     获取对象对于的属性值，无对于的属性则返回NIL
     
     - parameter property: 要获取值的属性
     
     - returns: 属性的值
     */
    func getValueOfProperty(property:String)->AnyObject?{
        let allPropertys = self.getAllPropertys()
        if(allPropertys.contains(property)){
            return self.value(forKey: property) as AnyObject

        }else{
            return nil
        }
    }
    
    /**
     设置对象属性的值
     
     - parameter property: 属性
     - parameter value:    值
     
     - returns: 是否设置成功
     */
    func setValueOfProperty(property:String,value:AnyObject)->Bool{
        let allPropertys = self.getAllPropertys()
        if(allPropertys.contains(property)){
            self.setValue(value, forKey: property)
            return true
            
        }else{
            return false
        }
    }
    
    /**
     获取对象的所有属性名称
     
     - returns: 属性名称数组
     */
    func getAllPropertys()->[String]{
        
        var result = [String]()
        let count = UnsafeMutablePointer<UInt32>.allocate(capacity: 0)
        let buff = class_copyPropertyList(object_getClass(self), count)
        let countInt = Int(count[0])
        

        for i in 0...countInt-1 {
            let temp = buff![i]
            let tempPro = property_getName(temp)
            let proper = String(utf8String: tempPro)
            if let p = proper {
                result.append(p)
            }
        }
        return result
    }
}

protocol PropertyLoopable
{
    func allProperties() throws -> [String: Any]
}

extension PropertyLoopable
{
    func allProperties() throws -> [String: Any] {

        var result: [String: Any] = [:]

        let mirror = Mirror(reflecting: self)

        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            //throw some error
            throw NSError(domain: "hris.to", code: 777, userInfo: nil)
        }

        for (labelMaybe, valueMaybe) in mirror.children {
            guard let label = labelMaybe else {
                continue
            }

            result[label] = valueMaybe
        }

        return result
    }
}
