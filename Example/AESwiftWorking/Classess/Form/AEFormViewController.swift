//
//  AEFormViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEFormViewController: AEBaseTableViewController {

    override func configEvent() {
        super.configEvent()
        var array = [AEFormListModel]()
        var itemModel = AEFormModel()
        
        /// 第一组
        var action: AEFormListModel = AEFormListModel()
        
        /// 第一行
        itemModel = AEFormModel()
        itemModel.title = "发布类型"
        itemModel.value = "提醒类"
        itemModel.valueName = ""
        itemModel.selectedArray = ["提醒类", "业绩类", "管理类", "其他"]
        itemModel.cellType = .picker
        action.list?.append(itemModel)
        
        /// 第二行
        itemModel = AEFormModel()
        itemModel.title = "主题"
        itemModel.value = ""
        itemModel.valueName = ""
        itemModel.cellType = .input
        action.list?.append(itemModel)
        
        /// 第三行
        itemModel = AEFormModel()
        itemModel.title = "发布类型"
        itemModel.value = "提醒类"
        itemModel.valueName = ""
        itemModel.selectedArray = ["提醒类", "业绩类", "管理类", "其他"]
        itemModel.cellType = .picker
        action.list?.append(itemModel)
    
        array.append(action)
        
        /// 第二组
        action = AEFormListModel()
        
        /// 第一行
        itemModel = AEFormModel()
        itemModel.title = "发布类型"
        itemModel.value = "提醒类"
        itemModel.valueName = ""
        itemModel.selectedArray = ["提醒类", "业绩类", "管理类", "其他"]
        itemModel.cellType = .picker
        action.list?.append(itemModel)
        
        array.append(action)
        
        /// 第三组
        action = AEFormListModel()
        
        /// 第一行
        itemModel = AEFormModel()
        itemModel.title = "发布类型"
        itemModel.value = "提醒类"
        itemModel.valueName = ""
        itemModel.selectedArray = ["提醒类", "业绩类", "管理类", "其他"]
        itemModel.cellType = .picker
        action.list?.append(itemModel)
        
        /// 第二行
        itemModel = AEFormModel()
        itemModel.title = "发布类型"
        itemModel.value = "提醒类"
        itemModel.valueName = ""
        itemModel.selectedArray = ["提醒类", "业绩类", "管理类", "其他"]
        itemModel.cellType = .picker
        action.list?.append(itemModel)
        
        array.append(action)
        
        dataArray = array;
    }
    
    override func configUI() {
        super.configUI()
        
//        tableView.reloadData()
        tableView.backgroundColor = UIColor.gray
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.15) { [self] in
            tableView.reloadData()
        }

    }


}

extension AEFormViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec: AEFormListModel = dataArray?[section] as? AEFormListModel ?? AEFormListModel()
        
        return sec.list?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sec: AEFormListModel = dataArray?[indexPath.section] as? AEFormListModel ?? AEFormListModel()
        let model: AEFormModel = sec.list?[indexPath.row] as? AEFormModel ?? AEFormModel()
        var roundType: AERoundType = .none
        /// 判断是否是第一个 和最后一个 及 只有一个
        if sec.list?.count == 1 {
            /// 上下全加圆角
            roundType = .all
        } else if indexPath.row == 0 {
            /// 上方圆角
            roundType = .top
        } else if indexPath.row == (sec.list?.count ?? 0) - 1 {
            /// 下方圆角
            roundType = .bottom
        }
        if model.cellType == .picker {
            let cell = AEFormPickerTCell.loadCode(tableView: tableView, index: indexPath)
            cell.roundType = roundType
            cell.detailModel = model
            cell.closure = { (value) in
                if let value: String = value as? String {
                    model.value = value
                    tableView.reloadData()
                }
                
            }
            return cell
            
        } else if model.cellType == .input {
            
            let cell = AEFormTextFieldTCell.loadCode(tableView: tableView, index: indexPath)
            cell.roundType = roundType
            cell.detailModel = model
            cell.closure = { (value) in
                if let value: String = value as? String {
                    model.value = value
                    tableView.reloadData()
                }
                
            }
            return cell
        }
        return UITableViewCell()
    }
    
}
