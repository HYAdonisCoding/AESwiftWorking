//
//  AEViewController.swift
//  AESwiftWorking
//
//  Created by HYAdonisCoding on 04/24/2019.
//  Copyright (c) 2021 HYAdonisCoding. All rights reserved.
//

import UIKit
import AESwiftWorking

class AEViewController: UIViewController {
    
    
    
    ///转账用户名 转账成功后清空
    private var userName : String? = "Adam"
    ///转账金额 转账成功后清空
    private var money : String? = "10000"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        self.closureExpression()
        //        self.closureOfTrailing()
        //        self.closureValueCapture()
        //        self.closureReferenceType()
        //        self.closureEscape()
        self.closureAuto()
        
    }
    
    
    /// 发起转账申请
    @IBAction func transferAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "转账", message: "请输入转账的账户姓名及金额", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
            print("you have pressed the Cancel button!")
        }
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            print("you have pressed OK button!")
            
            self.userName = alertController.textFields?[0].text
            self.money =  alertController.textFields?[1].text
            
            
            self.verifyAndStartTransfer(userName: self.userName, money: self.money)
            
        }
        alertController.addAction(okAction)
        
        
        alertController.addTextField { (textField : UITextField) in
            textField.placeholder = "账户名称"
            if self.userName != nil {
                textField.text = self.userName
            }
        }
        alertController.addTextField { (textField : UITextField) in
            textField.placeholder = "金额"
            textField.keyboardType = .numbersAndPunctuation
            if self.money != nil {
                textField.text = self.money
            }
        }
        
        self.present(alertController, animated: true) {
            
        }
    }
    
    
    func verifyAndStartTransfer(userName: String?, money: String?) -> Void {
        let moneySum = Float(money!)
        let userNameStr = userName
        if  moneySum  != nil && userNameStr != nil  {

            //调起指纹支付
            AEAuthenticationTool().authenticatedByBiometryOrDevicePasscode { (success, type, errorString, error) in

                var typeStr = ""

                switch type {
                case .FaceID:
                    typeStr = "FaceID"
                case .TouchID:
                    typeStr = "TouchID"
                case .SecretCode:
                    typeStr = "SecretCode"
                case .NullID:
                    typeStr = "NullID"
                }
                if success {
                    debugPrint("验证成功, \(type)")
                    self.userName = nil
                    self.money = nil

                    let alertController = UIAlertController(title: "恭喜您", message: "-转账成功--\(typeStr)-\(errorString)", preferredStyle:.alert)

                    let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
                        print("you have pressed OK button 恭喜您");
                    }
                    alertController.addAction(OKAction)

                    self.present(alertController, animated: true, completion:{ () -> Void in
                        //your code here
                    })
                } else {

                    let alertController = UIAlertController(title: "对不起", message: "-转账转账失败-\(typeStr)-\(errorString)", preferredStyle:.alert)

                    let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
                        print("you have pressed OK button 对不起");
                    }
                    alertController.addAction(OKAction)

                    self.present(alertController, animated: true, completion:{ () -> Void in
                        //your code here
                    })

                }
            }

        } else {
            if moneySum  == nil && userNameStr!.count <= 0 {
                debugPrint("姓名和金额不能为空")
                let alertController = UIAlertController(title: "请重新输入", message: "姓名和金额不能为空", preferredStyle:.alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.money = nil
                }
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true, completion:{ () -> Void in
                    //your code here
                })
            } else if moneySum  == nil {
                debugPrint("金额不能为空")
                let alertController = UIAlertController(title: "请重新输入", message: "金额不能为空", preferredStyle:.alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.money = nil
                }
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true, completion:{ () -> Void in
                    //your code here
                })
            } else if userNameStr!.count <= 0 {
                debugPrint("姓名不能为空")
                let alertController = UIAlertController(title: "请重新输入", message: "姓名不能为空", preferredStyle:.alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
                    
                }
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true, completion:{ () -> Void in
                    //your code here
                })
                
            }
        }
    }
    
    
    ///闭包表达式
    func closureExpression() {
        ///排序方法
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        ///闭包作为参数
        var reversedNames = names.sorted(by: backward)
        
        ///闭包表达式版本
        reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
            return s1 < s2
        })
        
        //由于这个闭包的函数体部分如此短，以至于可以将其改写成一行代码：
        reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
        
        //根据上下文推断类型
        reversedNames = names.sorted(by: { s1, s2 in return s1 < s2 } )
        
        //单表达式闭包的隐式返回
        reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
        
        //参数名称缩写
        reversedNames = names.sorted(by: { $0 < $1 } )
        
        //运算符方法
        reversedNames = names.sorted(by: >)
        
        
        
        print(reversedNames)
        
        
    }
    
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    ///尾随闭包
    func closureOfTrailing() {
        // 以下是不使用尾随闭包进行函数调用
        someFunctionThatTakesAClosure(closure: {
            // 闭包主体部分
            debugPrint("尾随闭包 - 不使用尾随闭包进行函数调用")
        })
        
        
        // 以下是使用尾随闭包进行函数调用
        someFunctionThatTakesAClosure() {
            // 闭包主体部分
            debugPrint("尾随闭包 -1 使用尾随闭包进行函数调用")
        }
        
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        
        //作为尾随包的形式
        var reversedNames = names.sorted() { $0 > $1 }
        
        //如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉
        reversedNames = names.sorted { $0 > $1 }
        
        print(reversedNames)
        
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        
        let strings = numbers.map {
            (number) -> String in
            var number = number
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            return output
        }
        
        debugPrint(strings)
    }
    func someFunctionThatTakesAClosure(closure: () -> Void) {
        // 函数体部分
        debugPrint("尾随闭包")
    }
    
    
    
    ///值捕获
    func closureValueCapture() {
        let incrementByTen = makeIncrementer(forIncrement: 10)
        var value = incrementByTen()
        // 返回的值为10
        debugPrint("a:\(value)")
        value = incrementByTen()
        // 返回的值为20
        debugPrint("b:\(value)")
        value = incrementByTen()
        // 返回的值为30
        debugPrint("c:\(value)")
        
        let incrementBySeven = makeIncrementer(forIncrement: 7)
        value = incrementBySeven()
        // 返回的值为7
        debugPrint("d:\(value)")
        
        value = incrementByTen()
        debugPrint("e:\(value)")
    }
    
    func makeIncrementer(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementer
    }
    
    ///闭包是引用类型
    func closureReferenceType() {
        let incrementByTen = makeIncrementer(forIncrement: 10)
        var value = incrementByTen()
        debugPrint("a:\(value)")
        
        let alsoIncrementByTen = incrementByTen
        value = alsoIncrementByTen()
        debugPrint("b:\(value)")
    }
    
    ///逃逸闭包
    //1.一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中
    //    var completionHandlers: [() -> Void] = []
    //    func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    //        completionHandlers.append(completionHandler)
    //    }
    
    func closureEscape() {
        let instance = SomeClass()
        instance.doSomething()
        print(instance.x)
        // 打印出“200”
        
        completionHandlers.first?()
        print(instance.x)
    }
    
    
    
    
    ///自动闭包
    func closureAuto() {
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)
        // 打印出“5”
        
        let customerProvider = { customersInLine.remove(at: 0) }
        print(customersInLine.count)
        // 打印出“5”
        
        print("Now serving \(customerProvider())!")
        // Prints "Now serving Chris!"
        print(customersInLine.count)
        // 打印出“4”
        
        serve(customer: customersInLine.remove(at: 0))
        // 打印“Now serving Ewa!”
        
        
        collectCustomerProviders(customersInLine.remove(at: 0))
        collectCustomerProviders(customersInLine.remove(at: 0))
        
        print("Collected \(customerProviders.count) closures.")
        // 打印“Collected 2 closures.”
        for customerProvider in customerProviders {
            print("Now serving \(customerProvider())!")
        }
        // 打印“Now serving Barry!”
        // 打印“Now serving Daniella!”
    }
    // customersInLine i= ["Barry", "Daniella"]
    var customerProviders: [() -> String] = []
    func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
        customerProviders.append(customerProvider)
    }
    
    // customersInLine is ["Ewa", "Barry", "Daniella"]
    func serve(customer customerProvider: @autoclosure () -> String) {
        print("Now serving \(customerProvider())!")
    }
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}
var completionHandlers: [() -> Void] = []
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithNonescapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

