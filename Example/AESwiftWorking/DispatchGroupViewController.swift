//
//  DispatchGroupViewController.swift
//  Adam_Surely_Swift
//
//  Created by Adam on 2021/3/24.
//

import Foundation

class DispatchGroupViewController: BaseViewController {
    
    override func configEvent() {
        super.configEvent()
        
        chenTest()
    }
    
    override func configUI() {
        super.configUI()
    }
    func chenTest() {
        let group = DispatchGroup();
        let queue1 = DispatchQueue(label: "jc.test.com1", qos: .utility, attributes: .concurrent)
        let queue2 = DispatchQueue(label: "jc.test.com2", qos: .utility, attributes: .concurrent)
        let queue3 = DispatchQueue(label: "jc.test.com3", qos: .utility, attributes: .concurrent)
        group.enter()
        queue1.async(group: group){
        group.leave()
          print("queue1.async")
        }


        group.enter()
        queue2.async(group: group){
        group.leave()
            print("queue2.async")
        }


        group.enter()
        queue3.async(group: group){
        group.leave()
            print("queue3.async")
        }

        group.notify(queue: DispatchQueue.main){
           print("group.notify")
        }
    }
    
    func testDispatchGroup() {
        let group = DispatchGroup()
        
        
        /*
         label: 队列的名称
         qos: 优先级
                default 默认
                background 用于创建的维护或清理任务的服务质量类。
                userInteractive 用户交互任务的服务质量类，例如动画、事件处理或更新应用程序的用户界面。
                userInitiated 用于阻止用户主动使用应用程序的任务的服务质量类。
                unspecified 缺少服务质量等级。
                utility 用户未主动跟踪的任务的服务质量类。
         attributes: 要与队列关联的属性。包括concurrent属性以创建并发执行任务的调度队列。如果省略该属性，则调度队列将连续执行任务。
            .concurrent: 队列同时调度任务。(并发)
            .initiallyInactive 新创建的队列处于非活动状态。(初始不活动)
         autoreleaseFrequency
         自动释放由队列调度的块创建的对象的频率。有关可能值的列表，请参见DispatchQueue.AutoreleaseFrequency发送队列.
            
            .inherit 队列从目标队列继承其自动释放频率。
            .workItem 队列在执行块之前配置自动释放池，并在块完成执行后释放池中的对象。
            .never 队列没有在执行的块周围设置自动释放池。
         target 要在其上执行块的目标队列。如果希望系统提供适合当前对象的队列，请指定DISPATCH_ TARGET_QUEUE_DEFAULT。
         
        */
        let queue = DispatchQueue(label: "Test_Queue", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .inherit, target: DispatchQueue.global(qos: .default))
        
//        queue.async {
//            print("work 1")
//            group.enter()
//            sleep(4)
//            print("work 1 finished")
//            group.leave()
//        }
//
//        work("1", queue: queue, group: group)
        for i in 0...100 {
            print(i)
            queue.async { [self] in
                work(String(i), queue: queue, group: group)
            }
        }
        group.notify(queue: queue) {
            print("coming")
        }
    }
    
    func work(_ name: String, queue: DispatchQueue, group: DispatchGroup) {
        queue.async {
            print("work \(name)")
            group.enter()
            sleep(1)
            print("work \(name) finished")
            group.leave()
        }
    }
}
