//
//  AEArcView.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/6.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEArcView: UIView {
    override func draw(_ rect: CGRect) {
    
        let height: CGFloat = 30
        
        let path = UIBezierPath()
    
        path.move(to: CGPoint(x: 0, y: height))
        
        path.addQuadCurve(to: CGPoint(x: frame.size.width, y: height), controlPoint: CGPoint(x: frame.size.width / 2, y: -height))
        
    
        path.addLine(to: CGPoint(x: frame.size.width, y: frame.size.height))
    
        path.addLine(to: CGPoint(x: 0, y: frame.size.height))
        
    
        path.close()
    
        //    //  一个不透明类型的Quartz  2D绘画环境, 相当于一个画布 你可以在上面任意绘制
    
        let context = UIGraphicsGetCurrentContext()
    
        context?.addPath(path.cgPath)
    
        UIColor.white.set()
    
        context?.fillPath()
    }
}
