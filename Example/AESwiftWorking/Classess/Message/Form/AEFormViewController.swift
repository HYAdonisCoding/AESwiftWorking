//
//  AEFormViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

let formBackgroundColor = UIColor.colorHex(0xf5f5f7)

typealias FormSaveOrSendClosure = (_ idx: Int) -> Void
typealias FormCustomClosure = (_ data: Any?) -> Void

class AEFormViewController: AEBaseTableViewController {
    
    var saveOrSendClosure: FormSaveOrSendClosure?
    /// 自定义事件
    var customClosure: FormCustomClosure?

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
        itemModel.title = "完成期限"
        itemModel.value = "2021-04-21"
        itemModel.valueName = ""
        itemModel.cellType = .calender
        action.list?.append(itemModel)
        
        itemModel = AEFormModel()
        itemModel.title = "发布等级"
        itemModel.value = "高级"
        itemModel.valueName = ""
        itemModel.selectedArray = ["高级", "中级", "初级"]
        itemModel.cellType = .picker
        action.list?.append(itemModel)
        
        /// 第三行
        itemModel = AEFormModel()
        itemModel.title = "是否回复"
        itemModel.value = ""
        itemModel.valueName = ""
        itemModel.cellType = .singleChoice
        itemModel.selectedArray = ["回复", "不回复"]
        action.list?.append(itemModel)
        
    
        array.append(action)
        
        /// 第二组
        action = AEFormListModel()
        action.title = "请补充详细问题或意见"
        
        /// 第一行
        itemModel = AEFormModel()
        itemModel.title = ""
        itemModel.value = ""
        itemModel.valueName = ""
        itemModel.cellType = .inputView
        action.list?.append(itemModel)
        
        
        array.append(action)
        
        /// 第三组
        action = AEFormListModel()
        
        /// 第一行
        itemModel = AEFormModel()
        itemModel.title = "发送人"
        itemModel.value = ""
        itemModel.valueName = ""
//        itemModel.selectedArray = ["全员"]
        itemModel.cellType = .choiceAndCustomPush

        action.list?.append(itemModel)
        
        /// 第二行
//        itemModel = AEFormModel()
//        itemModel.title = "发布类型"
//        itemModel.value = "提醒类"
//        itemModel.valueName = ""
//        itemModel.selectedArray = ["提醒类", "业绩类", "管理类", "其他"]
//        itemModel.cellType = .picker
//        action.list?.append(itemModel)
        
        array.append(action)
        
        
        /// 第三组
        action = AEFormListModel()
        
        /// 第一行
        itemModel = AEFormModel()
        itemModel.value = ""
        itemModel.valueName = ""
        itemModel.selectedArray = ["保存", "发送"]
        itemModel.cellType = .doubleAction
        action.list?.append(itemModel)
        
        array.append(action)
        dataArray = array;
        
        /// 下一步操作
        saveOrSendClosure = {(idx) in
            print(idx)
        }
    }
    
    override func configUI() {
        super.configUI()
        
//        tableView.reloadData()
        tableView.backgroundColor = formBackgroundColor
        let rightBar = UIBarButtonItem(title: "草稿箱", style: .plain, target: self, action: #selector(draftsAction(_:)))
        //655A72
        rightBar.tintColor = UIColor.colorHex(0x655A72)
        navigationItem.rightBarButtonItem = rightBar
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.15) { [self] in
            tableView.reloadData()
        }

    }


}

extension AEFormViewController {
    @objc func draftsAction(_ sender: Any) {
        let vc = AEDraftsViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = dataArray?[section]
        if let m = sec as? AEFormListModel {
            return m.list?.count ?? 0
        }
//        if let m = sec as? AEFormListModel {
//            return m.list?.count ?? 0
//        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sec: AEFormListModel = dataArray?[indexPath.section] as? AEFormListModel ?? AEFormListModel()
        let model = sec.list?[indexPath.row]
        if let model = model as? AEFormModel {
            /// 表单类
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
            var hideBottomLine = false
            if indexPath.row == ((sec.list?.count ?? 0) - 1) {
                hideBottomLine = true
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
                cell.hideBottomLine(hideBottomLine)
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
                cell.hideBottomLine(hideBottomLine)
                return cell
            }
            
            else if model.cellType == .calender {
                
                let cell = AEFormCalenderTCell.loadCode(tableView: tableView, index: indexPath)
                cell.roundType = roundType
                cell.detailModel = model
                cell.closure = { (value) in
                    if let value: String = value as? String {
                        model.value = value
                        tableView.reloadData()
                    }
                    
                }
                cell.hideBottomLine(hideBottomLine)
                return cell
            }
            else if model.cellType == .singleChoice {
                
                let cell = AEFormSingleChoiceTCell.loadCode(tableView: tableView, index: indexPath)
                cell.roundType = roundType
                cell.detailModel = model
                cell.closure = { (value) in
                    if let value: String = value as? String {
                        model.value = value
                        tableView.reloadData()
                    }
                    
                }
                cell.hideBottomLine(hideBottomLine)
                return cell
            }
            else if model.cellType == .inputView {
                
                let cell = AEFormChapterTextViewTCell.loadCode(tableView: tableView, index: indexPath)
                cell.roundType = roundType
                cell.detailModel = model
                cell.closure = { (value) in
                    if let value: String = value as? String {
                        model.value = value
                        tableView.reloadData()
                    }
                    
                }
                cell.hideBottomLine(hideBottomLine)
                return cell
            }
            else if model.cellType == .choiceAndCustomPush {
                
                let cell = AEChoiceAndCustomPushTCell.loadCode(tableView: tableView, index: indexPath)
                cell.roundType = roundType
                cell.detailModel = model
                cell.closure = { (value) in
                    if let value: String = value as? String {
                        model.value = value
                        tableView.reloadData()
                    }
                    
                }
                cell.hideBottomLine(hideBottomLine)
                return cell
            }
            else if model.cellType == .doubleAction {
                
                let cell = AEFormDoubleActionTCell.loadCode(tableView: tableView, index: indexPath)
                cell.detailModel = model
                cell.closure = { (value) in
                    if let value: Int = value as? Int {
                        guard let saveOrSendClosure = self.saveOrSendClosure else { return }
                        saveOrSendClosure(value)
                    }
                    
                }
                cell.hideBottomLine(hideBottomLine)
                return cell
            }
        }
        if let model = model as? ICShowInfoModel {
            // 只展示
            if model.type == .show {
                let cell = ICShowInfoTCell.loadCode(tableView: tableView, index: indexPath)
                cell.showInfoModel = model
                return cell
            } else if model.type == .action {
                
                let cell = ICSingleButtonTCell.loadCode(tableView: tableView, index: indexPath)
                cell.titleString = model.title
                cell.singleButtonClosure = { (data) in
                    guard let customClosure = self.customClosure else { return }
                    customClosure(data)
                
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sec: AEFormListModel = dataArray?[section] as? AEFormListModel ?? AEFormListModel()
        if (sec.title?.count ?? 0) > 0 {
            let header = AEFormSectionHeaderView.loadCode(tableView: tableView, section: section)
            header.model = sec
            return header
        }
        
        let header = AEBaseView()
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sec: AEFormListModel = dataArray?[section] as? AEFormListModel ?? AEFormListModel()
        if (sec.title?.count ?? 0) > 0 {
            return 45
        }
        return 15
    }
}
