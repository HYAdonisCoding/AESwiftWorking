//
//  TestRxSwiftViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2022/8/31.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift

class TestRxSwiftViewController: UIViewController {

    var label: UILabel = UILabel()
    var button = UIButton()
    
    var bag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.systemPink
        label.frame = CGRect(x: 20, y: 100, width: 200, height: 50)
        view.addSubview(label)
        label.text = "Start"
        
        button.frame = CGRect(x: 20, y: 160, width: 200, height: 50)
        view.addSubview(button)
        button.setTitle("Stop", for: .normal)
        
        let observable = Observable<Int>.timer(.seconds(2),
                                               period: .seconds(1),
                                               scheduler: MainScheduler.instance)
        let binder = Binder<Bool>(button) { button, value in
            button.isHidden = value
        }
        observable.map { $0 % 2 == 0}.bind(to: binder).disposed(by: bag)
    }
     
    func test3() {
        let binder = Binder(label) { label, value in
            label.text = value
        }
        Observable.just(1).map { "数值为\($0)" }.subscribe(binder).dispose()
        Observable.from([1, 2, 3]).map { "数值为\($0)" }.bind(to: binder).dispose()
    }
     
    func test2() {
        let observable = Observable<Int>.timer(.seconds(3),
                                               period: .seconds(1),
                                               scheduler: MainScheduler.instance)
        observable
            .map{ "数值为\($0)"}
            .bind(to: label.rx.text)
            .disposed(by: bag)
        
    }
    func test1() {
        /*
         Disposable
        ■每当Observable被订阅时,都会返回一个Disposable实例,当调用Disposable的dispose ,就相当于取消订阅
        ■在不需要再接收事件时,建议取消订阅,释放资源。有3种常见方式取消订阅
        
         */
        let observable = Observable.from([1, 2, 3])
        //立即取消订阅(一次性订阅)
        observable.subscribe { event in
            print (event )
        }.dispose()
        //当bag销毁(deinit) 时，会自动调用Disposab le实例的dispose
        observable.subscribe { event in
            print(event)
        }.disposed(by: bag)
        // self销毁时(deinit) 时，会自动调用Disposable实例的dispose
        let _ = observable.takeUntil(self.rx.deallocated).subscribe { event in
            print(event)
        }
        
    
//        let observable = Observable<Int>.create { observer in
//            observer.onNext(1)
//            observer.onNext(2)
//            observer.onNext(3)
//            observer.onCompleted()
//            return Disposables.create()
//        }
//        let observable = Observable.of(1, 2, 3)
//        let observable = Observable.from([1, 2, 3])
//        observable.subscribe (onNext: {
//            print("next", $0)
//        }, onError: {
//            print("onError", $0)
//        }, onCompleted: {
//            print("onCompleted")
//        }, onDisposed: {
//            print("onDisposed")
//        }).dispose()

        
        observable.subscribe{ event in
            print(event)
        }.dispose()
        
//        let observable = Observable<Int>.create { observer in
//            observer.onNext(1)
//            observer.onCompleted()
//            return Disposables.create()
//        }
//        let observable = Observable.just(1)
//        let observable = Observable.of(1)
//        let observable = Observable.from([1])
//
//        observable.subscribe{ event in
//            print(event)
//        }.dispose()
//
    }
    


}
