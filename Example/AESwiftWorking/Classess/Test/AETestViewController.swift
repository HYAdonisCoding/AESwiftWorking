//
//  AETestViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/11/5.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AETestViewController: HomeViewController {
    var customButton = AECustomButton()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func configEvent() {
        super.configEvent()
        
        dataArray = ["文本左图片右","文本右图片左","文本上图片下","文本下图片上","添加圆角","添加阴影","添加渐变色","添加高亮色","移除文本","移除圆角","移除图片","移除阴影","移除渐变色","重置"]
    }
    
    override func configUI() {
        super.configUI()
        
        self.tableView.snp.remakeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(self.topLayoutGuide.snp.top).offset(0)
                make.bottom.equalTo(self.bottomLayoutGuide.snp.bottom)
            }
            make.left.equalTo(0)
            make.width.equalTo(ScreenWidth*0.5)
        }
        
        view.addSubview(customButton)
        customButton.backgroundColor = .gray
        customButton.frame = CGRect(x: ScreenWidth*0.5+10, y: view.frame.size.height/2 - 40, width: ScreenWidth*0.5 - 20, height: 120)
    }

}

extension AETestViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title: String = dataArray?[indexPath.row] as! String
        switch title{
        case "文本左图片右":
            customButton.setTitle("文本呀")
            customButton.layout = .titleLeft
            customButton.setImage(UIImage(named: "successed_img_icon"))
        case "文本右图片左":
            customButton.setTitle("文本呀")
            customButton.layout = .titleRight
            customButton.setImage(UIImage(named: "successed_img_icon"))
        case "文本上图片下":
            customButton.setTitle("文本呀")
            customButton.layout = .titleTop
            customButton.setImage(UIImage(named: "successed_img_icon"))
        case "文本下图片上":
            customButton.setTitle("文本呀")
            customButton.setTitleColor(UIColor.black)
            customButton.layout = .titleBottom
            customButton.setImage(UIImage(named: "successed_img_icon"))
        case "添加圆角":
            customButton.layer.cornerRadius = 20
        case "添加阴影":
            customButton.layer.shadowRadius = 20
            customButton.layer.shadowOffset = CGSize(width: 10, height: 20)
            customButton.layer.shadowColor = UIColor.red.cgColor
            customButton.layer.shadowOpacity = 1
        case "添加渐变色":
            customButton.gradientColor(colors: [UIColor.red.cgColor,UIColor.blue.cgColor])
        case "添加高亮色":
            customButton.hightlightTextColor = .white //文本
            customButton.hightlightBackColor = .orange //normal
            customButton.gradientHightlightBackColors = [UIColor.yellow.cgColor,UIColor.green.cgColor]//渐变
        case "移除文本":
            customButton.titleLabel.text = nil
        case "移除圆角":
            customButton.layer.cornerRadius = 0
            customButton.updateLayout()
        case "移除图片":
            customButton.imageView.image = nil
        case "移除阴影":
            customButton.layer.shadowColor = UIColor.clear.cgColor
        case "移除渐变色":
            customButton.removeGradientLayer()
        case "重置":
            customButton.titleLabel.text = nil
            customButton.imageView.image = nil
            customButton.layer.shadowRadius = 0
            customButton.layer.shadowColor = nil
            customButton.layer.shadowOpacity = 0
            customButton.layer.shadowOffset = CGSize(width: 0, height: 0)
            customButton.layer.cornerRadius = 0
            customButton.gradientHightlightBackColors = [nil]
            customButton.hightlightTextColor = nil
            customButton.removeGradientLayer()
            customButton.updateLayout()
     
        default:
            break
        }
    }
}
