//
//  AEFormBaseTCell.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

typealias AEClosure = (_ data: Any?) -> Void
typealias AEActionClosure = (_ data: Any?) -> Void
typealias AETextClosure = (_ data: String?) -> Void

class AEFormBaseTCell: AEBaseTableViewCell {

    var closure: AEClosure?
    var actionClosure: AEActionClosure?
    var textClosure: AETextClosure?
    
    override class func loadCode(tableView: UITableView, index: IndexPath) -> AEFormBaseTCell {
        let identifier: String = String(describing: AEFormBaseTCell.self)
        tableView.register(AEFormBaseTCell.self, forCellReuseIdentifier: identifier)
        let cell: AEFormBaseTCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index as IndexPath) as! AEFormBaseTCell
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

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.colorHex(0x231A2F)
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(5)
            make.width.greaterThanOrEqualTo(0)
            make.height.equalTo(20)
        }
        return label
    }()
    
    var detailModel: AEFormModel? {
        didSet {
            if (detailModel?.title?.count ?? 0) > 0 {
                titleLabel.text = detailModel?.title
            }
            
        }
    }
    
}

class AEFormModel: AEBaseModel {
    var title: String?
    var inputInformation: String?
    
}
