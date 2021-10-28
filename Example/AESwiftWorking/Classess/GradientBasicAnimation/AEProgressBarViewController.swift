//
//  AEProgressBarViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/10/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEProgressBarViewController: BaseViewController {
    let shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func configEvent() {
        super.configEvent()
        
        shapeLayer.strokeEnd = 0
    }
    override func configUI() {
        super.configUI()
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.position = view.center
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        view.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.position = view.center
        
        view.layer.addSublayer(shapeLayer)
        
        
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        
        


    }


    // MARK: - Navigation


}

extension AEProgressBarViewController {
    
    @objc func handleTap() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        shapeLayer.add(basicAnimation, forKey: "stokeAnimation")
    }
}
