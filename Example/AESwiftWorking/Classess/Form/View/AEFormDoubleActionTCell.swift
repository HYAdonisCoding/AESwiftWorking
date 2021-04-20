//
//  AEFormDoubleActionTCell.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/20.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEFormDoubleActionTCell: AEFormBaseTCell {

    override class func loadCode(tableView: UITableView, index: IndexPath) -> AEFormDoubleActionTCell {
        let identifier: String = String(describing: AEFormDoubleActionTCell.self)
        tableView.register(AEFormDoubleActionTCell.self, forCellReuseIdentifier: identifier)
        let cell: AEFormDoubleActionTCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index as IndexPath) as! AEFormDoubleActionTCell
        cell.selectionStyle = .none
        cell.indexPath = index
        cell.configEvent()
        cell.configUI()

        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func configUI() {
        super.configUI()
        
        backView.backgroundColor = formBackgroundColor
        
        termlessButton.applyGradient(colours: [UIColor.colorHex(0xE8B377), UIColor.colorHex(0xA96E2B)])
        dateButton.applyGradient(colours: [UIColor.colorHex(0xE8B377), UIColor.colorHex(0xA96E2B)])
    }

    //无限期
    private lazy var termlessButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(btnClickedAction(_:)), for: UIControl.Event.touchUpInside)
        backView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(40)
        }
        return button
    }()
    
    private lazy var dateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(btnClickedAction(_:)), for: UIControl.Event.touchUpInside)
        backView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalTo(termlessButton.snp.right).offset(20)
            make.bottom.equalToSuperview().offset(-5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(termlessButton.snp.height)
            make.width.equalTo(termlessButton.snp.width)
        }
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = (backView.bounds.size.width-30) / 2
        dateButton.configRectCorner(corner: [.allCorners], radii: CGSize(width: width, height: 40))

        termlessButton.configRectCorner(corner: [.allCorners], radii: CGSize(width: width, height: 40))
    }
    
    override var detailModel: AEFormModel? {
        didSet {
            if let inpout = detailModel?.selectedArray {
                if inpout.count >= 2 {
                    termlessButton.setTitle(inpout.first, for: .normal)
                    dateButton.setTitle(inpout[1], for: .normal)
                }

            }

        }
    }
    
}

extension AEFormDoubleActionTCell {

    
    @objc func btnClickedAction(_ button: UIButton) {
        AESwiftWorking_Example.endEditing()

        guard let closure = self.closure else { return }
        var selected = 0
        if let arr = detailModel?.selectedArray {
            for (i, item) in arr.enumerated() {
                if button.currentTitle == item {
                    selected = i
                    break
                }
            }
        }
        closure(selected)
    }
}
