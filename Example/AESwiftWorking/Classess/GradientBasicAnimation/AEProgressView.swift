//
//  AEProgressView.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/10/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEProgressView: UIView {
    var shapeLayer = CAShapeLayer()
    
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.isUserInteractionEnabled = true
        return label
    }()
    
    
    var pulsatingLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configEvent()
        self.configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AEProgressView {
     func configEvent() {
//        super.configEvent()
        
    }
    
     func configUI() {
//        super.configUI()
        
        setupNotificationObservers()
        
        self.backgroundColor = UIColor.backgroundColor
        
        setupCircleLayers()
        
        percentageLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        setupPercentageLabel()
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width*0.5, y: self.frame.size.width*0.5), radius: self.frame.size.width*0.45, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 20*self.frame.size.width/UIScreen.main.bounds.size.width
        layer.fillColor = fillColor.cgColor
        layer.lineCap = .round
//        layer.position = self.center
        layer.frame = self.bounds
        return layer
    }
    
    private func setupPercentageLabel() {
        self.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: self.frame.size.width*0.1, y: self.frame.size.width*0.1, width: self.frame.size.width*0.8, height: self.frame.size.width*0.8)
//        percentageLabel.center = self.center
        
        
        
    }
    
    private func setupCircleLayers() {
        pulsatingLayer = createCircleShapeLayer(strokeColor: .clear, fillColor: UIColor.pulsatingFillColor)
        self.layer.addSublayer(pulsatingLayer)
        animatePulsatingLayer()
        
        let trackLayer = createCircleShapeLayer(strokeColor: .trackStrokeColor, fillColor: .backgroundColor)
        self.layer.addSublayer(trackLayer)
        
        shapeLayer = createCircleShapeLayer(strokeColor: .outlineStrokeColor, fillColor: .clear)
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        self.layer.addSublayer(shapeLayer)
    }
    
    private func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.4
        animation.duration = 0.9
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    @objc private func handleEnterForeground() {
        animatePulsatingLayer()
    }
    @objc func handleTap() {
        //        beginDownloadingFile()
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 5
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "stokeAnimation")
    }
}

