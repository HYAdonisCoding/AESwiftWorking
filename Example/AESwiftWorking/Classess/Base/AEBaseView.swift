//
//  AEBaseView.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/3/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEBaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configEvent()
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(self) deinit")
    }
}



extension AEBaseView: ICBaseProtocol {
    @objc func configUI() {
    }
    @objc func configEvent() {
    }
}
extension AEBaseView {
    /// 设置headerview自适应
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            snp.remakeConstraints { (make) in
                make.width.equalTo(superview!)
                make.edges.equalTo(superview!)
            }
            layoutIfNeeded()
        }
    }
}

protocol ICBaseProtocol {
    func configUI()
    func configEvent()
}
