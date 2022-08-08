//
//  AEDraftsViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEDraftsViewController: AEBaseTableViewController {

    lazy var foot: AEPagingFootView = {
        let page = AEPagingFootView.pagingFootView(value: 10) { (type) in
            print(type)
        }
        view.addSubview(page)
        page.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(self.bottomLayoutGuide.snp.bottom)
            }
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        return page
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func configEvent() {
        super.configEvent()
    }
    
    override func configUI() {
        super.configUI()
        
//        navigationItem.title = "草稿箱"
        let _ = foot
        
        tableView.snp.remakeConstraints { (make) in
            make.bottom.equalTo(foot.snp.top)
            make.left.right.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(self.bottomLayoutGuide.snp.top)
            }
        }
        dataArray = ["", "", "", "", "", "", "", "", "", "", ""]
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.15) { [self] in
            foot.layoutSubviews()
        }
    }

}

extension AEDraftsViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AEMessageTCell.loadCode(tableView: tableView, index: indexPath)
        cell.titleLabel.text = "主题：关于中国光大银行信用卡增值服务业务调整的公告"

        let attributedText = NSMutableAttributedString(string: "公司：总行  时间：2021-03-02   发布等级：高  \n是否需要回复：是  回复人数：3  阅读数量：1927")
        
        
        let parag = NSMutableParagraphStyle()
//        parag.firstLineHeadIndent = -35.0 //首行缩进
        parag.lineSpacing = 6 //字体的行间距
        let firstAttributes = [
            NSAttributedString.Key.paragraphStyle: parag,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
        ]
        
        attributedText.setAttributes(firstAttributes, range: NSRange(location: 0, length: attributedText.length))
        
        cell.detailLabel.attributedText = attributedText
       return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AEDraftDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
