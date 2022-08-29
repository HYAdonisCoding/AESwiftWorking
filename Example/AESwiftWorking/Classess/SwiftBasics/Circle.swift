//
//  Circle.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2022/8/10.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation


class Circle {
    static var radius: Int = 0
    class var diameter: Int {
        set {
            print("Circle setDiameter")
            radius = newValue / 2
        }
        get {
            print("Circle getDiameter")
            return radius * 2
        }
    }
}

class SubCircle: Circle {
    override static var diameter: Int {
        set {
            print("SubCircle setDiameter")
            super.diameter = newValue>0 ? newValue : 0
        }
        get {
            print("SubCircle getDiameter")
            return super.diameter
        }
    }
    
}

func test() {
    
    Circle.radius = 6;
    // Circle getDiameter
    // 12
    print(Circle.diameter)
    //Circle setDiameter
    Circle.diameter = 20
    // 10
    print(Circle.radius)
    
    SubCircle.radius = 6
    //SubCircle getDiameter
    // Circle getDiameter
    //12
    print(SubCircle.diameter)
    //SubCircle setDiameter
    //Circle setDiameter
    SubCircle.diameter = 20
    //10
    print(SubCircle.radius)
    
}
struct Point {
    var x: Double = 0
    var y: Double = 0
    
    static func + (p1: Point, p2: Point) -> Point {
        Point(x: p1.x + p2.x, y: p1.y + p2.y)
    }
    static func - (p1: Point, p2: Point) -> Point {
        Point(x: p1.x - p2.x, y: p1.y - p2.y)
    }
    static prefix func - (p: Point) -> Point {
        Point(x: -p.x, y: -p.y)
    }
    static func += (p1: inout Point, p2: Point) {
        p1 = p1 + p2
    }
    static prefix func ++(p: inout Point) -> Point {
        p += Point(x: 1, y: 1)
        return p
    }
    static postfix func ++ (p: inout Point) -> Point {
        let tmp = p
        p += Point(x: 1, y: 1)
        return tmp
    }
    static func == (p1: Point, p2: Point) -> Bool {
        (p1.x == p2.x) && (p1.y == p2.y)
    }
}


extension Double {
    var km: Double { self * 1_000.0 }
    var m: Double { self }
    var dm: Double { self / 10.0 }
    var cm: Double { self / 100.0 }
    var mm: Double { self / 1_000.0 }
}

extension Array {
    subscript(nullable idx: Int) -> Element? {
        if (startIndex..<endIndex).contains(idx) {
            return self[idx]
        }
        return nil
    }
}

extension Int {
    func repetitions(task: () -> Void) -> Void {
        for _ in 0..<self { task() }
    }
    
    mutating func square() -> Int {
        self = self * self
        return self
    }
    enum Kind { case negative, zero, postive }
    var kind: Kind {
        switch self {
        case 0: return .zero
        case let x where x > 0: return .postive
        default: return .negative
        }
    }
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex { decimalBase *= 10 }
        return (self / decimalBase) % 10
    }
    
}


/**■ 类型的访问级别会影响成员(属性、方法、初始化器、下标)、嵌套类型的默认访问级别
 * 一般情况下,类型为private或fileprivate ,那么成员\嵌套类型默认也是private或fileprivate
 * 一般情况下,类型为internal或public ,那么成员\嵌套类型默认是internal
 * 子类重写的成员访问级别必须 ≥ 父类的成员访问级别
 * */
public class PublicClass {
    public var p1 = 0
    var p2 = 0 // internal
    fileprivate func f1() {} // fileprivate
    private func f2() {} // private
}
class InternalClass { // internal
    var p = 0 // internal
    fileprivate func f1() {} // fileprivate
    private func f2() {} // private
}

fileprivate class FilePrivateClass { // fileprivate
    func f1() {} // fileprivate
    private func f2() {} // private

}
private class PrivateClass { // private
    func f() {} // private
}

/**getter, setter默认自动接收他们所属环境的访问级别
 ■ 可以给setter单独设置一个比getter更低的访问级别 ,用以限制写的权限
 */
//fileprivate(set) public var num = 10
//class Person {
//    private(set) var age = 0
//    fileprivate(set) public var weight: Int {
//        set {}
//        get { 10 }
//    }
//    internal(set) public subscript(index: Int) -> Int {
//        set {}
//        get { index }
//    }
//}

//public protocol Runnable {
//    func run()
//}
//public class Person : Runnable {
//    public func run() {}
//}

//public class Person {
//    private func run0() {}
//    private func eat0() {
//        run0()
//    }
//}
//extension Person {
//    private func run1() {}
//    private func eat1() {
//        run1()
//    }
//}
//extension Person {
//    private func eat2() {
//        run1()
//    }
//}

/**
 ■ 如果想在定义闭包属性的同时引用self ,这个闭包必须是lazy的(因为在实例初始化完毕之后才能引用self)
 ■ 闭包fn内部如果用到了实例成员(属性、方法)
 编译器会强制要求明确写出self*/
//class Person {
//    lazy var fn: (()->()) = {
//        [weak self] in
//        self?.run()
//    }
//    func run() { print("run") }
//    deinit { print ("deinit") }
//}


//如果lazy属性是闭包调用的结果,那么不用考虑循环引用的问题(因为闭包调用后,闭包的生命周期就结束了)

//class Person {
//    var age: Int = 0
//    lazy var getAge: Int = {
//        self.age
//    }()
//    deinit { print("deinit") }
//}

func testAccesses() {
    //不存在内存访问冲突
    func plus(_ num: inout Int) -> Int { num + 1 }
    var number = 1
    number = plus (&number)
    //存在内存访问冲突
    // Simultaneous accesses to Øx0, but modificat ion requires exclusive access
    var step = 1
    func increment(_ num:inout Int) { num += step }
    increment (&step)

    //解决内存访问冲突
    var copyOfStep = step
    increment(&copyOfStep)
    step = copyOfStep
}
func testAccesses1() {
    func balance(_ x: inout Int,_ y: inout Int) {
        let sum=x+y
        x=sum/2
        y=sum-x
    }
    var num1 = 42
    var num2 = 30

    balance(&num1, &num2) // 0K
    //balance(&num1, &num1) // Error
    
    
    struct Player {
        var name: String
        var health: Int
        var energy: Int
        mutating func shareHealth(with teammate: inout Player) {
            balance(&teammate.health, &health)
        }
    }
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    var maria = Player(name: "Maria", health: 5, energy: 10)
    
    oscar.shareHealth(with: &maria) // 0K
    //oscar.shareHealth(with: &oscar) // Error
    
    
    var tulpe = (health: 10, energy: 20)
    // Error
    balance(&tulpe.health, &tulpe.energy)
    var holly = Player(name: "Holly", health: 10, energy: 10)
    // Error
    balance(&holly.health, &holly.energy)
    
    // OK
    func test() {
        var tulpe = (health: 10, energy: 20)
        balance (&tulpe.health, &tulpe.energy)
        var holly = Player(name: "Holly", health: 10, energy: 10)
        balance (&holly.health, &holly.energy)
    }
    test()
}

func pointer1() {
    var age = 10
    func test1(_ ptr: UnsafeMutablePointer<Int>) {
        ptr.pointee += 10
    }
    func test2(_ ptr: UnsafePointer<Int>) {
        print(ptr.pointee)
    }
    
    test1(&age)
    test2(&age) // 20
    print(age) // 20
    
    

}

func pointer2() {
    var age = 10
    func test3(_ ptr: UnsafeMutableRawPointer) {
        ptr.storeBytes(of: 20, as: Int.self)
    }
    func test4(_ ptr: UnsafeRawPointer) {
        print(ptr.load(as: Int.self))
    }
    test3(&age)
    test4(&age) // 20
    print(age) // 20
}

func pointer3() {
    var age = 10
    var ptr = withUnsafePointer(to: &age) { (p) -> Int in
        return 20
    }
    
}

func pointer4() {
    //获得某个变量的指针
    var age = 11
    var ptr1 = withUnsafeMutablePointer(to: &age) { $0 }
    var ptr2 = withUnsafePointer(to: &age) { $0 }
    ptr1.pointee = 22
    print(ptr2.pointee) // 22
    print(age) // 22
    var ptr3 = withUnsafeMutablePointer(to: &age) { UnsafeMutableRawPointer($0) }
    var ptr4 = withUnsafePointer(to: &age) { UnsafeRawPointer($0) }
    ptr3.storeBytes(of: 33, as: Int.self)
    print(ptr4.load(as: Int.self)) // 33
    print(age) // 33
}

func pointer5() {
    // 创建指针
    var ptr1 = UnsafeRawPointer( bitPattern: 0x100001234)
    // 创建
    var ptr = malloc(16)
    // 存
    ptr?.storeBytes(of: 11, as: Int.self)
    ptr?.storeBytes(of: 22, toByteOffset: 8, as: Int.self)
    // 取
    print((ptr?.load(as: Int.self))!) // 11
    print((ptr?.load(fromByteOffset: 8, as: Int.self))!) // 22
    free(ptr)
    
}

func pointer6() {
    var ptr = UnsafeMutableRawPointer . allocate (byteCount: 16, alignment: 1)
    ptr.storeBytes(of: 11, as: Int.self)
    ptr.advanced(by: 8).storeBytes(of: 22, as: Int.self)
    print(ptr.load(as: Int.self)) // 11
    print(ptr.advanced(by: 8).load(as: Int.self)) // 22
    ptr.deallocate()
}


func pointer7() {
    // 指针间的转换
    var ptr = UnsafeMutableRawPointer . allocate(byteCount: 16, alignment: 1)
    ptr.assumingMemoryBound(to: Int.self).pointee = 11
    (ptr + 8).assumingMemoryBound(to: Double.self).pointee = 22.0
    print(unsafeBitCast(ptr, to: UnsafePointer<Int>.self).pointee) // 11
    print(unsafeBitCast(ptr + 8, to: UnsafePointer<Double>.self).pointee) // 22.0
    ptr.deallocate()
    // unsafeBitCast是忽略数据类型的强制转换,不会因为数据类型的变化而改变原来的内存数据
    // 类似于C++ 中的reinterpret_cast
    
    class Person {}
    var person = Person()
    // personObjectAddress存储的就是堆空间地址
    var personObjectAddress = unsafeBitCast(person, to: UInt.self)
    print(UnsafeRawPointer(bitPattern: personObjectAddress))
    var p = unsafeBitCast(person, to: UnsafeRawPointer.self)
    print(p)
}

//字面量协议应用
extension Int : ExpressibleByBooleanLiteral {
    public init( booleanLiteral value: Bool) { self = value ? 1 : 0 }
}
func literal1() {
    var num: Int = true
    print(num) // 1
    //■有点类似于C+ +中的转换构造函数

    
    
    class Student : ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral, ExpressibleByStringLiteral,
                    CustomStringConvertible {
    var name: String = ""
    var score: Double = 0
        required init(floatLiteral value: Double) { self.score = value }
        required init( integerLiteral value: Int) { self.score = Double(value) }
        required init(stringLiteral value: String) { self.name = value }
        required init ( unicodeScalarLiteral value: String) { self.name = value }
        required init (extendedGraphemeClusterLiteral value: String) { self.name = value }
        var description: String { "name=\(name) , score=\(score)"}
    }
    var stu: Student = 90
    print(stu) // name=, score=90.0
    stu = 98.5
    print(stu) // name=, score=98.5
    stu = "Jack"
    print(stu) // name=Jack, score=0.0
}
//struct Point {
//    var x = 0.0, y = 0.0
//}
//extension Point : ExpressibleByArrayLiteral, ExpressibleByDictionaryLiteral {
//    init(arrayLiteral elements: Double...) {
//        guard elements.count > 0 else { return }
//        self.x = elements [0]
//        guard elements.count > 1 else { return }
//        self.y = elements [1]
//    }
//    init(dictionaryLiteral elements: (String, Double)...) {
//        for (k, v) in elements {
//            if k == "x" { self.x = v }
//            else if k == "y" { self.y = v}
//        }
//    }
//}


func literal2() {
//    var p: Point = [10.5, 20.5]
//    print(p) // Point(x: 10.5, y: 20.5)
//    p = ["x":11,"y":22]
//    print(p) // Point(x: 11.0, y: 22.0)
}
func wildcardPattern1() {
   //通配符模式 ( Wildcard Pattern )
    //■ _ 匹配任何值
    //■ _?匹配非nil值
    
    enum Life {
        case human(name: String, age:Int?)
        case animal(name: String, age:Int?)
    }
    func check(_ life: Life) {
        switch life {
        case . human(let name, _) :
            print ("human", name)
        case . animal(let name,_?):
            print("animal", name)
        default:
            print("other")
        }
    }
    check( . human( name: "Rose", age: 20)) // human Rose
    check( . human(name: "Jack", age: nil)) // human Jack
    check( . animal(name: "Dog", age: 5)) // animal Dog
    check( . animal( name: "Cat", age: nil)) // other
}
func wildcardPattern2() {
    // 枚举Caset模式 ( Enumeration Case Pattern )
    // if case语句等价于只有1个case的switch语句
    let age=2
    //原来的写法
    if age >= 0 && age <= 9 {
        print("[0, 9]")
    }
    //枚举Case模式
    if case 0...9 = age {
        print("[0, 9]")
    }
    guard case 0...9 = age else { return }
    print("[0, 9]")
    
    switch age {
    case 0...9: print("[0, 9]")
    default: break
    }
    
    
    let ages: [Int?] = [2, 3, nil, 5]
    
    for case nil in ages {
        print("有nil")
        break
    } //有nil值
    
    let points = [(1, 0), (2, 1), (3, 0)]
    for case let(x, 0) in points {
        print(x)
    } // 1 3
}

func optionalPattern() {
    //可选模式 ( Optional Pattern )
    
    let age: Int? = 42
    if case .some(let x) = age { print(x) }
    if case let x? = age { print(x) }

    let ages: [Int?] = [nil, 2, 3, nil, 5]
    for case let age? in ages {
        print (age)
    }// 2 3 5

    for item in ages {
        if let age = item {
            print(age)
        } //跟上面的for,效果是等价的
    }
    
    func check(_ num: Int?) {
        switch num {
        case 2?: print("2")
        case 4?: print("4")
        case 6?: print("6")
        case _?: print("other")
        case _: print("nil")
        }
    }
    check(4) // 4
    check(8) // other
    check(nil) // nil
}

func typeCastingPattern() {
    //类型转换模式 ( Type-Casting Pattern )
    let num: Any = 6
    switch num {
    case is Int:
        //编译器依然认为num是Any类型
        print("is Int", num)
//    case let n as Int:
//        print("as Int", n + 1)
    default:
        break
    }
    
    class Animal { func eat() { print(type(of: self), "eat") } }
    
    class Dog: Animal { func run() { print(type(of: self), "run") } }
    
    class Cat: Animal { func jump() { print(type(of: self), "jump") } }
    
    func check(_ animal: Animal) {
        
        switch animal {
        case let dog as Dog:
            dog.eat()
            dog.run()
        case is Cat:
            animal.eat()
        default: break
        }
    }
    
    // Dog eat
    // Dog run
    check(Dog())
    // Cat eat
    check(Cat())
}

func expressionPattern() {
    //表达式模式 ( Expression Pattern )
    //表达式模式在case中
    let point = (1, 2)
    switch point {
    case (0, 0):
        print("(0, 0) is at the origin.")
    case (-2...2, -2...2):
        print("(\(point.0), \(point.1)) is near the origin.")
    default:
        print("The point is at (\(point.0), \(point.1)).")
        
    }// (1, 2) is near the origin.
}
struct Student: Equatable {
    var score = 0, name = ""
    static func ~= (pattern: Int, value: Student) -> Bool { value.score >= pattern }
    static func ~= (pattern: ClosedRange<Int>, value: Student) -> Bool { pattern.contains(value.score) }
    static func ~= (pattern: Range<Int>, value: Student) -> Bool { pattern.contains(value.score) }
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name
    }
}
func expressionPattern1() {
    // TODO: - 修复
    //自定义表达式模式
    //■ 可以通过重载运算符,自定义表达式模式的匹配规则
    
    
    
    
    var stu = Student(score: 75, name: "Jack")
    switch stu {
    case 100: print(">= 100")
    case 90: print(">= 90")
    case 80..<90: print("[80, 90)")
    case 60...79: print("[60, 79]")
    case 0: print(">= 0")
    default: break
    }// [60, 79]

    if case 60 = stu {
        print(">= 60")
    } //>= 60
    var info = (Student(score: 70, name: "Jack"), "及格")
    switch info {
    case let (60, text): print(text)
    default: break
    }//及格
}
extension String {
    static func ~= (pattern: (String) -> Bool, value: String) -> Bool {
        pattern(value)
    }
}
func hasPrefix(_ s: String) -> ((String) -> Bool) { { $0.hasPrefix(s) } }
func hasSuffix(_ s: String) -> ((String) -> Bool) { { $0.hasSuffix(s) } }


                                                      
func expressionPattern0() {
    var str = "jack"
    switch str {
    case hasPrefix("j"), hasSuffix("k"):
        print("以j开头， 或以k结尾")
    default: break
    } // 以j开头， 或以k结尾
}


func isEven(_ i: Int) -> Bool { i%2 == 0 }
func isOdd(_ i: Int) -> Bool { i%2 != 0 }
extension Int {
    static func ~= (pattern: (Int) -> Bool, value: Int) -> Bool {
        pattern( value )
    }
}

func expressionPattern2() {
    var age = 10
    switch age {
    case isEven:
    print(age, "是个偶数" )
    case isOdd:
    print(age, "是个奇数")
    default: break
    }
}
prefix operator ~>
prefix operator ~>=
prefix operator ~<
prefix operator ~<=
prefix func ~> (_ i: Int) -> ((Int) -> Bool) { {$0 > i} }
prefix func ~>= (_ i: Int) -> ((Int) -> Bool) { {$0 >= i} }
prefix func ~< (_ i: Int) -> ((Int) -> Bool) { {$0 < i} }
prefix func ~<= (_ i: Int) -> ((Int) -> Bool) { {$0 <= i} }



func expressionPattern3() {
    var age = 9
    switch age {
    case ~>=0, ~<=10:
    print("1")
    case ~>10, ~<20:
    print("2")
    default: break
    } // [0, 10]
}

protocol Stackable { associatedtype Element }
protocol Container {
    associatedtype Stack : Stackable where Stack.Element: Equatable
}
extension Container where Self.Stack.Element: Hashable {}

func expressionPattern4() {
   // 可以使用where为模式匹配增加匹配条件
    var data = (10, "Jack")
    switch data {
    case let (age, _) where age > 10:
        print(data.1, "age>10" )
    case let (age, _) where age > 0:
        print(data.1, "age>0")
    default: break
    }
    
    var ages = [10, 20, 44, 23, 55]
    for age in ages where age > 30 {
        print (age)
    }//44 55
    
    
    func equal<S1: Stackable, S2: Stackable>(_ s1: S1,_ s2: S2) -> Bool where S1.Element == S2.Element, S1.Element: Hashable {
        return false
    }
    
    
}
// 条件编译
// 操作系统: macOS\i0S\tvOS\watchOS\Linux\Android\Windows\FreeBSD
#if os(macOS) || os(iOS)
// CPU#LMJ: i386x&6_ _64(a rma rm64
#elseif arch(x86_64) || arch(arm64 )
// swift版本
#elseif swift(<5) && swift(>=3)
// 模拟器
#elseif targetEnvironment(simulator)
// 可以导入某模块
#elseif canImport(Foundation)
#else
#endif


    
func expressionPattern5() {
// debug模式
#if DEBUG
// release模式
#else
    
#endif

#if TEST
    print("test")
#endif

#if OTHER
    print("other")
#endif
    
}
func log<T>(_ msg: T ,
            file: NSString = #file,
            line: Int = #line,
            fn: String = #function) {
#if DEBUG
    let prefix = "\(file.lastPathComponent)_\(line)_\(fn):"
    print(prefix, msg)
#endif
}
//系统版本检测

func expressionPattern6() {
    if #available(iOS 10, macOS 10.12, *) {
    //对于i0S平台，只在i0S10及以，上版本执行
    //对于mac0S平台，只在mac0S 10. 12及以上版本执行
    //最后的*表示在其他所有平台都执行
    }
}
//API可用性说明
@available(iOS 10, macOS 10.15, *)
class PersonX {}
struct StudentX {
    @available(*, unavailable, renamed: "study" )
    func study_() {}
    func study() {}
    
    @available( iOS, deprecated: 11)
    @available (macOS, deprecated: 10.12)
    func run() {}
    
}
//■更多用法参考: https://docs.swift.org/swift-book/ReferenceManual/Attributes.html

#warning("undo")

// iOS程序的入口
//在AppDelegate上面默认有个 @UIApplicationMain标记 , 这表示
//编译器自动生成入口代码(main函数代码)，自动设置AppDelegate为APP的代理
//也可以删掉 @UIApplicationMain , 自定义入口代码 : 新建一个main.swift文件

//import UIKit
//class HYApplication : UIApplication {}
//UIApplicationMain(CommandLine.argc,
//                  CommandLine.unsafeArgv,
//                  NSStringFromClass(HYApplication.self),
//                  NSStringFromClass(AppDelegate.self))

// swift调OC
func oc() {
    var p = AEPerson(age: 10, name: "Jack" )
    p.age = 18
    p.name = "Rose"
    p.run() // 18 Rose -run
    p.eat("Apple", other: "Water") // 18 Rose -eat Apple Water
    AEPerson.run() // Person +run
    AEPerson.eat("Pizza", other: "Banana") // Person +eat Pizza Banana
    print(sum(10, 20)) // 30
}


//Swift调用OC - @_silgen_name
//如果C語言暴露給Swift的凾数名跟Swift中的其他凾数名冲突了
//可以在Swift中使用 @_silgen_name 修改C函数名
// C语言
//int sum(int a, int b) {}
//    return a + b;
//}
// Swift
@_silgen_name("sum") func swift_sum(_ v1: Int32, _ v2: Int32) -> Int32
func oc1() {
    print(swift_sum(10, 20)) // 30
    print(sum(10, 20)) // 30
}


//选择器 ( Selector )
//Swift中依然可以使用选择器,使用#selector(name)定义一个选择器
//ロ必須是被@objcMembers或@objc修怖的方法オ可以定义选择器
@objcMembers class Person2: NSObject {
    func test1(v1: Int) { print("test1") }
    func test2(v1: Int, v2: Int) { print("test2(v1:v2:)") }
    func test2(_ v1: Double,_ v2: Double) { print("test2(_ :_ _:)") }
    
    func run() {
        perform( #selector(test1))
        perform(#selector(test1(v1:)))
        perform(#selector(test2(v1:v2:)))
        perform(#selector(test2(_:_:)))
        perform(#selector(test2 as (Double, Double) -> Void))
    }
}
//String
//■Swift的字符串类型String ,跟OC的NSSt ring ,在API设计上还是有较大差异
func testString() {
    //空字符串
    var emptyStr1 = ""
    var emptyStr2 = String()
    
    var str1 = "123456"
    print(str1.hasPrefix("123")) // true
    print(str1.hasSuffix("456")) // true
    
    var str: String = "1"
    // 拼接， jack_rose
    str.append("_2")
    //重载运算符+
    str = str + "_3"
    //重载运算符+=
    str += "_4"
    // \()插值
    str = "\(str)_5"
    //长度，9，1_2_3_4_5
    print(str.count)
}

func testString1() {
    var str = "1_2"
    // 1_2_
    str.insert("_", at: str.endIndex)
    //1_2_3_4
    str.insert(contentsOf: "3_4", at: str.endIndex)
    // 1666_2_3_4
    str.insert(contentsOf: "666", at: str.index(after: str.startIndex))
    // 1666_2_3_8884
    str.insert(contentsOf: "888", at: str.index(before: str.endIndex) )
    // 1666hello_ 2_ _3_ 8884
    str.insert(contentsOf: "hello", at: str.index(str.startIndex, offsetBy: 4))
}
func testString2() {
    var str = "1_2"
    //1_2_
    str.insert("_", at: str.endIndex)
    //1_2_3_4
    str.insert(contentsOf: "3_4", at: str.endIndex)
    // 1666_2_3_ 4
    str.insert(contentsOf: "666", at: str.index(after: str.startIndex) )
    // 1666_2_3_8884
    str.insert(contentsOf: "888", at: str.index(before: str.endIndex))
    // 1666hello_2_3_8884
    str.insert(contentsOf: "hello", at: str.index(str.startIndex, offsetBy: 4))
    
    // 666hello_2_3_8884
    str.remove(at: str.firstIndex(of: "1")!)
    // hello_2_3_8884
    str.removeAll { $0 == "6" }
    var range = str.index(str.endIndex, offsetBy: -4)..<str.index(before: str.endIndex)
    // hello_2_3_4
    str.removeSubrange(range)
}
// String可以通过下标, prefix、suffix等截取子串,子串类型不是String ,而是Substring
func testSubstring() {
    var str="1_2_3_4_5"
    // 1_2
    var substr1 = str.prefix(3)
    //4_5
    var substr2 = str.suffix(3)
    // 1_2
    var range = str.startIndex..<str.index(str.startIndex, offsetBy: 3)
    var substr3 = str[range]
    // 最初的String, 1_2_3_4_5
    print(substr3.base)
    // Substring -> String
    var str2 = String(substr3)
    // ■Substring和它的base ,共享字符串数据
    // Substring转为String时, 会重新分配新的内存存储字符串数据
}
func testSubstring1() {
    for c in "jack" {// c是Character类型
        print(c)
    }
    var str = "jack"
    // c是Character类型
    var c = str[str.startIndex]
    
}
func testSubstring2() {}
// 多行String
let str = """
1
    "2"
3
    '4'
"""
//缩进以结尾的3引号为对齐线
let str9 = """
        1
            "2"
        3
            '4'
        """

#warning("要显示3引号有问题啊")
// 如果要显示3引号， 至少转义1个引号
let str0 = """
Escaping the first quote \"\""
Escaping two quotes \"\""
Escaping all three quotes \"\"\"
"""

//以下2个字符串是等价的
let str1 = "These are the same."
let str2 = """
These are the same.
"""

// String 与 NSString
// String 与 NSString之间可以随时随地桥接转换
//如果你觉得String的API过于复杂难用,可以考虑将String转为NSString
var str10: String = "jack"
var str20: NSString = "rose"
var str3 = str1 as NSString
var str4 = str2 as String
// ja
var str5 = str3.substring (with: NSRange(location: 0, length: 2))
//print(str5)
// String使用==运算符
//ロNSString使用isEqual方法,也可以使用==返算符(本貭还是调用了isEqual方法)

//可选协议

// ■可以通过 @objc定义可选协议,这种协议只能被class遵守
@objc protocol Runnable {
    func run1()
    @objc optional func run2()
    func run3()
}
class Dog: Runnable {
    func run3() { print ("Dog run3") }
    func run1() { print("Dog run1") }
}
//var d = Dog()
//d.run1() // Dog run1
//d.run3() // Dog run3


//dynamic
//■被 @objc dynamic 修怖的内容会具有劫恣性,比如凋用方法会走runtime那一套流程
//class Dog: NSObject {
//    @objc dynamic func test1() {}
//    func test2() {}
//}
//var d = Dog()
//d.test1()
//d.test2()

//KVC\KVO
//■Swift支持KVC\KVO的条件
//属性所在的类、监听器最终继承自NSObject
//用 @objc dynamic 修饰对应的属性
class Observer: NSObject {
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        print ("observeValue", change?[.newKey] as Any)
    }
}


//class Person: NSObject {
//    @objc dynamic var age: Int = 0
//    var observer: Observer = Observer()
//    override init() {
//        super.init( )
//        self.addObserver(observer,
//                          forKeyPath: "age",
//                          options: .new,
//                          context: nil)
//    }
//    deinit {
//        self.remove0bserver(observer,
//                            forKeyPath: "age")
//    }
//}
//var p = Person( )
//// observeValue Optional(20)
//p.age = 20
//// observeValue Optional(25)
//p.setValue(25, forKey: "age")

//block方式的KVO
//class Person: NSObject {
//    @objc dynamic var age: Int = 0
//    var observation: NSKeyValueObservation?
//    override init() {
//        super.init( )
//        observation = observe(\Person.age, options: .new, changeHandler: { (person, change) in
//            print(change.newValue as Any)
//        })
//    }
//}
//var p = Person( )
//// Optional(20)
//p.age = 20
////  Optional(25)
//p.setValue(25, forKey: "age")

//关联对象( Associated Object )

//在Swift中, class依然可以使用关联对象
//默认情况, extension不可以增加存储属性
//借助关联对象,可以实现类似extension为class增加存储属性的效果
//class Person {}
//extension Person {
//    private static var AGE_KEY: Void?
//    var age: Int {
//        get {
//            (objc_getAssociatedObject(self, &Self.AGE_KEY) as? Int) ?? 0
//        }
//        set {
//            objc_setAssociatedObject(self, &Self.AGE_KEY, newValue, .OBJC_ASSOCIATION_ASSIGN)
//        }
//    }
//}

import UIKit

//资源名管理
//enum R {
//    enum string: String {
//        case add = "添加"
//    }
//    enum image: String {
//        case logo
//    }
//    enum segue: String {
//        case login_main
//    }
//}
func testR() {
//    let img = UIImage(named: "logo")
//    let btn = UIButton(type: .custom)
//    btn.setTitle("添加", for: .normal)
//    performSegue(withIdentifier: "login_main", sender: self)
    
//    let img = UIImage(R.image.logo)
//    let btn = UIButton(type: .custom)
//    btn.setTitle(R.string.add, for: .normal)
//    performSegue ( withIdentifier: R.segue.login_main, sender: self)
}


//■这种做法实际上是参考了Android的资源名管理方式

//extension UIImage {
//    convenience init?(_ name :R.image) {
//        self.init(named: name.rawValue)
//    }
//}
//extension UIViewController {
//    func performSegue(withIdentifier identifier: R.segue, sender: Any?) {
//        performSegue(withIdentifier: identifier .rawValue, sender: sender)
//    }
//}
//
//extension UIButton {
//    func setTitle(_ title: R.string, for state: UIControl.State) {
//        setTitle(title.rawValue, for: state)
//    }
//}
///资源名管理的其他思路

//enum R {
//    enum image {
//        static var logo = UIImage (named: "logo")
//    }
//    enum font {
//
//        static func arial(_ size: CGFloat) -> UIFont? {
//            UIFont(name: "Arial", size: size)
//        }
//    }
//}
//
//func testR2() {
////    let img = UIImage(named: "logo")
////    let font = UIFont(name: "Arial", size: 14)
//    let img = R.image.logo
//    let font = R.font.arial(14)
//}

// 多线程开发-异步
public typealias Task = () -> Void
struct Queue {
    public static func async(_ task: @escaping Task) {
        _async(task)
    }
    public static func async(_ task: @escaping Task,
                             mainTask: @escaping Task) {
        _async(task, mainTask)
    }
    
    private static func _async(_ task: @escaping Task,
                               _ mainTask: Task? = nil) {
        let item = DispatchWorkItem( block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
    // 延迟
    @discardableResult
    public static func delay(_ seconds: Double,
                             _ block: @escaping Task) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds,
                                      execute: item)
        return item
    }
        // 异步延迟
    @discardableResult
    public static func asyncDelay(_ seconds: Double ,
                                  _ task: @escaping Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task)
    }
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ task: @escaping Task,
                                  _ mainTask: @escaping Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task, mainTask)
    }
    
    private static func _asyncDelay(_ seconds: Double,
                                    _ task: @escaping Task,
                                    _ mainTask: Task? = nil) -> DispatchWorkItem {
    let item = DispatchWorkItem(block: task)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds,
                                          execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
}

//多线程开发-once
//■ dispatch_once在Swift中已被废弃,取而代之
//* 可以用类型属性或者全局变量\常量
//* 默认自带lazy + dispatch_once效果
let age1: Int = {
print( 666)
return 10
}()
class ViewController: UIViewController {
    static let age2: Int = {
        print (888)
        return 20
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (age1)
        print(age1)
        // 666 10 10
        print (ViewController.age2)
        print (ViewController.age2)
        // 888 20 20
    }
}
//多线程开发-加锁
//gcd信号量
class Cache {
    private static var data = [String: Any]()
    private static var lock = DispatchSemaphore(value: 1)
    
    static func set(_ key: String, value: Any) {
        lock.wait()
        defer { lock.signal() }
        data [key] = value
    }
}
    
//Foundation
class Cache1 {
    private static var lock = NSLock()
    static func set(_ key: String,_ value: Any) {
        lock.lock()
        defer { lock.unlock() }
    }
}

class Cache2 {
    private static var lock = NSRecursiveLock()
    static func set(_ key: String,_ value: Any) {
        lock.lock()
        defer { lock.unlock() }
    }
}
