//
//  AEPagingFootView.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

enum PagingFooterType {
    case homePage
    case prepage
    case nextPage
    case lasePage
}

typealias PagingFooterClosure = (_ page: PagingFooterType) -> Void

class AEPagingFootView: UIView {
    var closure: PagingFooterClosure?
    var pages: Int?
    

    class func pagingFootView(value: Int = 1, _ closure: PagingFooterClosure?) -> AEPagingFootView {
        let foot = AEPagingFootView()
        foot.pages = value
        foot.configEvent()
        foot.configUI()
        foot.closure = closure
        return foot
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        // 首页
        var view = UIView()
        view .addSubview(homePageButton)
        homePageButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.right.equalToSuperview()
        }
        stackView.addArrangedSubview(view)
        // 上一页
        view = UIView()
        view .addSubview(prePageButton)
        prePageButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.right.equalToSuperview()
        }
        stackView.addArrangedSubview(view)
        // 1/21
        view = UIView()
        view .addSubview(currentLabel)
        currentLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.right.equalToSuperview()
        }
        stackView.addArrangedSubview(view)
        
        //下一页
        view = UIView()
        view .addSubview(nextPageButton)
        nextPageButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.right.equalToSuperview()
        }
        stackView.addArrangedSubview(view)
        // 尾页
        view = UIView()
        view .addSubview(lastPageButton)
        lastPageButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.right.equalToSuperview()
        }
        stackView.addArrangedSubview(view)
        
        return stackView
    }()
    
    private lazy var homePageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("首页", for: .normal)
        button.setTitleColor(UIColor.colorHex(0x9E98A7), for: .normal)
        button.addTarget(self, action: #selector(btnClickedAction(_:)), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    

    private lazy var prePageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("上一页", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
//        let width = ScreenWidth/5
//        button.configRectCorner(corner: .allCorners, radii: CGSize(width: width, height: 30))
        button.backgroundColor = UIColor.colorHex(0xAB702D)
        button.addTarget(self, action: #selector(btnClickedAction(_:)), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    private lazy var nextPageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("下一页", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.colorHex(0xAB702D)
//        let width = ScreenWidth/5
//        button.configRectCorner(corner: .allCorners, radii: CGSize(width: width, height: 30))
        button.addTarget(self, action: #selector(btnClickedAction(_:)), for: .touchUpInside)
        button.tag = 3
        return button
    }()
    private lazy var lastPageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("尾页", for: .normal)
        button.setTitleColor(UIColor.colorHex(0xAB702D), for: .normal)
        button.addTarget(self, action: #selector(btnClickedAction(_:)), for: .touchUpInside)
        button.tag = 4
        return button
    }()
    private lazy var currentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.colorHex(0x655A72)
        label.text = "1/1"
        label.textAlignment = .center
        return label
    }()
}

extension AEPagingFootView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = ScreenWidth/5
        prePageButton.configRectCorner(corner: .allCorners, radii: CGSize(width: width, height: 30))
        nextPageButton.configRectCorner(corner: .allCorners, radii: CGSize(width: width, height: 30))
    }
    
    func updatePages(_ page: Int, total: Int) {
        currentLabel.text = String(page/total)
    }
    func configEvent() {
//        super.configEvent()
    }
    
    func configUI() {
//        super.configUI()
        let _ = stackView
        currentLabel.text = "1/"+String((pages ?? 1))
    }
    
    @objc func btnClickedAction(_ button: UIButton) {
        let tag = button.tag
        var page: PagingFooterType = .homePage
        if tag == 2 {
            page = .prepage
        } else if tag == 3 {
            page = .nextPage
        } else if tag == 4 {
            page = .lasePage
        }
        
        guard let closure = closure else { return }
        closure(page)
    }
}
