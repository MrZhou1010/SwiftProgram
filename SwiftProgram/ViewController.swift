//
//  ViewController.swift
//  SwiftProgram
//
//  Created by Mr.Z on 2020/5/13.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var dataSource = [String]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "SwiftProgram"
        self.tableView.frame = self.view.bounds
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
        self.dataSource = ["按钮（图标+文字）", "按钮（扩展点击区域）", "自定义PageControl", "自动轮播图（图片+文字+自定义PageControl）", "地址选择器"]
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        cell.textLabel?.text = self.dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let testVC = MZButtonVC()
            self.navigationController?.pushViewController(testVC, animated: true)
        } else if indexPath.row == 1 {
            let testVC = MZButtonClickEdgeInsetVC()
            self.navigationController?.pushViewController(testVC, animated: true)
        } else if indexPath.row == 2 {
            let testVC = MZPageControlListVC()
            self.navigationController?.pushViewController(testVC, animated: true)
        } else if indexPath.row == 3 {
            let testVC = MZBannerViewListVC()
            self.navigationController?.pushViewController(testVC, animated: true)
        } else if indexPath.row == 4 {
            let testVC = MZAddressSelectedVC()
            self.navigationController?.pushViewController(testVC, animated: true)
        }
    }
}
