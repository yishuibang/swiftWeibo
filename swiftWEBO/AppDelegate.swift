//
//  AppDelegate.swift
//  swiftWEBO
//
//  Created by AVGD on 17/1/14.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = WBTabBarController()
        window?.makeKeyAndVisible()
        loadAppInfo()
        setupAddititons()
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
//设置 应用程序其他信息
extension AppDelegate{
  //
   @objc fileprivate func setupAddititons() {
    //设置显示的最小时间
    SVProgressHUD.setMaximumDismissTimeInterval(1)
    //设置网络加载 指示
    AFNetworkActivityIndicatorManager.shared().isEnabled = true
    //通知授权
    if #available(iOS 10.0, *) {//iOS 10 以后的写法
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound,.carPlay]) { (sunccess, error) in
            print("授权" + (sunccess ? "成功" : "失败"))
        }
        
    } else {
        // Fallback on earlier versions
        //iOS 10.0 一下的操作 取得用户授权显示通知 （上方的提示条/声音/badge/）
        let notifySettings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(notifySettings)
    }

    }
}

//从服务器加载应用程序信息 不需要回调 保存在沙盒 等待下一次应用程序启动 使用
extension AppDelegate{
    
    //模拟异步
    func loadAppInfo(){
    //模拟异步 
        DispatchQueue.global().async {
            
            // 1> url
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            //转为data
            let data = NSData(contentsOf: url!)
            //写入磁盘
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]//s省去解包步骤
            let path = (docDir as NSString).appendingPathComponent("main.json")
            data?.write(toFile: path, atomically: true)
            
            print("fffffffffffffFf \(path)")
            
            
        }
        
    }
}

