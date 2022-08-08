//
//  ICMineViewController.swift
//  ICMS
//
//  Created by Adam on 2021/4/21.
//

import UIKit

let kBackGroundcolor = UIColor.colorHex(0xf5f5f7)

class ICMineViewController: ICBaseTableViewController {

    var dataArray: [[ICShowInfoModel]]?
    /// 自定义事件
    var customClosure: FormCustomClosure?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func configEvent() {
        super.configEvent()
        
        let app = ICAppManager.shared.userModel

        dataArray = []
        var infoArray: [ICShowInfoModel] = []
        
        var infoModel = ICShowInfoModel()
        infoModel.title = "机构："
        infoModel.detailInfo = app?.institutions
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "姓名："
        infoModel.detailInfo = app?.name
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "性别："
        infoModel.detailInfo = app?.sex
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "年龄："
        infoModel.detailInfo = (app?.age ?? "0")+"岁"
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "工号："
        infoModel.detailInfo = app?.seateNo
        
        infoArray.append(infoModel)
        
        
        infoModel = ICShowInfoModel()
        infoModel.title = "手机号："
        infoModel.detailInfo = app?.userPhoneNum
        
        infoArray.append(infoModel)
        
        
        infoModel = ICShowInfoModel()
        infoModel.title = "身份证号："
        infoModel.detailInfo = app?.userIdNo
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "所属账龄："
        infoModel.detailInfo = app?.undertakeAge
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "入职日期："
        infoModel.detailInfo = app?.inTheTime
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "入职年限："
        infoModel.detailInfo = app?.inTheYear
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "是否新人："
        infoModel.detailInfo = app?.theCouple
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "职位："
        infoModel.detailInfo = app?.position
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "户籍："
        infoModel.detailInfo = app?.registration
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "毕业院校："
        infoModel.detailInfo = app?.school
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "学历："
        infoModel.detailInfo = app?.education
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "招聘来源："
        infoModel.detailInfo = app?.recruitment
        
        infoArray.append(infoModel)
        
        infoModel = ICShowInfoModel()
        infoModel.title = "单位地址："
        infoModel.detailInfo = app?.companyAddress
        
        infoArray.append(infoModel)
        
        dataArray?.append(infoArray)
        
        /// 第二组
        infoArray = []
        infoModel = ICShowInfoModel()
        infoModel.title = "修改密码"
        infoModel.type = .action
        infoArray.append(infoModel)
        dataArray?.append(infoArray)

        
    }
    
    override func configUI() {
        super.configUI()
        self.navigationItem.title = "个人信息"
//        tableView.separatorStyle = .singleLine
        view.backgroundColor = kBackGroundcolor
        tableView.backgroundColor = kBackGroundcolor
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.15) { [self] in
            tableView.reloadData()
        }
    }


}

extension ICMineViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr: [ICShowInfoModel] = dataArray?[section] ?? []

        return arr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let arr: [ICShowInfoModel] = dataArray?[indexPath.section] ?? []
        let model: ICShowInfoModel = arr[indexPath.row]
        
        if model.type == .show {
            let cell = ICShowInfoTCell.loadCode(tableView: tableView, index: indexPath)
            cell.showInfoModel = model
            return cell
        } else if model.type == .action {
            
            let cell = ICSingleButtonTCell.loadCode(tableView: tableView, index: indexPath)
            cell.titleString = model.title
            cell.singleButtonClosure = { [self] (data) in
                guard let customClosure = customClosure else { return }
                customClosure(data)
//                let vc = ICChangePasswordVC()
//                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        }
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let vc = ICChangePasswordVC()
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
}
