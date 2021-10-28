//
//  AEProgressBarViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/10/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEProgressBarViewController: BaseViewController {
    
    var shapeLayer = CAShapeLayer()
    let urlString = "https://pics7.baidu.com/feed/37d12f2eb9389b5038d39bfbeef5b1d4e6116eb0.jpeg?token=f63d57e095f197046906ccd4a63d51e2"
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .black
        return label
    }()
    
    var downloadTask: URLSessionDownloadTask?
    
    var pulsatingLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func configEvent() {
        super.configEvent()
        
    }
    override func configUI() {
        super.configUI()
        
        view.backgroundColor = UIColor.backgroundColor
        

        let y = 100
        for item in 0...3 {
            let progressBar = AEProgressView(frame: CGRect(x: 100, y: y*(1 + item), width: 80, height: 80))
            self.view.addSubview(progressBar)
        }
//        setupNotificationObservers()
//
//        view.backgroundColor = UIColor.backgroundColor
//
//        setupCircleLayers()
//
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
//
//        setupPercentageLabel()
    }
    
    
    // MARK: - Navigation
    
    
}

extension AEProgressBarViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    private func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 20
        layer.fillColor = fillColor.cgColor
        layer.lineCap = .round
        layer.position = view.center
        return layer
    }
    
    private func setupPercentageLabel() {
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
    }
    
    private func setupCircleLayers() {
        pulsatingLayer = createCircleShapeLayer(strokeColor: .clear, fillColor: UIColor.pulsatingFillColor)
        view.layer.addSublayer(pulsatingLayer)
        animatePulsatingLayer()
        
        let trackLayer = createCircleShapeLayer(strokeColor: .trackStrokeColor, fillColor: .backgroundColor)
        view.layer.addSublayer(trackLayer)
        
        shapeLayer = createCircleShapeLayer(strokeColor: .outlineStrokeColor, fillColor: .clear)
        
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
    }
    
    private func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.5
        animation.duration = 0.8
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
                basicAnimation.duration = 2
                basicAnimation.fillMode = .forwards
                basicAnimation.isRemovedOnCompletion = false
                shapeLayer.add(basicAnimation, forKey: "stokeAnimation")
    }
    
    
    func beginDownloadingFile() {
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
        
        guard let url = URL(string: urlString) else { return }
        downloadTask = urlSession.downloadTask(with: url)
        downloadTask?.resume()
    }
}

extension AEProgressBarViewController: URLSessionDelegate {
    
    
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
         let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)

         DispatchQueue.main.async {
             self.percentageLabel.text = "\(Int(percentage * 100))%"
             self.shapeLayer.strokeEnd = percentage
         }

         print(percentage)
     }
}

extension UIColor {

    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }

    static let backgroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
    static let outlineStrokeColor = UIColor.rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = UIColor.rgb(r: 56, g: 25, b: 49)
    static let pulsatingFillColor = UIColor.rgb(r: 86, g: 30, b: 63)
}
