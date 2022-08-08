//
//  ExchangeMethod.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2022/4/1.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

class TestObject{
    @objc dynamic func myMethod(name:String,age:Int){
        print("myMethod -->\(name) 历经 --->\(age) 年")
    }
    @objc func myChangeMethod(name:String,age:Int) {
        print("myChangeethod -->\(name) 历经 --->\(age) 年")

    }
}


extension TestObject{

    public class func initializeMethod(){
        let originalSelector = #selector(TestObject.myMethod(name:age:))
        let swizzledSelector = #selector(TestObject.myChangeMethod(name:age:))
        
        let originalMethod = class_getInstanceMethod(self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        
        //在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
        let didAddMethod: Bool = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod!),     method_getTypeEncoding(swizzledMethod!))
        //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到     method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
        
    }
}


class TestFunc: NSObject {
    @objc dynamic func method1() {
        print("1. \(#function)")
    }
    @objc dynamic func method2() {
        print("2. \(#function)")
    }
    override init( ) {
        super.init()
        exchangeMethod(#selector(TestFunc.method1),#selector(TestFunc.method2))
    }
}




extension NSObject {
    // Selector must be dynamic type
    func exchangeMethod(_ src: Selector, _ swizzle: Selector) {
        let aClass: AnyClass = self.classForCoder
        let srcMethod = class_getInstanceMethod(aClass, src)
        let swizzleMethod = class_getInstanceMethod(aClass, swizzle)
        if srcMethod == nil || swizzleMethod == nil {
            print("Selector is nil, exchangeMethod filed")
            return
        }
        
        let didAddMethod = class_addMethod(aClass, src, method_getImplementation(swizzleMethod!), method_getTypeEncoding(swizzleMethod!))
        
        if didAddMethod {
            class_replaceMethod(aClass, swizzle, method_getImplementation(srcMethod!), method_getTypeEncoding(srcMethod!))
        } else {
            method_exchangeImplementations(srcMethod!, swizzleMethod!)
        }
        
    }
}


