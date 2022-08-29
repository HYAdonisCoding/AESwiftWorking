//
//  Car.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2022/8/11.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

@objc(AECar)
@objcMembers class Car: NSObject {
    var price: Double
    @objc(name)
    var band: String
    init(price: Double, band: String) {
        self.price = price
        self.band = band
    }
    @objc(drive)
    func run() { print(price, band, "run") }
    static func run() { print("Car run") }
}
extension Car {
    @objc(exec:v2:)
    func test(name: String, price: Int) { print(price, band, "test") }
}
