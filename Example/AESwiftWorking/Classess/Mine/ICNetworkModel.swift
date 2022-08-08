//
//  ICNetworkModel.swift
//  ICMS
//
//  Created by Adam on 2021/2/5.
//

import Foundation
////import HandyJSON  

struct ICNetworkModel: Codable {
    
    var head: ICNetworkHeadModel?
//    var body: Any?
}

struct ICNetworkHeadModel: Codable {

    var ibsreturnCode:  String?
    var transCode:  String?
    var ibsreturnMsg:  String?
    var interfaceSignature:  String?
    var isEncrypiton:  String?
}

struct ICBNetworkModel: Codable {
    var body: ICNetworkBodyModel?
}
struct ICNetworkBodyModel: Codable {
    
    var sysexplain: String? ///            更新提示
    var isForced: String?   ///            强更标识
    var sysAddress: String? ///            新版本下载地址
    var isRegister: String? ///            是否注册
    var name: String?   ///            姓名
    var userimei: String?   ///            机器码
    var signKey: String? ///            随机数
    var publicKey: String?  ///            公钥
    var userPhoneNum: String?   ///            手机号
    var ipStr: String?  ///            ip地址

}
struct ICResponseRegisterModel: Codable {
    var body: ICRegisterModel?
    
}
struct ICRegisterModel: Codable {
    var isMsg: String? ///  0  失败1 成功
    
}
struct ICResponseChangePwdModel: Codable {
    var body: ICChangePwdModel?
}
struct ICChangePwdModel: Codable {
    var code: String? ///     ok 成功 err失败
    var msg: String? ///     话术

}
struct ICResponseLoginModel: Codable {
    var body: ICLoginModel?
    
}
struct ICLoginModel: Codable {
    var name: String? ///            姓名
    var userIdNo: String? ///            身份证号
    var userPhoneNum: String? ///            手机号
    var isrRegister: String? ///            是否注册绑定
    var position: String? ///            职位
    var privateKey2048: String? ///            非对称密钥
    //var aesKey: String? ///            aes
    var appVersion: String? ///            版本号
    var institutions: String? ///            催收机构
    var institutionsnum: String? ///            催收机构编码
    var sex: String? ///            催收性别
    var age: String? ///            催收年龄
    var userno: String? ///            催收工号
    var extensionNum: String? ///            催收分机号
    // 权限: 1 打卡 2 统计
    var powerNum: String?
    var seateNo: String? ///            催收坐席号
    var undertakeBatch: String? ///            催收承接批次
    var undertakeAge: String? ///            催收承接帐龄
    var belongGroup: String? ///            催收所属催收组
    var inTheTime: String? ///            催收入职时间
    var inTheYear: String? ///            催收入职年限
    var theCouple: String? ///            催收是否新人
    var registration: String? ///            催收户籍
    var school: String? ///            催收毕业院校
    var education: String? ///            催收学历
    var recruitment: String? ///            催收招聘来源
    var companyAddress: String? ///            催收单位地址
    var img: String? ///            催收人像地址
    var punchCard: ICWorkingDaysModel?

//    override func mapping(mapper: HelpingMapper ) {
//            // specify 'cat_id' field in json map to 'id' property in object
//            mapper <<<
//                extensionPhone <-- "extension"
////        mapper.specify(property: &extensionPhone, name: "extension")
//    }
//    required init() {}
}

struct ICWorkingDaysModel: Codable {
    // 本月工作天数
    var monthlyPunchCardCount: Int?
    // 本年工作天数
    var yearPunchCardCount: Int?
}
extension ICLoginModel {
    
}
