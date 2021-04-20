//
//  AEFormBaseTCell.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

/// 默认内边距
let kMargin = 15.0

typealias AEClosure = (_ data: Any?) -> Void
typealias AEActionClosure = (_ data: Any?) -> Void
typealias AETextClosure = (_ data: String?) -> Void

class AEFormBaseTCell: AEBaseTableViewCell {

    var closure: AEClosure?
    var actionClosure: AEActionClosure?
    var textClosure: AETextClosure?
    var roundType: AERoundType? {
        didSet {
            switch roundType {
            case .top:
                backView.configRectCorner(corner: [.topLeft, .topRight], radii: CGSize(width: 10, height: 10))
            case .bottom:
                backView.configRectCorner(corner: [.bottomLeft, .bottomRight], radii: CGSize(width: 10, height: 10))
            case .all:
                backView.configRectCorner(corner: [.allCorners], radii: CGSize(width: 10, height: 10))
            default:
                print("无需圆角")
            }
            setNeedsLayout()
        }
    }
    
    
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
        backView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(5)
            make.width.greaterThanOrEqualTo(0)
        }
        return label
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        self.contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.bottom.top.equalToSuperview()
            make.left.equalToSuperview().offset(kMargin)
            make.right.equalToSuperview().offset(-kMargin)
            make.height.greaterThanOrEqualTo(50)
        }
        return view
    }()
    

    var detailModel: AEFormModel? {
        didSet {
            if (detailModel?.title?.count ?? 0) > 0 {
                titleLabel.text = detailModel?.title
            }
            
        }
    }
    
    override func configEvent() {
        super.configEvent()
        
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = formBackgroundColor
        setNeedsLayout()

    }
}
/// cell表格类型
enum AEFormType {
    case picker
    case input
    case show
    case custom
    case calender
    case singleChoice/// 暂时只支持2个选择
    case inputView

}

/// 圆角类型
enum AERoundType {
    case top
    case bottom
    case all
    case none
}

class AEFormListModel: AEBaseModel {
    
    var list: [AEBaseModel]? = []
    var title: String?
    var subTitle: String?
    
    /// 是否是圆角
    var round: Bool = false
    
    var moreActionTitle: String?
    
    
    
}
class AEFormModel: AEBaseModel {
    
    var title: String?
    var value: String?
    var valueName: String?

    var inputInformation: String?
    var selectedArray: [String]?
    var cellType: AEFormType?
    
    
}

func endEditing() {
    UIApplication.shared.keyWindow?.rootViewController?.view.endEditing(true)
}

