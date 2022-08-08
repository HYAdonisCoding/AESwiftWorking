//
//  ICSimpleTCell.swift
//  ICMS
//
//  Created by Adam on 2021/4/21.
//

import UIKit

class ICSimpleTCell: ICBaseTableViewCell {

    override class func loadCode(tableView: UITableView, index: IndexPath) -> ICSimpleTCell {
        let identifier: String = String(describing: self)
        tableView.register(ICSimpleTCell.self, forCellReuseIdentifier: identifier)
        let cell: ICSimpleTCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index) as! ICSimpleTCell
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
        
        let _ = titleLabel
        let _ = rightImageView
        
    }
    
    private lazy var titleLabel: UILabel = {
        let name = UILabel()
        contentView.addSubview(name)
        name.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.right.lessThanOrEqualTo(rightImageView.snp.left).offset(-10)
            make.height.equalTo(20)
        }
        return name
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "show_all_icon")
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
//            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        return imageView
    }()
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var titleString: String? {
        didSet {
            titleLabel.text = titleString
        }
    }
    
}
