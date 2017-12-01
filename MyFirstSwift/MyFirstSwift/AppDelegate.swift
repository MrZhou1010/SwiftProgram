//
//  AppDelegate.swift
//  MyFirstSwift
//
//  Created by mobiletek on 2017/11/15.
//  Copyright © 2017年 ZY. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let mainViewController = ViewController()
        let nav = UINavigationController.init(rootViewController: mainViewController)
        
        if launchOptions != nil {
            window?.rootViewController = nav
        } else {
            // 正常点击icon启动页面，加载广告页
            let adViewController = AdViewController.init(defaultDuration: 6, completion: {
                self.window?.rootViewController = nav
            })
            // 延时模拟网络请求
            // 网络超过vc默认显示时间（可设置），不加载图片
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                let url = "http://chatm-icon.oss-cn-beijing.aliyuncs.com/pic/pic_20170724152928869.gif"
                let adDuartion = 10
                let adViewBottomDistance :CGFloat = 0
                adViewController.setAdParams(url: url, adDuration: adDuartion, skipBtnType: .timer, skipBtnPosition: .rightTop, adViewBottomDistance: adViewBottomDistance, transitionType: .filpFromLeft, adImageViewClick: {
                        let vc = UIViewController()
                        vc.view.backgroundColor = UIColor.orange
                        mainViewController.navigationController?.pushViewController(vc, animated: true)
                })
            })
            window?.rootViewController = adViewController
        }
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}
