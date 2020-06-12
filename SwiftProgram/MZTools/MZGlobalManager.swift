//
//  MZGlobalManager.swift
//  SwiftProgram
//
//  Created by Mr.Z on 2020/5/13.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

import Foundation
import UIKit

/// 屏幕尺寸
public let kScreenSize: CGSize = UIScreen.main.bounds.size
/// 屏幕宽度
public let kScreenWidth: CGFloat = UIScreen.main.bounds.size.width
/// 屏幕高度
public let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height
/// 适配比例
public let kRectScale: CGFloat = (kScreenWidth / 375.0)
/// 状态栏高度
public let kStatusBarHeight: CGFloat = getStatusBarHeight()
/// 导航栏高度
public let kNavBarHeight: CGFloat = 44.0
/// 状态栏+导航栏
public let kStatusNavBarHeight: CGFloat = (kStatusBarHeight + kNavBarHeight)
/// 是否iPhoneX系列
public let isIPhoneX: Bool = (kStatusBarHeight == 44.0) ? true : false
/// tabbar高度
public let kTabBarHeight: CGFloat = isIPhoneX ? (49.0 + 34.0) : 49.0
/// 顶部的安全距离
public let kTopSafeAreaHeight = (kStatusBarHeight - 20.0)
/// 底部的安全距离
public let kBottomSafeAreaHeight = (kTabBarHeight - 49.0)

/// 获取状态栏高度
public func getStatusBarHeight() -> CGFloat {
    if #available(iOS 13.0, *) {
        return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
    } else {
        return UIApplication.shared.statusBarFrame.height
    }
}
