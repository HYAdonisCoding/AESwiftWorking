//
//  StudentsViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2022/11/9.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import SwiftyJSON

class StudentsViewController: AEBaseTableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configEvent() {
        super.configEvent()
        self.dataArray = []
        getAllData()
    }
    override func configUI() {
        super.configUI()
        
        tableView.tableFooterView = UIView()
        navigationItem.title = "Net Study"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarAction))
        tableView.reloadData()
    }
}

extension StudentsViewController {
    func getAllData() {
        AF.request("http://127.0.0.1:8080/test/getAllUser", method: .post).response { response in
            do {
                guard let dict = try response.result.get() else {
                    print("error response")
//                    self.tableView.mj_header?.endRefreshing()
                    return
                }
//                let dict = try response.result.get()
                print("1")
                let json = try JSON(data: dict )["data"].arrayObject
//                let str = String(data: dict, encoding: String.Encoding.utf8)
//                let json = JSON(str ?? "[\"\"]")["items"].arrayObject
                guard let models = json?.kj.modelArray(StudentModel.self) else {
                    print("error modelArray")
//                    self.tableView.mj_header?.endRefreshing()
                    return
                }
                print("2")
                
                self.dataArray?.removeAll()
                self.dataArray?.append(contentsOf: models)
                //重新加载数据
                self.tableView.reloadData()
                //接收加载
//                self.tableView.mj_header?.endRefreshing()
                
                //下拉刷新完成后，将配置置为 1
//                self.page = 1
            } catch {
                print("loadNewData error", error)
//                self.tableView.mj_header?.endRefreshing()
            }
        }

    }
    func addSutdentData(name: String, age: String, height: String) {
        let params = ["name": name, "age": age, "height": height]
        AF.request("http://127.0.0.1:8080/test/addUser", method: .post, parameters: params).response { response in
            do {
                guard let dict = try response.result.get() else {
                    print("error response")
//                    self.tableView.mj_header?.endRefreshing()
                    return
                }
                print("1")
                let json = try JSON(data: dict )["code"].stringValue
                if json == "0" {
                    self.getAllData()
                }
                //接收加载
//                self.tableView.mj_header?.endRefreshing()
                
                //下拉刷新完成后，将配置置为 1
//                self.page = 1
            } catch {
                print("loadNewData error", error)
//                self.tableView.mj_header?.endRefreshing()
            }
        }

    }
    @objc func rightBarAction() {
        // add
        let alert = UIAlertController(title: "办理入学", message: "请输入完整信息", preferredStyle: .alert)
        alert.addTextField() { textField in
            textField.placeholder = "name"
            textField.tag = 1
        }
        alert.addTextField() { textField in
            textField.placeholder = "age"
            textField.tag = 2
        }
        alert.addTextField() { textField in
            textField.placeholder = "height"
            textField.tag = 3
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .default){_ in
            print("来了")
            let name = alert.textFields?.first?.text
            let age = alert.textFields?[1].text
            let height = alert.textFields?.last?.text
            self.addSutdentData(name: name ?? "", age: age ?? "", height: height ?? "")
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "reuseIdentifier"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        let s = dataArray?[indexPath.row] as? StudentModel
        cell!.textLabel?.text = s?.name
        cell!.backgroundColor = UIColor.systemTeal
        let age = s?.age, height = s?.height
        cell!.detailTextLabel?.text = "age:\(age!)周岁, height:\(height!)米"
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
