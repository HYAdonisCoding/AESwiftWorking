//
//  AEDraftDetailViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEDraftDetailViewController: ICMineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configEvent() {
        super.configEvent()
        
        dataArray = []
        var infoArray: [ICShowInfoModel] = []
        
        var infoModel = ICShowInfoModel()
        infoModel.title = "发布类型："
        infoModel.detailInfo = "提醒类"
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "主题："
        infoModel.detailInfo = "关于中国光大银行信用卡增值服务业务调整的公告关于中国光大银行信用卡增值服务业务调整的公告"
        infoModel.boldFont = true
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "编号："
        infoModel.detailInfo = "20190103140511oO4qDV"
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "发布人："
        infoModel.detailInfo = "移动互联网业务部 李努力"
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "发布时间："
        infoModel.detailInfo = "2021-03-02"
        
        infoArray.append(infoModel)
        
        
        infoModel = ICShowInfoModel()
        infoModel.title = "完成期限："
        infoModel.detailInfo = "2021-03-03"
        
        infoArray.append(infoModel)
        
        
        infoModel = ICShowInfoModel()
        infoModel.title = "发布等级："
        infoModel.detailInfo = "高级"
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "是否回复："
        infoModel.detailInfo = "否"
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "发送人："
        infoModel.detailInfo = "移动互联网业务部 王努力；移动互联网业务部 张努力； 移动互联网业务部 刘努力；移动互联网业务部 郑努力；移动互联网业务部 周努力。"
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "发布详情："
        infoModel.detailInfo = "关于中国光大银行信用卡增值服务业务调整的公告，关于中国光大银行信用卡增值服务业务调整的公告，关于中国光大银行信用卡增值服务业务调整的公告，关于中国光大银行信用卡增值服务业务调整的公告。"
        
        infoArray.append(infoModel)
        
        
        
        dataArray?.append(infoArray)
        
        /// 第二组
        infoArray = []
        infoModel = ICShowInfoModel()
        infoModel.title = "继续编辑"
        infoModel.type = .action
        infoArray.append(infoModel)
        dataArray?.append(infoArray)
        
        customClosure = {(data) in
            print("继续编辑")
        }
    }
    
    override func configUI() {
        super.configUI()
        
        navigationItem.title = "草稿详情"
    }
}

extension AEDraftDetailViewController {
    
}
