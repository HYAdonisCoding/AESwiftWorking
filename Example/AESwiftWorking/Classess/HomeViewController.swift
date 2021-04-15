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
        
        dataArray = ["AEXLFormViewController",
                     "AEFormViewController",
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
    }

}

extension HomeViewController {

    @objc func rightBarAction() {
        AEArcSelectionView.shared { (idx, title) in
            print("idx:\(idx) title:\(title)")
            
            var mutile = 6
            let Block: ((Int) -> Int)? = { num in
                return num * mutile
            }
            mutile = 4
            
            print("\(String(describing: Block?(2)))")
        };
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
//        if let _ = cls as? AEXLFormViewController.Type {
//            if #available(iOS 13.0, *) {
//                vc = AEFormViewController().init
//            } else {
//                // Fallback on earlier versions
//                vc = AEFormViewController(style:.grouped)
//
//            }
//        }

        vc.navigationItem.title = (detail as AnyObject).replacingOccurrences(of: "ViewController", with: "")
        navigationController?.pushViewController(vc, animated: true)
    }
}
