//
//  AEEmptyTViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/3/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEEmptyTViewController: HomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configUI() {
        super.configUI()
//        dataArray = []
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(reloadAction(item:)))
        
        
        tableView.dzn_tv_emptyDataSource = self
        tableView.dzn_tv_emptyDelegate = self

        let header = AETableHeaderView()
        header.backgroundColor = UIColor.green
        header.titleLabel.text = "我是组头"
        tableView.tableHeaderView = header
//        
//        let foot = AETableHeaderView()
//        foot.backgroundColor = UIColor.red
//        foot.titleLabel.text = "我是foot"
//        tableView.tableFooterView = foot
        
    }
    
}

extension AEEmptyTViewController {
    @objc func reloadAction(item: UIBarButtonItem) {
        item.style =  item.style == .done ? .plain : .done
        if item.style == .done {
            dataArray = ["1", "2", "3"]
        } else {
            dataArray = []
            // 一般情况下 再数据返回来之后再将其设置为true
//            self.showEmptyView = true
        }
        tableView.reloadData()
        tableView.dzn_tv_reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension AEEmptyTViewController: EmptyDataSource {
    /**
     配置空数据时显示的副标题（描述）
     
     - Parameter scrollView: 目标视图
     
     - Returns: 副标题（描述）
     
     */
    func description(emptyView scrollView: UIScrollView) -> NSAttributedString? {
        var attributes: [NSAttributedString.Key:Any] = [:]
        attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17)
        attributes[NSAttributedString.Key.foregroundColor] = UIColor.red
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        attributes[NSAttributedString.Key.paragraphStyle] = paragraph
        let attributedString =  NSMutableAttributedString(string: "列表数据为空啊", attributes: nil)
        let range = (attributedString.string as NSString).range(of: "列表数据")
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.6784313725, blue: 0.9450980392, alpha: 1)], range: range)
        return attributedString
    }
    
    /**
     配置空数据时显示的图片
     
     - Parameter scrollView: 目标视图
     
     - Returns: 图片
     
     */
    func image(emptyView scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "empty_img")
        
    }
    
    /**
     配置空数据时显示的按钮的标题
     
     - Parameter scrollView: 目标视图
     - Parameter state: 按钮状态
     
     - Returns: 按钮标题
     
     */
    func buttonTitle(emptyView scrollView: UIScrollView, state: UIControl.State) -> NSAttributedString? {
        var attributes: [NSAttributedString.Key:Any] = [:]
        attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 17)
        attributes[NSAttributedString.Key.foregroundColor] = UIColor.red
        attributes[.foregroundColor] = UIColor.orange
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        attributes[NSAttributedString.Key.paragraphStyle] = paragraph
        let attributedString =  NSMutableAttributedString(string: "重新加载", attributes: attributes)
        let range = (attributedString.string as NSString).range(of: "列表数据")
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0.6784313725, blue: 0.9450980392, alpha: 1)], range: range)
        return attributedString
    }
    
    /**
     配置空数据时显示的按钮图片
     
     - Parameters:
     - scrollView: 目标视图
     - state: 按钮状态
     
     - Returns: 按钮图片
     
     */
    func buttonImage(emptyView scrollView: UIScrollView, state: UIControl.State) -> UIImage? { return nil }
    
    /**
     配置空数据时显示的按钮背景图片
     
     - Parameters:
     - scrollView: 目标视图
     - Parameter state: 按钮状态
     
     - Returns: 按钮背景图片
     
     */
    func buttonBackgroundImage(emptyView scrollView: UIScrollView, forState state: UIControl.State) -> UIImage? { return nil }
    
    /**
     配置空数据时显示背景颜色
     
     - Parameter scrollView: 目标视图
     
     - Returns: 背景颜色
     
     */
    func backgroundColor(emptyView scrollView: UIScrollView) -> UIColor? { return .white }
    
    /**
     配置空数据时显示的视图的垂直偏移量
     
     - Parameter scrollView: 目标视图
     
     - Returns: 空数据时显示的视图的偏移量
     
     */
    func verticalOffset(emptyView scrollView: UIScrollView) -> CGFloat{
        return 0
    }}

extension AEEmptyTViewController: EmptyDelegate {
    /**
     配置是否强制显示空视图
     
     - Parameter scrollView: 目标视图
     
     - Returns:  是否强制显示
     - true 强制显示
     - false 不强制显示 (default)
     
     */
    func shouldBeForcedToDisplay(emptyView scrollView: UIScrollView) -> Bool {
        return false
    }
    
    /**
     配置是否允许显示空视图
     
     - Parameter scrollView: 目标视图
     
     - Returns:  是否显示
     - true 显示 (default)
     - false 不显示
     
     */
    func shouldDisplay(emptyView scrollView: UIScrollView) -> Bool {
        return true
    }
    
    /**
     配置空视图是否允许点击
     
     - Parameter scrollView: 目标视图
     
     - Returns:  是否允许点击
     - true 允许 (default)
     - false 不允许
     
     */
    func shouldAllowTouch(emptyView scrollView: UIScrollView) -> Bool {
        return true
    }
    
    /**
     配置空视图时是否允许滚动
     
     - Parameter scrollView: 目标视图
     
     - Returns:  是否允许滚动
     - true 允许 (default)
     - false 不允许
     
     */
    func shouldAllowScroll(emptyView scrollView: UIScrollView) -> Bool {
        return true
    }

    
    /**
     配置空视图时按钮点击事件
     
     - Parameters:
     - scrollView: 目标视图
     - button: 被点击的按钮
     
     */
    func didTap(emptyView scrollView: UIScrollView, button: UIButton) {
        print("didTap")
    }
    
    /**
     配置空视图将要显示的回调
     
     - Parameters:
     - scrollView: 目标视图
     
     */
    func willAppear(emptyView scrollView: UIScrollView) {
        
    }
    
    /**
     配置空视图显示后的回调
     
     - Parameters:
     - scrollView: 目标视图
     
     */
    func didAppear(emptyView scrollView: UIScrollView) {
        
    }
    
    /**
     配置空视图将要消失的回调
     
     - Parameters:
     - scrollView: 目标视图
     
     */
    func willDisappear(emptyView scrollView: UIScrollView) {
        
    }
    
    /**
     配置空视图消失后的回调
     
     - Parameters:
     - scrollView: 目标视图
     
     */
    func didDisappear(emptyView scrollView: UIScrollView){
        
    }

}
