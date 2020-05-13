//
//  MZBannerViewListVC.swift
//  SwiftProgram
//
//  Created by 木木 on 2020/5/13.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

import UIKit

class MZBannerViewListVC: UIViewController {
    
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
        self.navigationItem.title = "BannerView"
        self.tableView.frame = self.view.bounds
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        self.view.addSubview(self.tableView)
        self.dataSource = ["本地图片", "本地图片+描述文本", "文本", "网络图片", "网络图片+描述文本"]
        let bannerView = MZBannerView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 150))
        bannerView.placeholderImage = UIImage(named: "placeholder")
        bannerView.setImageUrlsGroup(["http://t.cn/RYVfQep",
                                      "http://t.cn/RYVfgeI",
                                      "http://t.cn/RYVfsLo",
                                      "http://t.cn/RYMuvvn",
                                      "http://t.cn/RYVfnEO",
                                      "http://t.cn/RYVf1fd"])
        bannerView.pageControlSize = CGSize(width: 10, height: 10)
        bannerView.pageControlCurrentSize = CGSize(width: 10, height: 10)
        bannerView.pageControlRadius = 5
        bannerView.pageControlCurrentRadius = 5
        bannerView.pageControlAlignment = .center
        bannerView.pageControlIsClickEnable = false
        tableView.tableHeaderView = bannerView
        tableView.tableFooterView = UIView()
    }
}

extension MZBannerViewListVC: UITableViewDelegate, UITableViewDataSource {
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
        let testVC = MZBannerViewVC()
        testVC.type = indexPath.row
        self.navigationController?.pushViewController(testVC, animated: true)
    }
}
