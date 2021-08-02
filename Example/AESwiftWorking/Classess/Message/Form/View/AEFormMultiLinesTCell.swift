//
//  AEFormMultiLinesTCell.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/7/19.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEFormMultiLinesTCell: AEFormBaseTCell {
    
    override class func loadCode(tableView: UITableView, index: IndexPath) -> AEFormMultiLinesTCell {
        let identifier: String = String(describing: AEFormMultiLinesTCell.self)
        tableView.register(AEFormMultiLinesTCell.self, forCellReuseIdentifier: identifier)
        let cell: AEFormMultiLinesTCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index as IndexPath) as! AEFormMultiLinesTCell
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
    
    private lazy var textView: AETextView = {
        let textView = AETextView()
        textView.delegate = self
        
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.textColor = UIColor.purple
        textView.textAlignment = .right
        
        backView.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(titleLabel.snp.right).offset(10)
            make.bottom.right.equalToSuperview().offset(-15)
            make.height.equalTo(defaultHeight)
        }
        return textView
    }()
    


    override var detailModel: AEFormModel? {
        didSet {
            if (detailModel?.title?.count ?? 0) > 0 {
                titleLabel.text = detailModel?.title
                textView.placeHolderStr = "请输入"+(titleLabel.text ?? "")
            }
            if let inpout = detailModel?.value, textView.text != inpout {
                textView.text = inpout
            }
        }
    }

    var defaultHeight: CGFloat = 38
    var signalHeight: CGFloat = 38
    
}

extension AEFormMultiLinesTCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()

        print("override func layoutSubviews()")
        
    }
}
extension AEFormMultiLinesTCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.count == 0 {
            return true
        }
        
        if range.location + range.length > detailModel!.countLimited || range.location >= detailModel!.countLimited {
            return false
        }
        
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > detailModel!.countLimited {
            textView.text = String(textView.text.prefix(detailModel!.countLimited))
        }
        ///
        let contentSize = self.textView.contentSize
        let height = contentSize.height
        print("height",height)
        if height != defaultHeight {
            defaultHeight = height
            textView.snp.updateConstraints { (make) in
                make.height.equalTo(defaultHeight).priority(.required)
            }
            self.contentView.updateConstraintsIfNeeded()
            self.contentView.layoutIfNeeded()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let closure = self.finishedClosure else { return }
        closure(textView.text, true)
    }
}
