//
//  ICButtonExtension.swift
//  ICMS
//
//  Created by Adam on 2021/2/26.
//

import Foundation
import UIKit

enum ButtonLayout {
 case leftImage
 case rightImage
 case topImage
 case bottomImage
}
 
extension UIButton {
  
    func setLayoutType(type: ButtonLayout, space: CGFloat = 2.0) {
        let image: UIImage? = self.imageView?.image
        let imageWidth: CGFloat = (self.imageView?.frame.size.width)!
        let imageHeight: CGFloat = (self.imageView?.frame.size.height)!
        
        var labelWidth: CGFloat =  (self.titleLabel?.frame.size.width)!
        var labelHeight: CGFloat = (self.titleLabel?.frame.size.height)!
        if Float(UIDevice.current.systemVersion)! >= 8.0 {
            let size = self.titleLabel?.intrinsicContentSize
            labelWidth = size!.width
            labelHeight = size!.height
        }
        var titleTop: CGFloat = 0
            var titleLeft: CGFloat = 0
        var titleBottom: CGFloat = 0
        var titleRight: CGFloat = 0
        var imageTop: CGFloat = 0
        var imageLeft: CGFloat = 0
        var imageBottom: CGFloat = 0
        var imageRight: CGFloat = 0
        
        switch type {
        case .leftImage:
            debugPrintLog("系统默认的方式")
            //    图片在左、文字在右
            imageTop = 0
            imageBottom = 0
            imageLeft =  -space / 2.0
            imageRight = space / 2.0
            
            titleTop = 0
            titleBottom = 0
            titleLeft = space / 2
            titleRight = -space / 2
        case .rightImage:
            imageTop = 0
            imageBottom = 0
            imageRight = -(labelWidth + space / 2.0)
            imageLeft = labelWidth + space / 2.0
            
            titleTop = 0
            titleLeft = -(imageWidth + space / 2.0)
            titleBottom = 0
            titleRight = imageWidth + space / 2.0
        case .topImage:
            imageTop = -(labelHeight / 2.0 + space / 2.0)//图片上移半个label高度和半个space高度  给label使用
            imageBottom = (labelHeight / 2.0 + space / 2.0)
            imageLeft = imageWidth / 2.0
            imageRight = -imageWidth / 2.0
            
            titleLeft = -labelWidth / 2.0
            titleRight = labelWidth / 2.0
            titleTop = imageHeight / 2.0 + space / 2.0//文字下移半个image高度和半个space高度
            titleBottom = -(imageHeight / 2.0 + space / 2.0)
        default: break
            
        }
        let imageEdgeInsets = UIEdgeInsets(top: imageTop, left: imageLeft, bottom: imageBottom, right: imageRight)
        let titleEdgeInsets = UIEdgeInsets(top: titleTop, left: titleLeft, bottom: titleBottom, right: titleRight)
        
        self.imageEdgeInsets = imageEdgeInsets
        self.titleEdgeInsets = titleEdgeInsets
    }
}
