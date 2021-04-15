//
//  ICViewExtension.swift
//  ICMS
//
//  Created by Adam on 2021/3/10.
//

import Foundation
import UIKit

extension UIView {
    func pathShadow(_ color: UIColor, size: CGSize, shadowOpacity: Float, shadowRadius: CGFloat) {
        //设置阴影路径--避免离屏渲染
        let path = UIBezierPath.init(rect: self.bounds)
        
        self.layer.shadowPath = path.cgPath
        
        self.layer.shadowColor = color.cgColor

        self.layer.shadowOpacity = shadowOpacity

        self.layer.shadowOffset = size

        self.layer.shadowRadius = shadowRadius
    }
    
    private struct AssociatedKey {
        static var gradient: CAGradientLayer = CAGradientLayer()
    }
    
    public var gradient: CAGradientLayer {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.gradient) as? CAGradientLayer ?? CAGradientLayer()
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKey.gradient, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        self.gradient = CAGradientLayer()
        self.gradient.frame = self.bounds
        self.gradient.colors = colours.map { $0.cgColor }
        self.gradient.locations = locations
        self.gradient.startPoint = CGPoint(x: 0, y: 0.5)
        self.gradient.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.insertSublayer(self.gradient, at: 0)
        return gradient
    }
    /// 移除渐变
    func removeGradient() -> Void {
        self.gradient.removeFromSuperlayer()
    }
    
    func removeAllSubviews() -> Void {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}
