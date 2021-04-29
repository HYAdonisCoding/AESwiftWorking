//
//  ICShowInfoTCell.swift
//  ICMS
//
//  Created by Adam on 2021/4/26.
//

import UIKit

class ICShowInfoTCell: ICBaseTableViewCell {

    override class func loadCode(tableView: UITableView, index: IndexPath) -> ICShowInfoTCell {
        let identifier: String = String(describing: self)
        tableView.register(ICShowInfoTCell.self, forCellReuseIdentifier: identifier)
        let cell: ICShowInfoTCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index) as! ICShowInfoTCell
        cell.selectionStyle = .none
        cell.indexPath = index
        cell.configEvent()
        cell.configUI()
        
        return cell
    }
    
    override func configEvent() {
        super.configEvent()
    }
    override func configUI() {
        super.configUI()
        
        //titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        let _ = titleLabel

        let _ = detailLabel
        detailLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
    }
    
    private lazy var titleLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 13)
        name.textColor = UIColor.colorHex(0x655A72)
        name.textAlignment = .left
        contentView.addSubview(name)
        name.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(2)
//            make.bottom.equalToSuperview().offset(-2)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(18)
        }
        return name
    }()
    
    private lazy var detailLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 13)
        name.textColor = UIColor.colorHex(0x655A72)
        name.textAlignment = .left
        name.numberOfLines = 0
        contentView.addSubview(name)
        name.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(2)
            make.height.greaterThanOrEqualTo(titleLabel.snp.height)
            make.left.equalTo(titleLabel.snp.right).offset(5)
            make.right.lessThanOrEqualTo(-10)
            make.bottom.equalToSuperview().offset(-2)
        }
        return name
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var showInfoModel: ICShowInfoModel? {
        didSet {
            titleLabel.text = showInfoModel?.title
            detailLabel.text = showInfoModel?.detailInfo
            //
            if showInfoModel?.boldFont == true {
                titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
                titleLabel.textColor = UIColor.colorHex(0x231A2F)
                detailLabel.font = UIFont.boldSystemFont(ofSize: 14)
                detailLabel.textColor = UIColor.colorHex(0x231A2F)
            } else {
                titleLabel.font = UIFont.systemFont(ofSize: 13)
                titleLabel.textColor = UIColor.colorHex(0x655A72)
                detailLabel.font = UIFont.systemFont(ofSize: 13)
                detailLabel.textColor = UIColor.colorHex(0x655A72)
            }
        }
    }
    
}
