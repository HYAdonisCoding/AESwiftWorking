//
//  AEMultiLinesTextView.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/7/19.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

protocol AEMultiLinesTextViewDelegate {
    func sendAction(text:String)
}

class AEMultiLinesTextView: UIView {
    // 记录一大波默认参数 用于计算
    private let textViewX: CGFloat = 1
    private let textViewY: CGFloat = 1
    private var textViewH: CGFloat = 30
    private var textViewRect: CGRect!
    private var textViewW: CGFloat = 0
    private let buttonTitle = "确认"
    private var selfFrame: CGRect!
    private var selfDefultHight: CGFloat!
    
    // 控件
    private var backgroundView: UIView! // textView背景View
    var textView: AETextView!// 输入框
    var delegate: AEMultiLinesTextViewDelegate?
    
    var text: String = "" {
        didSet {
            textView.text = text
        }
    }
    
    var placeholder: String = "" {
        didSet {
            textView.placeHolderStr = placeholder
        }
    }
    
    var countLimited: Int = Int.max
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 记录默认属性
        textViewW = self.bounds.size.width - 30
        self.backgroundColor = UIColor.init(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1)
        
        textViewRect = CGRect(x: textViewX, y: textViewY, width: textViewW, height: textViewH)
        selfFrame = self.frame
        // 创建输入框
        textView = AETextView()
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.purple
        textView.textAlignment = .right
        // 创建背景View
        self.backgroundView = UIView(frame: CGRect.zero)
        backgroundView.backgroundColor = UIColor.init(red: 199/255.0, green: 199/255.0, blue: 199/255.0, alpha: 1)
        self.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
//            make.height.equalTo(32)
        }
        backgroundView.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
            make.height.equalTo(30)
        }
        
        // 注册通知
        registNotification()
    }
    

    
    // 将要改变
    @objc func textWillChange(notification:NSNotification){
        let contentSize = self.textView.contentSize
        let height = contentSize.height+10
        
        if height != selfDefultHight {
            selfDefultHight = height
            textView.snp.updateConstraints { (make) in
                make.height.equalTo(selfDefultHight).priority(.required)
            }
            setNeedsLayout()
            /// 子视图变了高度,父视图也要变化
        }
    }
    
    @objc func sendAction(){
        if self.textView.text.count == 0 {
            print("评论为空")
        }else{
            self.textView.resignFirstResponder()
            delegate?.sendAction(text: self.textView.text)
            self.textView.text = "我有话说"
        }
    }
    
    // 注册通知
    func registNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(textWillChange(notification:)), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension AEMultiLinesTextView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.count == 0 {
            return true
        }
        
        if range.location + range.length > countLimited || range.location >= countLimited {
            return false
        }
        
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > kCountlimited {
            textView.text = String(textView.text.prefix(countLimited))
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
       
    }
}
