//
//  ICBaseHeaderView.swift
//  ICMS
//
//  Created by Adam on 2021/3/17.
//

import Foundation

class ICBaseHeaderView: AEBaseView {
    
}
extension ICBaseHeaderView {
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
