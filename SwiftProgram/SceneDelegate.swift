//
//  SceneDelegate.swift
//  SwiftProgram
//
//  Created by Mr.Z on 2020/5/13.
//  Copyright © 2020 Mr.Z. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.frame = windowScene.coordinateSpace.bounds
        let mainVC = ViewController()
        let nav = UINavigationController(rootViewController: mainVC)
        nav.navigationBar.backgroundColor = UIColor.blue
        
        // 广告
        let adViewController = MZAdViewController(defaultDuration: 3, completion: {
            self.window?.rootViewController = nav
        })
        let url = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589372597330&di=a7d6e2137594a59368c7a919af979ae8&imgtype=0&src=http%3A%2F%2Fimg2.tgbusdata.cn%2Fv2%2Fthumb%2Fjpg%2FZmFlMCwwLDAsNCwzLDEsLTEsMCxyazUw%2Fu%2Folpic.tgbusdata.cn%2Fuploads%2Fallimg%2F130904%2F15-130Z4200F9.gif"
        let adDuartion = 10
        let adViewBottomDistance: CGFloat = 0.0
        adViewController.setAdParams(url: url, adDuration: adDuartion, skipBtnType: .circle, skipBtnPosition: .rightTop, adViewBottomDistance: adViewBottomDistance, transitionType: .filpFromLeft, adImageViewClick: {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.orange
            mainVC.navigationController?.pushViewController(vc, animated: true)
        })
        self.window?.rootViewController = adViewController
        self.window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

