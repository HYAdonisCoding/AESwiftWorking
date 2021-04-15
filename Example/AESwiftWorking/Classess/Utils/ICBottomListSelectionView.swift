//
//  ICBottomListSelectionView.swift
//  ICMS
//
//  Created by Adam on 2021/2/23.
//

import Foundation

class ICSelectionModel: ICBaseModel {
    var title: String?
    var idx: Int?
}
/// 选中的回调
typealias ICBottomListSelectionClosure = (_ selected: ICSelectionModel?) -> Void


class ICBottomListSelectionView: ICBaseView {
    class func bottomListSelectionView(_ title: String, data: [String], selected: String = "", _ closure: @escaping ICBottomListSelectionClosure) -> Void {
        let view = ICBottomListSelectionView(frame: UIScreen.main.bounds)
        view.bottomListSelectionClosure = closure
        view.titleLabel.text = title
        view.dataArray = data
        let model = ICSelectionModel()
        model.idx = 0
        model.title = data.first
        
        var selectedModel: ICSelectionModel = model
        for (i, title) in data.enumerated() {
            if selected == title {
                let model = ICSelectionModel()
                model.idx = i
                model.title = title
                selectedModel = model
            }
        }
        view.selected = selectedModel
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    
    var bottomListSelectionClosure: ICBottomListSelectionClosure?
    var dataArray: [String]? {
        didSet {
            
        }
    }
    private var selected: ICSelectionModel? {
        didSet {
            
            if (selected?.idx ?? 0) > 0 {
                UIView.animate(withDuration: 0.25) { [self] in
                    pickerView.selectRow((selected?.idx ?? 0), inComponent: 0, animated: true)

                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            make.left.right.equalTo(0)
            make.height.equalTo(self.snp.height).multipliedBy(0.32).offset(10)
            make.bottom.equalTo(self.backView.snp.bottom)
        }
        
        self.bottomView.addSubview(self.cancelBtn)
        self.cancelBtn.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.left.equalTo(15)
            make.height.equalTo(20)
            make.width.equalTo(80)
        }
        
        self.bottomView.addSubview(self.ensureBtn)
        self.ensureBtn.snp.makeConstraints { (make) in
            make.top.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(20)
            make.width.equalTo(80)
        }
        
        self.bottomView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.right.equalTo(self.ensureBtn.snp.left).offset(-15)
            make.left.equalTo(self.cancelBtn.snp.right).offset(15)
            make.height.equalTo(22)
        }
        let line = UIView()
        line.backgroundColor = UIColor.colorHex(0xD3D1D7)
        self.bottomView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(1)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
        }
        
        self.bottomView.addSubview(pickerView)
        pickerView.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp.bottom)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-30)
        }
        
    }
    private lazy var titleLabel: UILabel = {
        let name = UILabel()
        name.textColor = UIColor.black
        name.font = UIFont.systemFont(ofSize: 17)
        name.textAlignment = .center
        return name
    }()
    

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
        button.backgroundColor = UIColor.white
        button.setTitle("确定", for: .normal)
        button.contentHorizontalAlignment = .right
        button.tag = 1
        button.setTitleColor(UIColor.colorHex(0xAB702D), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(buttonClickedAction(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.white
        button.setTitle("取消", for: .normal)
        button.contentHorizontalAlignment = .left
        button.tag = 0
        button.setTitleColor(UIColor.colorHex(0xAB702D), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(buttonClickedAction(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: CGRect.zero)
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    

 
    @objc func buttonClickedAction(button: UIButton) -> Void {
        if button.tag == 0 {
            guard let closure = self.bottomListSelectionClosure else {
                self.removeFromSuperview()
                return
            }
            closure(nil)
            self.removeFromSuperview()
        } else if button.tag == 1 {
            debugPrintLog("回调")
            guard let closure = self.bottomListSelectionClosure else {
                self.removeFromSuperview()
                return
            }
            guard let selectedModel = self.selected else {
                self.removeFromSuperview()
                return
            }
            closure(selectedModel)
            self.removeFromSuperview()
        }
    }
}

extension ICBottomListSelectionView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataArray?.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.dataArray?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let model = ICSelectionModel()
        model.title = self.dataArray?[row]
        model.idx = row
        self.selected = model
    }
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        let view = ICBaseView()
//        return view
//    }
}

