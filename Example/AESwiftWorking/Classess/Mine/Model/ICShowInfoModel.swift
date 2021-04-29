//
//  ICShowInfoModel.swift
//  ICMS
//
//  Created by Adam on 2021/4/26.
//

import Foundation

enum ICInfoType {
    case show
    case action
}

struct ICShowInfoModel {
    var title: String?
    var detailInfo: String?
    
    var type: ICInfoType = .show
    
    var boldFont: Bool = false
}
