//
//  ICDateSelectionView.swift
//  ICMS
//
//  Created by Adam on 2021/2/23.
//

import Foundation

typealias ICDateSelectionClosure = (_ dateString: String) -> Void
class ICDateSelectionView: ICBaseView {
    class func dateSelectionView(_ title: String, _ closure: @escaping ICDateSelectionClosure) -> Void {
        let view = ICDateSelectionView(frame: UIScreen.main.bounds)
        view.dateSelectionClosure = closure
//        view.titleLabel.text = title
        
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    
    var dateSelectionClosure: ICDateSelectionClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let calenderView: CalenderView = {
        let v = CalenderView(theme: .light)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
    }

    
    override func configEvent() {
        super.configEvent()
    }
    
    override func configUI() {
        super.configUI()
        self.addSubview(self.backView)
        self.backView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.addSubview(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.left.equalTo(27)
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
//        self.bottomView.addSubview(self.titleLabel)
//        self.titleLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(10)
//            make.right.equalTo(-80)
//            make.left.equalTo(80)
//            make.height.equalTo(22)
//        }
        
        
        self.bottomView.addSubview(self.cancelBtn)
        self.cancelBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-15)
            make.left.equalTo(15)
            make.height.equalTo(32)
            make.width.equalTo(100)
        }
        
        self.bottomView.addSubview(self.ensureBtn)
        self.ensureBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-15)
            make.right.equalTo(-15)
            make.height.equalTo(32)
            make.width.equalTo(100)
        }
        
        
        let line = UIView()
        line.backgroundColor = UIColor.colorHex(0xD3D1D7)
        self.bottomView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(1)
            make.bottom.equalTo(self.ensureBtn.snp.top).offset(-20)
        }
        self.bottomView.addSubview(self.calenderView)
        

//        calenderView.heightAnchor.constraint(equalToConstant: 365).isActive=true
        
//        self.calenderView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
//            make.left.right.equalTo(0)
//            make.bottom.equalTo(line.snp.top).offset(-10)
//        }
        
        
//        self.datePicker.backgroundColor = UIColor.yellow
//        self.bottomView.addSubview(self.datePicker)
//        self.datePicker.snp.makeConstraints { (make) in
//            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
//            make.left.right.equalTo(0)
//            make.bottom.equalTo(line.snp.top).offset(-10)
//        }
        
        self.layoutIfNeeded()
        self.ensureBtn.applyGradient(colours: [UIColor.colorHex(0xE8B377), UIColor.colorHex(0xA96E2B)])
        calenderView.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 10).isActive=true
        calenderView.widthAnchor.constraint(equalTo: self.bottomView.widthAnchor, constant: -20).isActive=true
        calenderView.leftAnchor.constraint(equalTo: self.bottomView.leftAnchor, constant: 10).isActive=true
        calenderView.bottomAnchor.constraint(equalTo: line.bottomAnchor, constant: 0).isActive=true
    }
    
//    private lazy var titleLabel: UILabel = {
//        let name = UILabel()
//        name.textColor = UIColor.black
//        name.font = UIFont.systemFont(ofSize: 17)
//        name.textAlignment = .center
//        return name
//    }()
    

    private lazy var backView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.colorHex_Alpha(value: 0x000000, alpha: 0.7)
        return view
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var ensureBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        
        button.backgroundColor = UIColor.colorHex(0xE8B377)
        button.setTitle("确定", for: .normal)
        button.tag = 1
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(buttonClickedAction(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        
        button.backgroundColor = UIColor.colorHex(0xD3D1D7)
        button.setTitle("取消", for: .normal)
        button.tag = 0
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(buttonClickedAction(button:)), for: .touchUpInside)
        return button
    }()
    
//    private lazy var datePicker: UIDatePicker = {
//        let datePicker = UIDatePicker(frame: CGRect.zero)
//        datePicker.datePickerMode = .date
//        datePicker.locale = Locale(identifier: "zh_CN")
//        if #available(iOS 14.0, *) {
//            datePicker.preferredDatePickerStyle = .inline
//        } else {
//            // Fallback on earlier versions
//        }
//
//        datePicker.addTarget(self,action: #selector(datePickerValueChange(datePicker:)),for: .valueChanged)
//        return datePicker
//    }()
    

    
    
 
    @objc func buttonClickedAction(button: UIButton) -> Void {
        if button.tag == 0 {
            self.removeFromSuperview()
        } else if button.tag == 1 {
            debugPrintLog("回调")
            guard let closure = self.dateSelectionClosure else { return }
            guard let date = calenderView.selectedDate else { return }
            closure(date)
            self.removeFromSuperview()
        }
    }
    
    @objc func datePickerValueChange(datePicker: UIDatePicker) -> Void {
        debugPrintLog(datePicker.date)
    }
}

extension ICDateSelectionView {
    
}
