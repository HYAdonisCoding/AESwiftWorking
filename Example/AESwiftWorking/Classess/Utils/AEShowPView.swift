//
//  AEShowPView.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/4/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class AEShowPView: AEBaseView {

    var indexPath: IndexPath?
    
//    class func loadCode(pickerView: UIPickerView, index: IndexPath) -> AEShowPView {
//        let identifier: String = String(describing: AEShowPView.self)
//
//        let cell: AEShowPView = pickerView.deq
////        cell.selectionStyle = .none
//        cell.indexPath = index
//        cell.configEvent()
//        cell.configUI()
//
//        return cell
//    }
    override func configEvent() {
        super.configEvent()
    }
    
    override func configUI() {
        super.configUI()
    }

    private lazy var titleLabel: UILabel = {
        let name = UILabel()
        
        
        return name
    }()
    

}

