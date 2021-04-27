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
        
        firstButton.applyGradient(colours: [UIColor.colorHex(0xE8B377), UIColor.colorHex(0xA96E2B)])
        secondButton.applyGradient(colours: [UIColor.colorHex(0xE8B377), UIColor.colorHex(0xA96E2B)])
    }

    
    private lazy var firstButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(btnClickedAction(_:)), for: UIControl.Event.touchUpInside)
        button.backgroundColor = UIColor.colorHex(0xD3D1D7)
        backView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(btnClickedAction(_:)), for: UIControl.Event.touchUpInside)
        backView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalTo(firstButton.snp.right).offset(20)
            make.bottom.equalToSuperview()
            make.height.equalTo(firstButton.snp.height)
            make.width.equalTo(firstButton.snp.width)
        }
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = (backView.bounds.size.width-30) / 2
        if width > 0 {
            secondButton.configRectCorner(corner: [.allCorners], radii: CGSize(width: width, height: 40))

            firstButton.configRectCorner(corner: [.allCorners], radii: CGSize(width: width, height: 40))
        }

    }
    
    override var detailModel: AEFormModel? {
        didSet {
            if let inpout = detailModel?.selectedArray {
                if inpout.count >= 2 {
                    firstButton.setTitle(inpout.first, for: .normal)
                    secondButton.setTitle(inpout[1], for: .normal)
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
