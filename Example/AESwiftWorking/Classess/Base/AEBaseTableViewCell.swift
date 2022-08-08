//
//  AEBaseTableViewCell.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/3/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEBaseTableViewCell: UITableViewCell {

    var indexPath: IndexPath?
    
    var tableView: UITableView?
    
    
    class func loadCode(tableView: UITableView, index: IndexPath) -> AEBaseTableViewCell {
        let identifier: String = String(describing: AEBaseTableViewCell.self)
        tableView.register(AEBaseTableViewCell.self, forCellReuseIdentifier: identifier)
        let cell: AEBaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index as IndexPath) as! AEBaseTableViewCell
        cell.selectionStyle = .none
        cell.indexPath = index
        cell.tableView = tableView
        cell.configEvent()
        cell.configUI()
        
        return cell
    }

}
extension AEBaseTableViewCell: ICBaseProtocol {
    @objc func configUI() {
    }
    @objc func configEvent() {
    }
}
//extension AEBaseTableViewCell {
//    /// 设置headerview自适应
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        if superview != nil {
//            snp.remakeConstraints { (make) in
//                make.width.equalTo(superview!)
//                make.edges.equalTo(superview!)
//            }
//            layoutIfNeeded()
//        }
//    }
//}
