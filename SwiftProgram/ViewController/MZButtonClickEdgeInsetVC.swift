//
//  MZButtonClickEdgeInsetVC.swift
//  SwiftProgram
//
//  Created by Mr.Z on 2020/5/13.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

import UIKit

class MZButtonClickEdgeInsetVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "按钮(扩展点击区域)"
        self.setupUI()
    }
    
    private func setupUI() {
        let view = UIView(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
        view.backgroundColor = UIColor.red
        self.view.addSubview(view)
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 60, y: 60, width: 80, height: 80)
        btn.backgroundColor = UIColor.blue
        btn.addTarget(self, action: #selector(btnClicked(btn:)), for: .touchUpInside)
        // 扩展按钮的点击区域
        btn.mz_clickEdgeInsets = UIEdgeInsets(top: 60, left: 60, bottom: 60, right: 60)
        view.addSubview(btn)
    }
    
    @objc private func btnClicked(btn: UIButton) {
        btn.backgroundColor = UIColor.random()
    }
}
