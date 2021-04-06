//
//  AEArcSelectionView.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/6.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

typealias ArcSelectionClosure = (_ index: Int, _ title: String) -> Void

class AEArcSelectionView: UIView {

    var titleArray: [String]?
    var closure: ArcSelectionClosure?
    
    let myStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var backView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.colorHex_Alpha(value: 0x000000, alpha: 0.3)
        return view
    }()
    
    private lazy var bottomView: AEArcView = {
        let view = AEArcView(frame: CGRect.zero)
        view.backgroundColor = UIColor.clear
        view.layer.masksToBounds = true
        return view
    }()
    
    
    private lazy var cancelBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.white
        button.setImage(UIImage(named: "close_icon"), for: .normal)
        button.contentHorizontalAlignment = .center
        button.tag = 0
        button.setTitleColor(UIColor.colorHex(0xAB702D), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(buttonClickedAction(button:)), for: .touchUpInside)
        return button
    }()
    
    class func shared(titleArray: [String] = ["发布", "接收", "我的消息"], closure: @escaping ArcSelectionClosure) {
        let view = AEArcSelectionView(frame: UIScreen.main.bounds)
        view.closure = closure
        view.titleArray = titleArray
        view.configUI()
        UIApplication.shared.keyWindow?.addSubview(view)
        view.show()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func configUI() {
        self.addSubview(backView)
        backView.addSubview(bottomView)
        bottomView.addSubview(myStackView)
        for (idx, title) in titleArray!.enumerated() {
            let view = UIView()
            let image = UIImage(named: title)!
            let imageView = UIImageView(image: image)
            let lbl = UILabel()
            lbl.text = title
            lbl.adjustsFontSizeToFitWidth = true
            lbl.textAlignment = .center
            lbl.textColor = UIColor.black
            view.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.width.equalTo(60)
                make.height.equalTo(60)
                make.centerX.equalToSuperview()
            }
            view.addSubview(lbl)
            lbl.snp.makeConstraints { (make) in
                make.top.equalTo(imageView.snp.bottom).offset(10)
                make.left.right.bottom.equalToSuperview()
            }
            view.tag = idx
            let tap = UITapGestureRecognizer(target: self, action: #selector(stackCtacklickedAction(_:)))
            view.addGestureRecognizer(tap)
            myStackView.addArrangedSubview(view)
        }
        bottomView.addSubview(cancelBtn)
    }
    func show()  {
        backView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(backView.snp.height).multipliedBy(0.4)
            make.left.right.bottom.equalToSuperview()
        }
        myStackView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(90)
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.top.equalTo(myStackView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.height.equalTo(70)
        }
        
    }
    func hide()  {
        self.removeFromSuperview()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonClickedAction(button: UIButton) -> Void {
        hide()
    }
    
    @objc func stackCtacklickedAction(_ tap: UITapGestureRecognizer) -> Void {
        guard let closure = closure else {
            hide()
            return
        }
        let tag = tap.view?.tag ?? 0

        closure(tag, titleArray![tag])
        hide()
    }

}
