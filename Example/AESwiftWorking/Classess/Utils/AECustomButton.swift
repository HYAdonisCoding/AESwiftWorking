//
//  AECustomButton.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/11/5.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

public class AECustomButton: UIControl {
    /// 布局类型 (同时有标题和图片的时候生效)
    enum Layout {
        /// 标题在左
        case titleLeft
        /// 标题在右
        case titleRight
        /// 标题在上
        case titleTop
        /// 标题在下
        case titleBottom
    }

    var layout: Layout = .titleLeft{
        didSet{
            updateLayout()
        }
    }
    /// 标题
    lazy var titleLabel = ButtonLabel()

    /// 图片
    lazy var imageView = ButtonImageView()
    
    /// 水平间距
    var horizontalSpace: CGFloat = 2.0

    /// 竖直间距
    var verticalSpace: CGFloat = 2.0
    
    /// 按钮点击高亮背景色
    var hightlightBackColor: UIColor?
    
    /// 按钮点击高亮文本颜色
    var hightlightTextColor: UIColor?
    
    /// 渐变高亮色
    var gradientHightlightBackColors: [CGColor?] = []
    
    /// 保存上次文本颜色
    private var previousTxetColor: UIColor = .black
    
    /// 保存上次背景色
    private var previousBackgroundColor: UIColor = .clear

    /// 保存上次渐变色数组
    private var previousGradientColors: [CGColor?] = []
    
    /// 渐变色数组
    private var gradientColors: [CGColor?] = []

    /// 渐变色layer
    private var gradientLayer : CAGradientLayer?
    
    /// 每组颜色所在位置（范围0~1)
    private var colorLocations: [NSNumber] = [0.0, 1.0]

    /// 开始位置 （默认是矩形左上角）
    private var startPoint = CGPoint(x: 0, y: 0)

    /// 结束位置（默认是矩形右上角）
    private var endPoint = CGPoint(x: 1, y: 0)
    
    convenience init() {
        self.init(frame: CGRect.zero)
        backgroundColor = .clear
        initViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func initViews() {
        addSubview(titleLabel)
        titleLabel.isHidden = true
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        /// 不管是点语法设值还是方法设值都在这里处理
        titleLabel.updateFrame = { [unowned self] in
            titleLabel.isHidden = titleLabel.text == nil ? true : false
            updateLayout()
        }
        
        
        addSubview(imageView)
        imageView.isHidden = true
        imageView.setButtonImage = { [unowned self] in
            imageView.isHidden = imageView.image == nil ? true : false
            updateLayout()
        }
    }

    /// 设置文本
    func setTitle(_ text: String?) {
        titleLabel.text = text
    }

    /// 设置文本颜色
    func setTitleColor(_ color: UIColor?) {
        guard let color = color else { return }
        titleLabel.textColor = color
    }
    
    /// 设置图片
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
    
    /// 渐变色背景设置
    func gradientColor(colors: [CGColor?], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 0),colorLocations: [NSNumber] = [0,1]) {
        guard let gradient = gradientLayer == nil ? CAGradientLayer() : gradientLayer else { return }
        gradient.locations = colorLocations
        gradient.colors = colors as [Any]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        layer.insertSublayer(gradient, at: 0)

        gradientLayer = gradient
        gradientColors = colors
        self.colorLocations = colorLocations
        self.startPoint = startPoint
        self.endPoint = endPoint
        updateLayout()
    }
    
    /// 更新布局
    func updateLayout(){
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    /// 移除渐变层
    func removeGradientLayer(){
        gradientLayer?.removeFromSuperlayer()
        gradientHightlightBackColors.removeAll()
        gradientColors.removeAll()
    }
}

// MARK: - 控件布局
extension AECustomButton {
    override public func layoutSubviews() {
        super.layoutSubviews()
        guard frame.size.width > 0 , frame.size.height > 0 else { return }
        
        // ======== 渐变色层部分 ============
        if let gradientLayer = gradientLayer {
            // KVC取出Button圆角值，渐变层也要设置
            let cornerRadiuss = layer.value(forKeyPath: "cornerRadius") as? CGFloat
            gradientLayer.cornerRadius = cornerRadiuss ?? 0
            // 渐变色frame设置
            gradientLayer.frame = bounds
        }

        // ======== 子控件布局部分 ============
        let viewWidth = frame.size.width
        let viewHeight = frame.size.height
        let text = titleLabel.text
        let image = imageView.image
        if let text = text, let image = image {
            var imageSize = image.size
            var titleLabelSize: CGSize = CGSize.zero
            if layout == .titleLeft || layout == .titleRight {
                titleLabelSize = labelSize(text: text, maxSize: CGSize(width: viewWidth / 2 - horizontalSpace, height: viewHeight), font: titleLabel.font)
                /// 如果文本+图片的大小超过了父控件的大小 则缩小image.size
                while imageSize.width + titleLabelSize.width + horizontalSpace > viewWidth {
                    imageSize = CGSize(width: imageSize.width*0.9, height: imageSize.height*0.9)
                }
            } else {
                titleLabelSize = labelSize(text: text, maxSize: CGSize(width: viewWidth, height: viewHeight / 2 - verticalSpace), font: titleLabel.font)
                /// 如果文本+图片的大小超过了父控件的大小 则缩小image.size
                while imageSize.height + titleLabelSize.height + horizontalSpace > viewHeight {
                    imageSize = CGSize(width: imageSize.width*0.9, height: imageSize.height*0.9)
                }
            }
            
            updateViewSize(with: titleLabel, size: titleLabelSize)
            updateViewSize(with: imageView, size: imageSize)
            let horizontalSpaceImage = horizontalSpace + imageSize.width / 2.0
            let horizontalSpaceTitle = horizontalSpace + titleLabelSize.width / 2.0
            let verticalSpaceImage = verticalSpace + imageSize.height / 2.0
            let verticalSpaceTitle = verticalSpace + titleLabelSize.height / 2.0

            switch layout {
            case .titleLeft:
                titleLabel.center = CGPoint(x: viewWidth / 2.0 - horizontalSpaceImage, y: viewHeight / 2.0)
                imageView.center = CGPoint(x: viewWidth / 2.0 + horizontalSpaceTitle, y: viewHeight / 2.0)
            case .titleRight:
                titleLabel.center = CGPoint(x: viewWidth / 2.0 + horizontalSpaceImage, y: viewHeight / 2.0)
                imageView.center = CGPoint(x: viewWidth / 2.0 - horizontalSpaceTitle, y: viewHeight / 2.0)
            case .titleTop:
                titleLabel.center = CGPoint(x: viewWidth / 2.0, y: viewHeight / 2.0 - verticalSpaceImage)
                imageView.center = CGPoint(x: viewWidth / 2.0, y: viewHeight / 2.0 + verticalSpaceTitle)
            case .titleBottom:
                titleLabel.center = CGPoint(x: viewWidth / 2.0, y: viewHeight / 2.0 + verticalSpaceImage)
                imageView.center = CGPoint(x: viewWidth / 2.0, y: viewHeight / 2.0 - verticalSpaceTitle)
            }
        } else if let text = text {
            let size = labelSize(text: text, maxSize: CGSize(width: viewWidth, height: viewHeight), font: titleLabel.font)
            updateViewSize(with: titleLabel, size: size)
            titleLabel.center = CGPoint(x: viewWidth / 2.0, y: viewHeight / 2.0)
        } else if let image = image {
            updateViewSize(with: imageView, size: image.size)
            imageView.center = CGPoint(x: viewWidth / 2.0, y: viewHeight / 2.0)
        }
    }
    
    /// 更新控件大小
    func updateViewSize(with targetView: UIView , size: CGSize){
        var rect = targetView.frame
        rect.size.width = size.width
        rect.size.height = size.height
        targetView.frame = rect
    }

    /// 计算文本大小
    func labelSize(text: String?, maxSize: CGSize, font: UIFont) -> CGSize {
        guard let text = text else { return CGSize.zero }
        let constraintRect = CGSize(width: maxSize.width, height: maxSize.height)
        let boundingBox = text.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: font], context: nil)
        return boundingBox.size
    }
}



// MARK: - 按钮点击效果
public extension AECustomButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        previousBackgroundColor = backgroundColor ?? .clear
        // 渐变色
        if !gradientHightlightBackColors.isEmpty, !gradientColors.isEmpty {
            previousGradientColors = gradientColors
            gradientColor(colors:gradientHightlightBackColors,startPoint: startPoint,endPoint:endPoint,colorLocations: colorLocations)
        } else if let hightlightBackColor = hightlightBackColor {
            // 背景色
            backgroundColor = hightlightBackColor
        }
        
        // 文字高亮色
        if hightlightTextColor != nil {
            previousTxetColor = titleLabel.textColor
            titleLabel.textColor = hightlightTextColor
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if !gradientHightlightBackColors.isEmpty, !previousGradientColors.isEmpty{
            gradientColor(colors:previousGradientColors,startPoint: startPoint,endPoint:endPoint,colorLocations: colorLocations)
     
        } else if hightlightBackColor != nil  {
            backgroundColor = previousBackgroundColor
        }
        if hightlightTextColor != nil {
            titleLabel.textColor = previousTxetColor
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if !gradientHightlightBackColors.isEmpty, !previousGradientColors.isEmpty {
            gradientColor(colors:previousGradientColors,startPoint: startPoint,endPoint:endPoint,colorLocations: colorLocations)
        } else if hightlightBackColor != nil {
            backgroundColor = previousBackgroundColor
        }
        if hightlightTextColor != nil {
            titleLabel.textColor = previousTxetColor
        }
    }
}

// MARK: - 自定义按钮的lable
class ButtonLabel: UILabel {
    var updateFrame: (() -> Void)?
    /// 保证任何方式赋值都能做相应处理
    override var text: String? {
        didSet {
            updateFrame?()
        }
    }
    override var attributedText: NSAttributedString? {
        didSet {
            text = attributedText?.string
        }
    }
    
    override var font: UIFont!{
        didSet{
            updateFrame?()
        }
    }
}

// MARK: - 自定义按钮的lable
class ButtonImageView: UIImageView {
    var setButtonImage: (() -> Void)?
    /// 保证任何方式赋值都能做相应处理
    override var image: UIImage?{
        didSet{
            setButtonImage?()
        }
    }
}
