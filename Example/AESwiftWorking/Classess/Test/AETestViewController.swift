//
//  AETestViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/11/5.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AETestViewController: HomeViewController {
    private weak var someViewRef: UIView?

    var customButton = AECustomButton()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func configEvent() {
        super.configEvent()
        
        dataArray = ["文本左图片右","文本右图片左","文本上图片下","文本下图片上","添加圆角","添加阴影","添加渐变色","添加高亮色","移除文本","移除圆角","移除图片","移除阴影","移除渐变色","重置"]
    }
    
    override func configUI() {
        super.configUI()
        
        self.tableView.snp.remakeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(self.topLayoutGuide.snp.top).offset(0)
                make.bottom.equalTo(self.bottomLayoutGuide.snp.bottom)
            }
            make.left.equalTo(0)
            make.width.equalTo(ScreenWidth*0.5)
        }
        
        view.addSubview(customButton)
        customButton.backgroundColor = .gray
        customButton.frame = CGRect(x: ScreenWidth*0.5+10, y: view.frame.size.height/2 - 40, width: ScreenWidth*0.5 - 20, height: 120)
        
        
        let someView = someViewRef <- UIView(frame: CGRect(x: ScreenWidth*0.5+10, y: view.frame.size.height/2 - 40 - 120, width: ScreenWidth*0.5 - 20, height: 100))
        view.addSubview(someView)
        someViewRef?.backgroundColor = .red
        
        test1()
    }
    
    func test1() {
        
        let array = ["A", "A", "B", "A", "C"]

        // 1.
        var count = 0
        for value in array {
            if value == "A" {
                count += 1
            }
        }
        print(count)
        // 2.
        count = 0
        for value in array where value == "A" {
            count += 1
        }
        print(count)
        // 3.
        count = array.filter { $0 == "A" }.count
        print(count)
        
        count = array.count(where: { $0 == "A" }) // 2
        print(count)
        count = array.dropLast(2).count(where: { $0 == "A" })
        print(count)
    }

    func test2() {
        // MARK: - 推荐后面两种写法：
        //❌
        for subView in view.subviews {
            if let button = subView as? UIButton {
                //不可描述的事情
            }
        }

        //✅
        for case let button as UIButton in view.subviews {
            //不可描述的事情
        }

        //✅
        for button in view.subviews where button is UIButton {
            //不可描述的事情
        }
        
        // MARK: - for 循环，要拿到下标值
        //❌
        var index: Int = 0
        for subView in view.subviews {
            //不可描述的事情
            index += 1
        }

        //✅
        for index in 0..<view.subviews.count {
            let subView = view.subviews[index]
            //不可描述的事情
        }

        //✅
        //index 和 subView 在循环体中都能使用到
        for (index, subView) in view.subviews.enumerated() {
            //不可描述的事情
        }

        //只用到 index
        for (index, _) in view.subviews.enumerated() {
            //不可描述的事情
        }

        //只用到 subView
        for (_, subView) in view.subviews.enumerated() {
            //不可描述的事情
        }
        
        // MARK: - filter 是 Swift 中几个高级函数之一，过滤集合中的元素时非常的好用
        let article1 = ArticleModel(title: "11", content: "内容1", articleID: "11111", comments: [])

        let article2 = ArticleModel(title: "11", content: "内容2", articleID: "22222", comments: [])

        let article3 = ArticleModel(title: "33", content: "内容3", articleID: "3333", comments: [])

        let articles = [article1, article2, article3]

        //❌
        if let article = articles.filter({ $0.articleID == "11111" }).first {
            print("\(article.title)-\(article.content)-\(article.articleID)")
        }

        //✅
        if let article = articles.first(where: {$0.articleID == "11111"}) {
            print("\(article.title)-\(article.content)-\(article.articleID)")    //11-内容1-11111
        }
        
        // MARK: - contains(where: )
        //❌
        if !articles.filter({ $0.articleID == "11111" }).isEmpty {
            //不可描述的事情
        }

        //✅
        if articles.contains(where: { $0.articleID == "11111"}) {
            //不可描述的事情
        }
        
        // MARK: - 当循环体内的逻辑比较简单时，forEach 往往比 for...in...来的更加简洁：
        func removeArticleBy(ID: String) {
            //删库跑路
        }

        //❌
        for article in articles {
            removeArticleBy(ID: $0.articleID)
        }

        //✅
        articles.forEach { removeArticleBy(ID: $0.articleID) }
        
        
        //
    }
}
// MARK: - 计算属性 vs 方法 我们知道计算属性本身不存储数据，而是在 get 中返回计算后的值，在 set 中设置其他属性的值，所以和方法很类似，但比方法更简洁。一起来看下面的示例：
//❌
//class YourManager {
//    static func shared() -> YourManager {
//        //不可描述的事情
//    }
//}
//
//let manager = YourManager.shared()

//❌
extension Date {
    func formattedString() -> String {
        //不可描述的事情
    }
}

//let string = Date().formattedString()


//✅
//class YourManager {
//    static var shared: YourManager {
//        //不可描述的事情
//    }
//}
//
//let manager = YourManager.shared
//
////✅
//extension Date {
//    var formattedString: String {
//        //不可描述的事情
//    }
//}

//let string = Date().formattedString

/*协议 vs 子类化
 
 尽量使用协议而不是继承。协议可以让代码更加灵活，因为类可同时遵守多个协议。
 此外，结构和枚举不能子类化，但是它们可以遵守协议，这就更加放大了协议的好处

 Image
 Struct vs Class

 尽可能使用 Struct 而不是 Class。Struct 在多线程环境中更安全，更快。

 它们最主要的区别， Struct 是值类型，而 Classe 是引用类型，这意味着 Struct 的每个实例都有它自己的唯一副本，而 Class 的每个实例都有对数据的单个副本的引用。

 这个链接是苹果官方的文档，解释如何在 Struct 和 Class 之间做出选择。
 developer.apple.com/documentati…
 */

extension AETestViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title: String = dataArray?[indexPath.row] as! String
        switch title{
        case "文本左图片右":
            customButton.setTitle("文本呀")
            customButton.layout = .titleLeft
            customButton.setImage(UIImage(named: "successed_img_icon"))
        case "文本右图片左":
            customButton.setTitle("文本呀")
            customButton.layout = .titleRight
            customButton.setImage(UIImage(named: "successed_img_icon"))
        case "文本上图片下":
            customButton.setTitle("文本呀")
            customButton.layout = .titleTop
            customButton.setImage(UIImage(named: "successed_img_icon"))
        case "文本下图片上":
            customButton.setTitle("文本呀")
            customButton.setTitleColor(UIColor.black)
            customButton.layout = .titleBottom
            customButton.setImage(UIImage(named: "successed_img_icon"))
        case "添加圆角":
            customButton.layer.cornerRadius = 20
        case "添加阴影":
            customButton.layer.shadowRadius = 20
            customButton.layer.shadowOffset = CGSize(width: 10, height: 20)
            customButton.layer.shadowColor = UIColor.red.cgColor
            customButton.layer.shadowOpacity = 1
        case "添加渐变色":
            customButton.gradientColor(colors: [UIColor.red.cgColor,UIColor.blue.cgColor])
        case "添加高亮色":
            customButton.hightlightTextColor = .white //文本
            customButton.hightlightBackColor = .orange //normal
            customButton.gradientHightlightBackColors = [UIColor.yellow.cgColor,UIColor.green.cgColor]//渐变
        case "移除文本":
            customButton.titleLabel.text = nil
        case "移除圆角":
            customButton.layer.cornerRadius = 0
            customButton.updateLayout()
        case "移除图片":
            customButton.imageView.image = nil
        case "移除阴影":
            customButton.layer.shadowColor = UIColor.clear.cgColor
        case "移除渐变色":
            customButton.removeGradientLayer()
        case "重置":
            customButton.titleLabel.text = nil
            customButton.imageView.image = nil
            customButton.layer.shadowRadius = 0
            customButton.layer.shadowColor = nil
            customButton.layer.shadowOpacity = 0
            customButton.layer.shadowOffset = CGSize(width: 0, height: 0)
            customButton.layer.cornerRadius = 0
            customButton.gradientHightlightBackColors = [nil]
            customButton.hightlightTextColor = nil
            customButton.removeGradientLayer()
            customButton.updateLayout()
     
        default:
            break
        }
    }
}
