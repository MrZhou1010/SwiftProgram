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
let kScreenSize: CGSize = UIScreen.main.bounds.size
/// 屏幕宽度
let kScreenWidth: CGFloat = UIScreen.main.bounds.size.width
/// 屏幕高度
let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height
/// 适配比例
let kRectScale: CGFloat = (kScreenWidth / 375.0)
/// 状态栏高度
let kStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
/// 导航栏高度
let kNavBarHeight: CGFloat = 44.0
/// 状态栏+导航栏
let kStatusNavBarHeight: CGFloat = (kStatusBarHeight + kNavBarHeight)
/// 是否iPhoneX系列
let isIPhoneX: Bool = (kStatusBarHeight == 44.0) ? true : false
/// tabbar高度
let kTabBarHeight: CGFloat = isIPhoneX ? (49.0 + 34.0) : 49.0
/// 顶部的安全距离
let kTopSafeAreaHeight = (kStatusBarHeight - 20.0)
/// 底部的安全距离
let kBottomSafeAreaHeight = (kTabBarHeight - 49.0)
