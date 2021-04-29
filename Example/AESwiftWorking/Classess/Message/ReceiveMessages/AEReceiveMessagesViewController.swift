//
//  AEReceiveMessagesViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/27.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEReceiveMessagesViewController: AEDraftsViewController {

    
    private lazy var header: AEGroupHeaderView = {
        let name = AEGroupHeaderView.headerView(value: nil) { (idx) in
            print(idx as Any)
        }
        view.addSubview(name)
        name.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(self.bottomLayoutGuide.snp.top)
            }
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        return name
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    

    
}

extension AEReceiveMessagesViewController {
    
    override func configEvent() {
        super.configEvent()
    }
    override func configUI() {
        super.configUI()
        navigationItem.title = "接收消息"
        
        tableView.snp.remakeConstraints { (make) in
            make.bottom.equalTo(foot.snp.top)
            make.left.right.equalToSuperview()
            make.top.equalTo(header.snp.bottom)
        }
        
        let rightBar = UIBarButtonItem(title: "刷新", style: .plain, target: self, action: #selector(refreshAction(_:)))
        //655A72
        rightBar.tintColor = UIColor.colorHex(0x655A72)
        navigationItem.rightBarButtonItem = rightBar
        
    }
    @objc func refreshAction(_ sender: Any) {
        debugPrintLog("刷新")
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AEMessageTCell.loadCode(tableView: tableView, index: indexPath)
        cell.titleLabel.text = "主题：关于中国光大银行信用卡增值服务业务调整的公告"

        let attributedText = NSMutableAttributedString(string: "公司：总行  时间：2021-03-02   发布等级：高  \n是否需要回复：是  回复人数：3  阅读数量：1927")
        
        
        let parag = NSMutableParagraphStyle()
        parag.lineSpacing = 6 //字体的行间距
        let firstAttributes = [
            NSAttributedString.Key.paragraphStyle: parag,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
        ]
        
        attributedText.setAttributes(firstAttributes, range: NSRange(location: 0, length: attributedText.length))
        
        cell.detailLabel.attributedText = attributedText
       return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AEReceivedMsgDetailVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

