//
//  AEFormSectionHeaderView.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/20.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
typealias AESectionClosure = (_ data: Any?) -> Void

class AEFormSectionHeaderView: UITableViewHeaderFooterView {

    
    var sectionClosure : AESectionClosure?
    
    var model: AEFormListModel? {
        didSet {
            guard let m = model else {return}
            titleLabel.text = m.title
            subLabel.text = m.subTitle
            moreBtn.isHidden = (m.moreActionTitle?.count ?? 0) <= 0
            setNeedsDisplay()
        }
    }
    
    // 标题
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.colorHex(0x655A72)
        backView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(8)
            make.bottom.equalToSuperview().offset(-15)
        }
        return label
    }()
    // 子标题
    private lazy var subLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        label.textAlignment = NSTextAlignment.right
        backView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right)
            make.height.top.equalTo(titleLabel)
//            make.right.equalToSuperview().offset(-100)
        }
        return label
    }()
    private lazy var moreBtn:UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("查看全部", for: .normal)
        button.setImage(UIImage(named: "show_all_icon"), for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(moreBtn(button:)), for: .touchUpInside)
        backView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(15)
            make.height.equalTo(30)
        }
        return button
    }()

    
    private lazy var backView: AEBaseView = {
        let view = AEBaseView()
        view.backgroundColor = formBackgroundColor
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return view
    }()
    

    func configEvent() {
        
    }
    
    func configUI() {
        
        let _ = backView
        let _ = titleLabel
        
        let _ = subLabel
        
        
        let _ = moreBtn

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        moreBtn.setLayoutType(type: .rightImage, space: 12)

    }
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
    }
    
    
    @objc func moreBtn(button: UIButton) -> Void {
        AESwiftWorking_Example.endEditing()
        guard let headerMoreBtnClick = sectionClosure else { return }
        headerMoreBtnClick(nil)
    }
    
    var section:  Int?

    
    class func loadCode(tableView: UITableView, section: Int) -> AEFormSectionHeaderView {
        let identifier: String = String(describing: self)
        tableView.register(AEFormSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: identifier)
        let headerView: AEFormSectionHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as! AEFormSectionHeaderView
        headerView.section = section
        headerView.configEvent()
        headerView.configUI()
        
        return headerView
    }
}

//extension AEFormSectionHeaderView {
//    /// 设置headerview自适应
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        if superview != nil {
//            snp.remakeConstraints { (make) in
//                make.width.equalTo(superview!)
//                make.edges.equalTo(superview!)
//            }
//            layoutIfNeeded()
//        }
//    }
//}
