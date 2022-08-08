//
//  AEFormTextFieldTCell.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/19.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEFormTextFieldTCell: AEFormBaseTCell {
    override class func loadCode(tableView: UITableView, index: IndexPath) -> AEFormTextFieldTCell {
        let identifier: String = String(describing: AEFormTextFieldTCell.self)
        tableView.register(AEFormTextFieldTCell.self, forCellReuseIdentifier: identifier)
        let cell: AEFormTextFieldTCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index as IndexPath) as! AEFormTextFieldTCell
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
    
    private lazy var inputTextField: UITextField = {
        let inputTextField = UITextField()
        inputTextField.placeholder = "请输入手机号码"
//        inputTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
//        inputTextField.leftViewMode = .always
//        inputTextField.keyboardType = .numberPad
        inputTextField.textAlignment = .right
        inputTextField.delegate = self
        backView.addSubview(inputTextField)
        inputTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.bottom.right.equalToSuperview().offset(-15)
            make.height.equalTo(titleLabel.snp.height)
        }
        return inputTextField
    }()
    
    override var detailModel: AEFormModel? {
        didSet {
            if (detailModel?.title?.count ?? 0) > 0 {
                titleLabel.text = detailModel?.title
            }
            if let inpout = detailModel?.value {
                inputTextField.text = inpout
                inputTextField.placeholder = "请输入"+(titleLabel.text ?? "")
            }

        }
    }

}

extension AEFormTextFieldTCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let closure = self.closure else { return }
        closure(textField.text)
        
    }
}
