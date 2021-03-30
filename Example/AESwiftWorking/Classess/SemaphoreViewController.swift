//
//  SemaphoreViewController.swift
//  Adam_Surely_Swift
//
//  Created by Adam on 2021/3/24.
//

import Foundation
import UIKit

class SemaphoreViewController: BaseViewController {
    
    override func configEvent() {
        super.configEvent()
        
        
    }
    
    override func configUI() {
        super.configUI()
        
        //初始化信号量为1
        let semaphore = DispatchSemaphore(value: 0)
        work(semaphore, time: 1)
        
        work(semaphore, time: 2)
        work(semaphore, time: 3)
        
        semaphore.wait()
        semaphore.wait()
        semaphore.wait()
        print("coming....")
        
    }
       
//    func work(_ semaphore: DispatchSemaphore) {
//        print("coming\(semaphore)")
//        sleep(3)
//        semaphore.signal()
//        print("work finish \(semaphore)")
//
//    }

    /// 信号量不需要和队列一起使用的
    func work(_ semaphore: DispatchSemaphore, time: Int) {
        let queue = DispatchQueue(label: "test_1", qos: .background)
        queue.async {
            print("coming -- time:\(time)")
            sleep(3)
            print("work finish -- time:\(time)")
            semaphore.signal()
        }
        
    }
}
