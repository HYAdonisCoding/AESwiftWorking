//
//  AEChoiceAndCustomPushTCell.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/20.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEChoiceAndCustomPushTCell: AEFormBaseTCell {

    override class func loadCode(tableView: UITableView, index: IndexPath) -> AEChoiceAndCustomPushTCell {
        let identifier: String = String(describing: AEChoiceAndCustomPushTCell.self)
        tableView.register(AEChoiceAndCustomPushTCell.self, forCellReuseIdentifier: identifier)
        let cell: AEChoiceAndCustomPushTCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index as IndexPath) as! AEChoiceAndCustomPushTCell
        cell.selectionStyle = .none
        cell.indexPath = index
        cell.configEvent()
        cell.configUI()

        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // 是否全员按钮
    private lazy var termlessButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true

        button.setTitle("全员", for: .normal)
        button.setImage(UIImage(named: "selected_button_icon"), for: .selected)
        button.setImage(UIImage(named: "no_selected_button_icon"), for: .normal)
        button.setTitleColor(UIColor.colorHex(0x655A72), for: .normal)
//        button.setTitleColor(UIColor.colorHex(0x040404), for: .selected)
        button.isSelected = false
        button.addTarget(self, action: #selector(termlessAction(_:)), for: UIControl.Event.touchUpInside)
        backView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalTo(titleLabel.snp.right).offset(20)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(titleLabel.snp.height)
        }
        return button
    }()
    
    // 添加按钮
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitle("添加", for: .normal)
        button.setTitleColor(UIColor.colorHex(0xAB702D), for: .normal)
//        button.setImage(UIImage(named: "right_arrow_icon"), for: .normal)
//        button.setImage(UIImage(named: "right_arrow_icon"), for: .selected)
        button.addTarget(self, action: #selector(pushCustomViewController), for: UIControl.Event.touchUpInside)
        backView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalTo(noticeLabel.snp.right).offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(titleLabel.snp.height)
        }
        return button
    }()
    
    private lazy var noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "请添加发送人"
        label.textColor = UIColor.colorHex(0xD3D1D7)
//        label.adjustsFontSizeToFitWidth = true
        backView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.greaterThanOrEqualTo(termlessButton.snp.right).offset(5)
//            make.right.equalTo(addButton.snp.left).offset(-5)
//            make.width.greaterThanOrEqualTo(ScreenWidth/2)
            make.height.equalTo(titleLabel.snp.height)
        }
        return label
    }()
    

    override func configEvent() {
        super.configEvent()
    }
    
    override func configUI() {
        super.configUI()
        
        let _ = titleLabel
        let _ = termlessButton
        let _ = noticeLabel
        let _ = addButton
        
        noticeLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        addButton.setLayoutType(type: .rightImage, space: 10)

        termlessButton.setLayoutType(type: .leftImage, space: 10)
    }
    
    override var detailModel: AEFormModel? {
        didSet {
            if (detailModel?.title?.count ?? 0) > 0 {
                titleLabel.text = detailModel?.title
            }
            if let titles = detailModel?.selectedArray {
                if titles.count > 1 {
                    termlessButton.setTitle(titles.first, for: .normal)
                }
            }
            noticeLabel.text = "请选择发送人"

            if let inpout = detailModel?.value, inpout.count > 0 {
                termlessButton.isSelected = (inpout == "全员")
                noticeLabel.text = inpout

            } else {
                termlessButton.isSelected = false
                noticeLabel.text = "请选择发送人"
            }

        }
    }
    
}

extension AEChoiceAndCustomPushTCell {
    @objc func pushCustomViewController() {
        AESwiftWorking_Example.endEditing()
        let addressVC: AddressVC = AddressVC()
        addressVC.isEdit = false

        
        if let root = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            root.pushViewController(addressVC, animated: true)
        }
    }
    
    @objc func termlessAction(_ button: UIButton) {
        AESwiftWorking_Example.endEditing()
        button.isSelected = !button.isSelected

        guard let closure = self.closure else { return }
        var selected = ""
        if button.isSelected {
            selected = "全员"
        }
        closure(selected)
    }
}
