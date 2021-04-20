//
//  AESelectCalenderTCell.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/19.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AESelectCalenderTCell: AEFormBaseTCell {

    override class func loadCode(tableView: UITableView, index: IndexPath) -> AESelectCalenderTCell {
        let identifier: String = String(describing: AEFormTextFieldTCell.self)
        tableView.register(AESelectCalenderTCell.self, forCellReuseIdentifier: identifier)
        let cell: AESelectCalenderTCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index as IndexPath) as! AESelectCalenderTCell
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

        button.setTitle("无限期", for: .normal)
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
        button.setImage(UIImage(named: "selected_date_icon"), for: .normal)
        button.setTitleColor(UIColor.colorHex(0x655A72), for: .normal)
//        button.setTitleColor(UIColor.colorHex(0x040404), for: .selected)
        button.addTarget(self, action: #selector(showCalenderView), for: UIControl.Event.touchUpInside)
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
            if let inpout = detailModel?.value {
                termlessButton.isSelected = (inpout == "无限期")
                dateButton.setTitle(inpout, for: .normal)

            }

        }
    }
    
}

extension AESelectCalenderTCell {
    @objc func showCalenderView() {
        ICDateSelectionView.dateSelectionView("") { (dateString) in
            debugPrintLog("选择了"+dateString)
            self.dateButton.setTitle(dateString, for: .normal)
            guard let closure = self.closure else { return }
            closure(dateString)
        }
    }
    
    @objc func termlessAction(_ button: UIButton) {
        button.isSelected = !button.isSelected

        guard let closure = self.closure else { return }
        var selected = "请选择限期"
        if button.isSelected {
            selected = "无限期"
        }
        closure(selected)
    }
}
