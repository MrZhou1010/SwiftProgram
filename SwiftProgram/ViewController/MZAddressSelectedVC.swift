//
//  MZAddressSelectedVC.swift
//  SwiftProgram
//
//  Created by 木木 on 2020/5/13.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

import UIKit

class MZAddressSelectedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "地址选择器"
        let addressBtn = UIButton(type: .custom)
        addressBtn.frame = CGRect(x: 16, y: 200, width: UIScreen.main.bounds.size.width - 32, height: 50)
        addressBtn.backgroundColor = UIColor.orange
        addressBtn.layer.cornerRadius = 5.0
        addressBtn.setTitle("选择地址", for: .normal)
        addressBtn.setTitleColor(UIColor.black, for: .normal)
        addressBtn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        self.view.addSubview(addressBtn)
    }
    
    @objc private func btnClick(btn: UIButton) {
        let addressSelectedView = MZAddressSelectedView(frame: self.view.bounds)
        addressSelectedView.title = "选择地址"
        addressSelectedView.isGradientLine = true
        addressSelectedView.setupAllTitle(index: 0)
        addressSelectedView.callBackBlock = { (modelArr) in
            var value = ""
            for model in modelArr {
                value = value + model.name! + " "
            }
            value = value.trimmingCharacters(in: .whitespaces)
            btn.setTitle(value, for: .normal)
        }
        addressSelectedView.show()
    }
}