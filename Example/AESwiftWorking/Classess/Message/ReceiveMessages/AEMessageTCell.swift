//
//  AEMessageTCell.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/28.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEMessageTCell: AEBaseTableViewCell {

    override class func loadCode(tableView: UITableView, index: IndexPath) -> AEMessageTCell {
        let identifier: String = String(describing: AEMessageTCell.self)
        tableView.register(AEMessageTCell.self, forCellReuseIdentifier: identifier)
        let cell: AEMessageTCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index as IndexPath) as! AEMessageTCell
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

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.colorHex(0x231A2F)
        label.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(20)
        }
        return label
    }()
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.colorHex(0x655A72)
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines =  0
        contentView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-15)
            make.height.greaterThanOrEqualTo(20)
            make.bottom.equalToSuperview().offset(-10)
        }
        return label
    }()
    
    private lazy var newImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "unread_icon"))
        contentView.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(4)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 6, height: 6))
        }
        return image
    }()
    


}

extension AEMessageTCell {
    override func configEvent() {
        super.configEvent()
    }
    
    override func configUI() {
        super.configUI()
        
        let _ = titleLabel
        let _ = detailLabel
        
        let _ = newImageView
        
    }
}
