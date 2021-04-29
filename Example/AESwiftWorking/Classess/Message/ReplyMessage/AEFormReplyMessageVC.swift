//
//  AEFormReplyMessageVC.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/29.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEFormReplyMessageVC: AEFormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configEvent() {
        super.configEvent()
        var array = [Any]()
        var itemModel = AEFormModel()
        
        /// 第一组
        var action: AEFormListModel = AEFormListModel()
        action.title = "消息详情"
        
        var infoModel = ICShowInfoModel()
        infoModel.title = "发布类型："
        infoModel.detailInfo = "提醒类"
        
        action.list?.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "主题："
        infoModel.detailInfo = "关于中国光大银行信用卡增值服务业务调整的公告关于中国光大银行信用卡增值服务业务调整的公告"
        infoModel.boldFont = true
        action.list?.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "编号："
        infoModel.detailInfo = "20190103140511oO4qDV"
        
        action.list?.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "发布人："
        infoModel.detailInfo = "移动互联网业务部 李努力"
        
        action.list?.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "发布时间："
        infoModel.detailInfo = "2021-03-02"
        
        action.list?.append(infoModel)
        
        
        infoModel = ICShowInfoModel()
        infoModel.title = "完成期限："
        infoModel.detailInfo = "2021-03-03"
        
        action.list?.append(infoModel)
        
        
        infoModel = ICShowInfoModel()
        infoModel.title = "发布等级："
        infoModel.detailInfo = "高级"
        
        action.list?.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "是否回复："
        infoModel.detailInfo = "否"
        
        action.list?.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "发送人："
        infoModel.detailInfo = "移动互联网业务部 王努力；移动互联网业务部 张努力； 移动互联网业务部 刘努力；移动互联网业务部 郑努力；移动互联网业务部 周努力。"
        
        action.list?.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "发布详情："
        infoModel.detailInfo = "关于中国光大银行信用卡增值服务业务调整的公告，关于中国光大银行信用卡增值服务业务调整的公告，关于中国光大银行信用卡增值服务业务调整的公告，关于中国光大银行信用卡增值服务业务调整的公告。"
        
        action.list?.append(infoModel)
        
        
        
        dataArray?.append(action)
        
    
        array.append(action)
        
        /// 第二组
        action = AEFormListModel()
        action.title = "消息回复"
        
        /// 第一行
        itemModel = AEFormModel()
        itemModel.title = "是否回复"
        itemModel.value = ""
        itemModel.valueName = ""
        itemModel.cellType = .singleChoice
        itemModel.selectedArray = ["回复", "不回复"]
        action.list?.append(itemModel)
        
        
        array.append(action)
        
        /// 第三组
        action = AEFormListModel()
        
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
        
        customClosure = { (data) in
            print(data)
            self.customClickedAction(data)
        }
    }
    
    override func configUI() {
        super.configUI()
        
//        tableView.reloadData()
        tableView.backgroundColor = formBackgroundColor
        
        
        navigationItem.title = "回复消息"
        
        navigationItem.rightBarButtonItem = nil
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.15) { [self] in
            tableView.reloadData()
        }

    }
    
}

extension AEFormReplyMessageVC {
    @objc func customClickedAction(_ sender: Any) {
        print("立即回复")
    }
}
