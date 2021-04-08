//
//  AEFormViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/7.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import SwiftyFORM

class AEFormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func loadView() {
        super.loadView()
        form_installSubmitButton()
    }
    
    override func populate(_ builder: FormBuilder) {
        builder.navigationTitle = "发布"
//        builder += SectionHeaderTitleFormItem().title("Tutorial")
        let loaderItem0 = PickerViewFormItem().title("发布类型")
        
        loaderItem0.valueDidChangeBlock = { (value) in
            print("value --- \(value)")
        }
        loaderItem0.pickerTitles = [["提醒类", "业绩类", "管理类", "其他"]]
        builder += loaderItem0

        let theme = TextFieldFormItem().title("主题").placeholder("请输入主题").keyboardType(.default)
        theme.textAlignment = .right
        builder += theme

        builder += StaticTextFormItem().title("编号").value("20190103140511oO4qDV")

        let publisher = TextFieldFormItem().title("发布人").placeholder("请输入发布人").keyboardType(.default)
        publisher.textAlignment = .right
        builder += publisher
        //发布时间
        let date = DatePickerFormItem().title("发布时间")
        date.datePickerMode = .date
        builder += date
        
        //完成期限
        //是否回复

        builder += SectionHeaderTitleFormItem(title: "请补充详细问题或意见")
        
        builder += TextViewFormItem().placeholder("请详细描述您的问题或意见")

        builder += SectionHeaderTitleFormItem(title: "")
        
        let vc = ViewControllerFormItem().title("Go to view controller").viewController(HomeViewController.self)
        vc.placeholder = "qingxuan"
        builder += vc
        //发送人
        //选择发送人
        //添加
        
        

        //foot
        let foot = SectionFooterViewFormItem()
        foot.viewBlock = {
            let view = UIView()
            view.backgroundColor = UIColor.white
            return view
        }
        builder += foot
    }


}
