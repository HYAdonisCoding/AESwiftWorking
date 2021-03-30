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
    
    class func loadCode(tableView: UITableView, index: IndexPath) -> AEBaseTableViewCell {
        let identifier: String = String(describing: AEBaseTableViewCell.self)
        tableView.register(AEBaseTableViewCell.self, forCellReuseIdentifier: identifier)
        let cell: AEBaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index as IndexPath) as! AEBaseTableViewCell
        cell.selectionStyle = .none
        cell.indexPath = index
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
