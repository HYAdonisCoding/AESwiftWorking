//
//  AEGroupHeaderView.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/27.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEGroupHeaderView: UIView {
    var closure: AEClosure?
    private var dataArray: [String]?
    /// 默认的选中 如果没有则选中第一个
    var defaultValue: String?
    
    
    class func headerView(_ dataArray: [String] = ["未读", "已读", "全部"], value: String?, _ closure: AEClosure?) -> AEGroupHeaderView {
        let header = AEGroupHeaderView()
        header.dataArray = dataArray
        header.configEvent()
        header.defaultValue = value ?? dataArray.first
        header.configUI()
        header.closure = closure
        return header
    }
    

    private lazy var header: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
//            if #available(iOS 11.0, *) {
//                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//            } else {
//                // Fallback on earlier versions
//                make.top.equalTo(self.topLayoutGuide.snp.top).offset(0)
//            }
            make.top.bottom.left.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        let data = dataArray ?? []
        
        for i in 0..<data.count {
            
            let view = UIView()
            view.tag = i
            let button = UIButton(type: .custom)
            button.setTitle(data[i], for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(btnClickedAction(_:)), for: .touchUpInside)
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(UIColor.colorHex(0x231A2F), for: .normal)
            button.setTitleColor(UIColor.colorHex(0xAB702D), for: .selected)
            
            if data[i] == defaultValue {
                button.isSelected = true
            }
            view.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-10)

                if i == 0 {
                    make.left.equalToSuperview().offset(20)
                    make.right.equalToSuperview().offset(-10)
                } else if i == data.count - 1 {
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-20)
                } else {
                    make.left.equalToSuperview().offset(10)
                    make.right.equalToSuperview().offset(-10)
                }
                make.height.equalTo(30)
            }
            button.layer.cornerRadius = 15
            button.layer.borderColor = UIColor.colorHex(0xD3D1D7).cgColor
            button.layer.borderWidth = 1
            button.layer.masksToBounds = true
            if data[i] == defaultValue {
                button.isSelected = true
                button.layer.borderColor = UIColor.colorHex(0xAB702D).cgColor
            }
            stackView.addArrangedSubview(view)

        }
        
        return stackView
    }()

}

extension AEGroupHeaderView {

    func configEvent() {
//        super.configEvent()
    }
    
    func configUI() {
//        super.configUI()
        let _ = header
        
    }
    
    @objc func btnClickedAction(_ button: UIButton) {
        button.isSelected = true
        for (_, item) in header.arrangedSubviews.enumerated() {
            if let view = item as? UIView {
                let btn = view.subviews.first as? UIButton
                
                if button == btn {
                    btn?.layer.borderColor = UIColor.colorHex(0xAB702D).cgColor

                } else {
                    btn?.isSelected = false
                    btn?.layer.borderColor = UIColor.colorHex(0xD3D1D7).cgColor

                }
            }
            
        }
        guard let closure = closure else { return }
        closure(button.tag)
    }
}
