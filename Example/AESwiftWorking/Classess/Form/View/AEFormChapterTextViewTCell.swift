//
//  AEFormChapterTextViewTCell.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/20.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

let kCountlimited = 1000


class AEFormChapterTextViewTCell: AEFormBaseTCell {

    override class func loadCode(tableView: UITableView, index: IndexPath) -> AEFormChapterTextViewTCell {
        let identifier: String = String(describing: AEFormChapterTextViewTCell.self)
        tableView.register(AEFormChapterTextViewTCell.self, forCellReuseIdentifier: identifier)
        let cell: AEFormChapterTextViewTCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index as IndexPath) as! AEFormChapterTextViewTCell
        cell.selectionStyle = .none
        cell.indexPath = index
        cell.configEvent()
        cell.configUI()

        return cell
    }
    override func configUI() {
        super.configUI()
        let _ = textView
        let _ = timesLabel
        
    }
    private lazy var textView: AETextView = {
        let textView = AETextView()
        textView.delegate = self
        textView.placeHolderStr = "请输入"
        backView.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-17)
            make.height.greaterThanOrEqualTo(100)
        }
        return textView
    }()
    private lazy var timesLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.colorHex(0xD3D1D7)
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "0/"+String(kCountlimited)+"字"
        backView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.height.equalTo(17)
        }
        return label
    }()
    

    
    override var detailModel: AEFormModel? {
        didSet {
            if (detailModel?.title?.count ?? 0) > 0 {
                titleLabel.text = detailModel?.title
            }
            if let inpout = detailModel?.value {
                textView.text = inpout
                if inpout.count > 0 {
                    timesLabel.text = String(inpout.count)+"/"+String(kCountlimited)+"字"
                }

            }

        }
    }
}

extension AEFormChapterTextViewTCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.count == 0 {
            return true
        }
        
        if range.location + range.length > kCountlimited || range.location >= kCountlimited {
            return false
        }
        
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > kCountlimited {
            textView.text = String(textView.text.prefix(kCountlimited))
        }
        timesLabel.text = String(textView.text.count)+"/"+String(kCountlimited)+"字"
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let closure = self.closure else { return }
        closure(textView.text)
    }
}


class AETextView: UITextView {
    
    var placeHolderStr = "请输入" {
        didSet{
            holderView.text = placeHolderStr
        }
    }
    
    
    lazy var holderView: UITextView = {
        let holder = UITextView(frame: CGRect.zero)
        holder.isUserInteractionEnabled = false
        holder.backgroundColor = UIColor.clear
        holder.text = "这里是占位符"
        holder.textColor = UIColor.lightGray
        holder.isEditable = false
        holder.isHidden = self.hasText
        return holder
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLab()
    }
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupLab()
    }
    func setupLab() -> Void {
        addSubview(holderView)
        NotificationCenter.default.addObserver(self, selector: #selector(textHaveChangeText), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        holderView.frame = bounds
    }
    
    override var text: String! {
        didSet{
            holderView.isHidden = self.hasText
        }
    }
    
    /// 改变文字了
    @objc func textHaveChangeText() ->Void {
        holderView.isHidden = self.hasText
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
