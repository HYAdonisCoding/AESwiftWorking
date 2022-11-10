//
//  HomeViewController.swift
//  Adam_Surely_Swift
//
//  Created by Adam on 2021/3/24.
//

import UIKit

class HomeViewController: AEBaseTableViewController {
    
    
    
    override func configEvent() {
        super.configEvent()
        
        dataArray = ["StudentsViewController",
                     "HybridHandleViewController",
                     "HybridViewController",
                     "TestRxSwiftViewController",
                     "AETestViewController",
                     "AEProgressBarViewController",
                     "AEGradientAnimationViewController",
                     "AEChartsTableViewController",
                     "AEOperationViewController",
                     "AEEventViewController",
                     "AEFormViewController",
                     "AEXLFormViewController",
                     "AEEmptyViewController",
                     "SemaphoreViewController",
                     "DispatchGroupViewController",
                     "WKWebViewController"]
    }
    
    override func configUI() {
        super.configUI()
        tableView.tableFooterView = UIView()
        navigationItem.title = "Swift Study"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(rightBarAction))
        let dec = NSDecimalNumber.init(floatLiteral: 0.56789)
        let dec1 = NSDecimalNumber.init(string: "0.56789")
        let float = Float("0.56789")!
        print("\(dec) \n\(dec1)\n\(float)\n\(Int.max)\n\(Int.min)")
        
        /// test method change
        let Vc = TestObject()
        Vc.myMethod(name: "中国", age: 5000)
        
        let a = TestFunc()
        a.method2()
        a.method1()
    }

}

extension HomeViewController {

    @objc func rightBarAction() {
        AEArcSelectionView.shared { (idx, title) in
            print("idx:\(idx) title:\(title)")
            
            if idx == 0 {
                let vc = AEFormViewController()
                vc.navigationItem.title = title
                vc.style = .grouped
                vc.separatorStyle = .none
                self.navigationController?.pushViewController(vc, animated: true)
            } else if idx == 1 {
                let vc = AEReceiveMessagesViewController()
                vc.navigationItem.title = title
                self.navigationController?.pushViewController(vc, animated: true)
            } else if idx == 2 {
                let vc = AEReceiveMessagesViewController()
                vc.navigationItem.title = title
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "reuseIdentifier"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        cell!.textLabel?.text = dataArray?[indexPath.row] as? String
        cell!.backgroundColor = ((indexPath.row%2) != 0) ? UIColor.systemTeal : UIColor.orange
        cell!.textLabel?.textColor = ((indexPath.row%2) != 0) ? UIColor.yellow : UIColor.magenta
        var detail = dataArray?[indexPath.row] ?? ""
        detail = "About "+(detail as AnyObject).replacingOccurrences(of: "ViewController", with: "")+" Something!"
        cell!.detailTextLabel?.text = detail as? String
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //1.获取命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else{
            print("没有获取到命名空间")
            return
        }
        //2.根据字符串获取对应的Class
        let detail = dataArray?[indexPath.row]
        // 生成 当前类
        let cls : AnyClass? = NSClassFromString(nameSpace+"."+(detail as? String)!)
        // 如果不是 UIViewController类型,则renturn
        guard let clsType = cls as? UIViewController.Type else{
            print("Can not append")
            return;
        }

        
        var vc = clsType.init()
        if let vc = vc as? AEFormViewController {
            vc.style = .grouped
            vc.separatorStyle = .none
        }

        vc.navigationItem.title = (detail as AnyObject).replacingOccurrences(of: "ViewController", with: "")
        navigationController?.pushViewController(vc, animated: true)
    }
}
