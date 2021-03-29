//
//  HomeViewController.swift
//  Adam_Surely_Swift
//
//  Created by Adam on 2021/3/24.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let dataArray = ["SemaphoreViewController", "DispatchGroupViewController", "WKWebViewController"]
    
    override func configEvent() {
        super.configEvent()
        
    }
    
    override func configUI() {
        super.configUI()
        tableView.tableFooterView = UIView()
        navigationItem.title = "Swift"
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "reuseIdentifier"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        cell!.textLabel?.text = dataArray[indexPath.row]
        cell!.backgroundColor = ((indexPath.row%2) != 0) ? UIColor.systemTeal : UIColor.orange
        cell!.textLabel?.textColor = ((indexPath.row%2) != 0) ? UIColor.yellow : UIColor.magenta
        var detail = dataArray[indexPath.row]
        detail = "About "+detail.replacingOccurrences(of: "ViewController", with: "")+" Something!"
        cell!.detailTextLabel?.text = detail
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
        let detail = dataArray[indexPath.row]
        // 生成 当前类
        let cls : AnyClass? = NSClassFromString(nameSpace+"."+detail)
        // 如果不是 UIViewController类型,则renturn
        guard let clsType = cls as? UIViewController.Type else{
            print("Can not append")
            return;
        }

        
        let vc = clsType.init()
        vc.navigationItem.title = detail.replacingOccurrences(of: "ViewController", with: "")
        navigationController?.pushViewController(vc, animated: true)
    }
}
