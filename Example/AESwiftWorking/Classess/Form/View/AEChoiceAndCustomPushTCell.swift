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

    //无限期
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
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(10)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(titleLabel.snp.height)
        }
        return button
    }()
    
    private lazy var dateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.colorHex(0x655A72), for: .normal)
        button.setImage(UIImage(named: "right_arrow_icon"), for: .normal)
        button.setImage(UIImage(named: "right_arrow_icon"), for: .selected)
        button.addTarget(self, action: #selector(pushCustomViewController), for: UIControl.Event.touchUpInside)
        backView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.greaterThanOrEqualTo(termlessButton.snp.right).offset(20)
            make.bottom.equalToSuperview().offset(-5)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(titleLabel.snp.height)
        }
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dateButton.setLayoutType(type: .rightImage, space: 10)

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
            dateButton.setTitle("请选择发送人", for: .normal)

            if let inpout = detailModel?.value {
                termlessButton.isSelected = (inpout == "全员")
                dateButton.setTitle(inpout, for: .selected)
                dateButton.isSelected = (inpout != "")

            } else {
                termlessButton.isSelected = false
                dateButton.setTitle("请选择发送人", for: .normal)
                dateButton.isSelected = false
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
