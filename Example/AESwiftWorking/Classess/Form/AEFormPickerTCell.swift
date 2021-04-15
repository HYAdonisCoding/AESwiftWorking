//
//  AEFormPickerTCell.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import XLForm

let XLFormRowDescriptorTypeRate = "XLFormRowDescriptorTypeRate"
class AEFormPickerTCell: XLFormBaseCell {
    var actionClosure: AEActionClosure?
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.colorHex(0x231A2F)
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(5)
            make.width.greaterThanOrEqualTo(0)
//            make.height.equalTo(30)
            make.bottom.equalToSuperview().offset(-5)
        }
        return label
    }()
    //right_arrow_icon
    
//    class func loadCode(tableView: UITableView, index: IndexPath) -> AEFormPickerTCell {
//        let identifier: String = String(describing: AEFormPickerTCell.self)
//        tableView.register(AEFormPickerTCell.self, forCellReuseIdentifier: identifier)
//        let cell: AEFormPickerTCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index as IndexPath) as! AEFormPickerTCell
//        cell.selectionStyle = .none
////        cell.indexPath = index
//        cell.configEvent()
//        cell.configUI()
//
//        return cell
//    }
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true

        button.setTitle("提醒类", for: .normal)
        button.setImage(UIImage(named: "right_arrow_icon"), for: .normal)
        button.setTitleColor(UIColor.colorHex(0xFFFFFF), for: .normal)
        button.setTitleColor(UIColor.colorHex(0x040404), for: .selected)
        button.addTarget(self, action: #selector(actionButtonClick(button:)), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 50
//        button.isUserInteractionEnabled = false
//        button.isSelected = true
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(10)
            make.right.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(titleLabel.snp.height)
        }
        return button
    }()
    
    var detailModel: AEFormModel? {
        didSet {
            if (detailModel?.title?.count ?? 0) > 0 {
                titleLabel.text = detailModel?.title
            }
            if let inpout = detailModel?.inputInformation {
                actionButton.setTitle(inpout, for: .normal)
            }

        }
    }
    //Mark: - XLFormDescriptorCell
        
        override func configure() {
            super.configure()
            selectionStyle = .none
        }
        
        override func update() {
            super.update()
            if let rowDescriptor = rowDescriptor {
                titleLabel.text = rowDescriptor.title
                actionButton.setTitle(rowDescriptor.value as? String, for: .normal)
            }
        }
        
        override func formDescriptorCellCanBecomeFirstResponder() -> Bool {
            return rowDescriptor?.isDisabled() == false
        }
        
        
        override func formDescriptorCellBecomeFirstResponder() -> Bool {
            if isFirstResponder {
                return super.becomeFirstResponder()
            }
            let result = super.becomeFirstResponder()
            if result {
                actionButtonClick(button: actionButton)
            }
            return result
        }
    
        
        override static func formDescriptorCellHeight(for rowDescriptor: XLFormRowDescriptor!) -> CGFloat {
            return 55.0
        }
        
        
}

extension AEFormPickerTCell {
    @objc func actionButtonClick(button: UIButton) {
        guard let closure = rowDescriptor.action.formBlock else { return }
        closure(rowDescriptor)
    }
}

//extension AEFormPickerTCell: XLFormBaseCell {
//
//}
extension AEFormPickerTCell: ICBaseProtocol {
    @objc func configUI() {
    }
    @objc func configEvent() {
    }
}
