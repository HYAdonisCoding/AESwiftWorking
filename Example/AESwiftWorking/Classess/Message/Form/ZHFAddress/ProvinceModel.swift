//
//  ProvinceModel.swift
//  AmazedBox
//
//  Created by 张海峰 on 2017/12/11.
//  Copyright © 2017年 张海峰. All rights reserved.
/*
 这个对应的分别是省，市，县，乡镇把属性改成自己的就可以了。
 */

import UIKit
//import ObjectMapper
struct ProvinceModel: Codable {
    var id :NSInteger = 0 //
    var province_id :NSInteger = 0 //
    var province_name :String? //
//    mutating func mapping(map: Map) {
//        id    <- map["id"]
//        province_name    <- map["province_name"]
//    }
    

//    init?(map: Map) {
//    }
    enum CodingKeys: String, CodingKey {
//        case province_id = "id"
        case province_name
        case id
    }
}
struct CityModel: Codable {
    var city_name :String? //
    var id :NSInteger = 0 //
    var province_id :NSInteger = 0 //
//    mutating func mapping(map: Map) {
//        id    <- map["id"]
//        city_name    <- map["city_name"]
//        province_id    <- map["province_id"]
//    }
//    init?(map: Map) {
//    }
    enum CodingKeys: String, CodingKey {
//        case province_id = "id"
        case city_name
        case id
    }
}
struct CountyModel: Codable {
    var city_id :NSInteger = 0 //
    var county_name :String? //
    var id :NSInteger = 0 //

//    init?(map: Map) {
//    }
    enum CodingKeys: String, CodingKey {
//        case city_id = "id"
        case county_name
        case id
    }
}
struct TownModel: Codable {
    var county_id :NSInteger = 0 //
    var town_name :String? //
    var id :NSInteger = 0 //
//    mutating func mapping(map: Map) {
//        id    <- map["id"]
//        town_name    <- map["town_name"]
//        county_id    <- map["county_id"]
//    }
//    init?(map: Map) {
//    }
    enum CodingKeys: String, CodingKey {
//        case county_id = "id"
        case town_name
        case id
    }
}
