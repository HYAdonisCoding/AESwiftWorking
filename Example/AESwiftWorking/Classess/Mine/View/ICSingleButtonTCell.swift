//
//  ICSingleButtonTCell.swift
//  ICMS
//
//  Created by Adam on 2021/4/22.
//

import UIKit

typealias SingleButtonClosure = (_ data: Any?) -> Void

class ICSingleButtonTCell: ICBaseTableViewCell {
    var singleButtonClosure: SingleButtonClosure?
    
    override class func loadCode(tableView: UITableView, index: IndexPath) -> ICSingleButtonTCell {
        let identifier: String = String(describing: self)
        tableView.register(ICSingleButtonTCell.self, forCellReuseIdentifier: identifier)
        let cell: ICSingleButtonTCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: index) as! ICSingleButtonTCell
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
        
        self.backgroundColor = kBackGroundcolor
        contentView.backgroundColor = kBackGroundcolor
        
        let _ = operationButton
        
        
    }
    
    private lazy var operationButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(operationButtonClickedAcition(_:)), for: UIControl.Event.touchUpInside)
        
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(40)
        }
        return button
    }()
    var titleString: String? {
        didSet {
            operationButton.setTitle(titleString, for: .normal)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        operationButton.applyGradient(colours: [UIColor.colorHex(0xE8B377), UIColor.colorHex(0xA96E2B)])
        let width = ScreenWidth-30
        operationButton.configRectCorner(corner: [.allCorners], radii: CGSize(width: width, height: 40))
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ICSingleButtonTCell {
    @objc func operationButtonClickedAcition(_ button: UIButton) {
        guard let closure = singleButtonClosure else { return }
        closure(nil)
    }
}
