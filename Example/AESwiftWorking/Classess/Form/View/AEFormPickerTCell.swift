//
//  AEFormPickerTCell.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit



class AEFormPickerTCell: AEFormBaseTCell {
//    var actionClosure: AEActionClosure?
//    lazy var titleLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = UIColor.colorHex(0x231A2F)
//        addSubview(label)
//        label.snp.makeConstraints { (make) in
//            make.left.top.equalToSuperview().offset(5)
//            make.width.greaterThanOrEqualTo(0)
////            make.height.equalTo(30)
//            make.bottom.equalToSuperview().offset(-5)
//        }
//        return label
//    }()
    //right_arrow_icon
    
    override class func loadCode(tableView: UITableView, index: IndexPath) -> AEFormPickerTCell {
        let identifier: String = String(describing: AEFormPickerTCell.self)
        tableView.register(AEFormPickerTCell.self, forCellReuseIdentifier: identifier)
        let cell: AEFormPickerTCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index as IndexPath) as! AEFormPickerTCell
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

    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true

        button.setTitle("提醒类", for: .normal)
        button.setImage(UIImage(named: "right_arrow_icon"), for: .normal)
        button.setTitleColor(UIColor.colorHex(0x655A72), for: .normal)
//        button.setTitleColor(UIColor.colorHex(0x040404), for: .selected)
        button.addTarget(self, action: #selector(actionButtonClick(button:)), for: UIControl.Event.touchUpInside)
        backView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.greaterThanOrEqualTo(titleLabel.snp.right).offset(10)
            make.bottom.equalToSuperview().offset(-5)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(titleLabel.snp.height)
        }
        return button
    }()
    
    override var detailModel: AEFormModel? {
        didSet {
            if (detailModel?.title?.count ?? 0) > 0 {
                titleLabel.text = detailModel?.title
            }
            if let inpout = detailModel?.value {
                actionButton.setTitle(inpout, for: .normal)
                
            }

        }
    }
        
        
    override func layoutSubviews() {
        super.layoutSubviews()
        actionButton.setLayoutType(type: .rightImage, space: 10)

    }
}

extension AEFormPickerTCell {
    @objc func actionButtonClick(button: UIButton) {
        AESwiftWorking_Example.endEditing()
        if detailModel?.cellType == .picker {
            ///
            let title = "选择"+(detailModel?.title ?? "")
            let data = detailModel?.selectedArray ?? []
            let selected = detailModel?.value ?? ""
            
            
            ICBottomListSelectionView.bottomListSelectionView(title, data: data, selected: selected) { (selectionModel) in
                if let model = selectionModel {
                    self.detailModel?.value = model.title
                    guard let closure = self.closure else { return }
                    closure(model.title)
                }
            }
        }

    }
}
