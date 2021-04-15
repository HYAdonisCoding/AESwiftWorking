//
//  ICBaseTableViewCell.swift
//  ICMS
//
//  Created by Adam on 2021/2/11.
//

import Foundation
import UIKit


class ICBaseTableViewCell: UITableViewCell {
    
    
    var indexPath: IndexPath?
    
    class func loadCode(tableView: UITableView, index: IndexPath) -> ICBaseTableViewCell {
        let identifier: String = String(describing: ICBaseTableViewCell.self)
        tableView.register(ICBaseTableViewCell.self, forCellReuseIdentifier: identifier)
        let cell: ICBaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index as IndexPath) as! ICBaseTableViewCell
        cell.selectionStyle = .none
        cell.indexPath = index
        cell.configEvent()
        cell.configUI()
        
        return cell
    }
    func configUI() {
    }
    func configEvent() {
    }

}
