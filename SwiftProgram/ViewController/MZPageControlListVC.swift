//
//  MZPageControlListVC.swift
//  SwiftProgram
//
//  Created by Mr.Z on 2020/5/13.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

import UIKit

class MZPageControlListVC: UIViewController {
    
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
        self.navigationItem.title = "PageControl"
        self.tableView.frame = self.view.bounds
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "identifier")
        self.view.addSubview(self.tableView)
        self.dataSource = ["默认", "颜色","位置", "大小", "圆角", "图片", "动画"]
        let bannerView = MZBannerView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 150.0))
        bannerView.placeholderImage = UIImage(named: "icon_placeholder")
        bannerView.setImageUrlsGroup(["http://t.cn/RYVfQep",
                                      "http://t.cn/RYVfgeI",
                                      "http://t.cn/RYVfsLo",
                                      "http://t.cn/RYMuvvn",
                                      "http://t.cn/RYVfnEO",
                                      "http://t.cn/RYVf1fd"])
        bannerView.pageControlSize = CGSize(width: 10.0, height: 10.0)
        bannerView.pageControlCurrentSize = CGSize(width: 10.0, height: 10.0)
        bannerView.pageControlRadius = 5.0
        bannerView.pageControlCurrentRadius = 5.0
        bannerView.pageControlAlignment = .center
        bannerView.pageControlIsClickEnable = false
        tableView.tableHeaderView = bannerView
        tableView.tableFooterView = UIView()
    }
}

extension MZPageControlListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        cell.textLabel?.text = self.dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let testVC = MZPageControlVC()
        testVC.type = indexPath.row
        self.navigationController?.pushViewController(testVC, animated: true)
    }
}
