//
//  AEFormSingleChoiceTCell.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/20.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEFormSingleChoiceTCell: AEFormBaseTCell {

    override class func loadCode(tableView: UITableView, index: IndexPath) -> AEFormSingleChoiceTCell {
        let identifier: String = String(describing: AEFormTextFieldTCell.self)
        tableView.register(AEFormSingleChoiceTCell.self, forCellReuseIdentifier: identifier)
        let cell: AEFormSingleChoiceTCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index as IndexPath) as! AEFormSingleChoiceTCell
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
    private lazy var firstButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true

        button.setImage(UIImage(named: "selected_button_icon"), for: .selected)
        button.setImage(UIImage(named: "no_selected_button_icon"), for: .normal)
        button.setTitleColor(UIColor.colorHex(0x655A72), for: .normal)
//        button.setTitleColor(UIColor.colorHex(0x040404), for: .selected)
//        button.isSelected = false
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
    
    private lazy var secondButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        button.setImage(UIImage(named: "selected_button_icon"), for: .selected)
        button.setImage(UIImage(named: "no_selected_button_icon"), for: .normal)
        button.setTitleColor(UIColor.colorHex(0x655A72), for: .normal)
//        button.setTitleColor(UIColor.colorHex(0x040404), for: .selected)
        button.addTarget(self, action: #selector(termlessAction(_:)), for: UIControl.Event.touchUpInside)
        backView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.greaterThanOrEqualTo(firstButton.snp.right).offset(28)
            make.bottom.equalToSuperview().offset(-5)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(titleLabel.snp.height)
        }
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        firstButton.setLayoutType(type: .leftImage, space: 10)

        secondButton.setLayoutType(type: .leftImage, space: 10)
    }
    
    override var detailModel: AEFormModel? {
        didSet {
            if let titles = detailModel?.selectedArray {
                if titles.count == 1 {
                    secondButton.isHidden = true
                } else if titles.count >= 2 {
                    firstButton.isHidden = false
                    secondButton.isHidden = false

                    firstButton.setTitle(titles.first, for: .normal)
                    secondButton.setTitle(titles[1], for: .normal)
                } else {
                    firstButton.isHidden = true
                    secondButton.isHidden = true

                }
            }
            if (detailModel?.title?.count ?? 0) > 0 {
                titleLabel.text = detailModel?.title
            }
            if let inpout = detailModel?.value {
                firstButton.isSelected = (inpout == firstButton.currentTitle)
                secondButton.isSelected = (inpout == secondButton.currentTitle)

            }

        }
    }
    
}

extension AEFormSingleChoiceTCell {

    
    @objc func termlessAction(_ button: UIButton) {
        button.isSelected = !button.isSelected

        if button == firstButton {
            secondButton.isSelected = !button.isSelected
        } else if button == secondButton {
            firstButton.isSelected = !button.isSelected
        }
        
        guard let closure = self.closure else { return }
        var selected = detailModel?.selectedArray?.first
        if firstButton.isSelected {
            selected = firstButton.currentTitle
        } else
        if secondButton.isSelected {
            selected = secondButton.currentTitle
        }
        closure(selected)
    }
}
