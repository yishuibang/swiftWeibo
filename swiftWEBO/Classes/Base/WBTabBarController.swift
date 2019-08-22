//
//  WBTabBarController.swift
//  swift-WeBo
//
//  Created by AVGD on 17/1/14.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit
import SVProgressHUD
//主控制器
class WBTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        //设置代理
        setUpChildControlleres()
        setupComposeButton()
        setupNewFeatures()
        setupTimer()
        NotificationCenter.default.addObserver(self, selector: #selector(loginAction), name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
    }
    deinit {
        //销毁定时器
        timer?.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
//撰写按钮监听方法
    //private 私有
    //@objc 允许这个函数在运行时 通过 OC 的消息访问  @objc private
 func composeBttonClick() {
       print("撰写按钮")
    }
//MARK：********** 私有控件
 fileprivate lazy var composeButton : UIButton = UIButton.creatButton(backGroundImage: "tabbar_compose_button", normalImage: "tabbar_compose_background_icon_add", seledImage: "tabbar_compose_icon_add_highlighted")
   
}
//定时器
fileprivate var timer:Timer?

//extension 类似于OC中的分类 在swift中还可以来切分代码块
//可以把相近功能的函数 写到一个extension中
//便于代码维护
//注意  和OC中分类一样不能定义属性

// 在tabBar 里面设置未读数量的的属性

//MARK ***************** 设置界面
extension WBTabBarController{
    //用户通知 登录事件
    func loginAction(n:Notification) {
        //展现登录控制器
        var when = DispatchTime.now()
        if n.object != nil {
            // 有值 token 过期
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.showInfo(withStatus: "登录过期，请重新登录")
            when = DispatchTime.now() + 2
        }
        DispatchQueue.main.asyncAfter(deadline:when) {
            SVProgressHUD.setDefaultMaskType(.clear)
            let VC = UINavigationController(rootViewController: WBAuthViewController())
            self.present(VC, animated: true, completion: nil)
        }
        
    }
    //设置撰写按钮
    func setupComposeButton() {
        tabBar.addSubview(composeButton)
        //计算按钮的宽度
        let count = CGFloat(childViewControllers.count)
        //处理容错点
        let width = tabBar.bounds.width/count
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * width, dy: 0)
        composeButton.addTarget(self, action: #selector(composeBttonClick), for: .touchUpInside)
        
    }

    //设置所有子控制器
     func setUpChildControlleres(){
       //获取沙盒json 路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]//s省去解包步骤
        let jsonpath = (docDir as NSString).appendingPathComponent("main.json")
        var data = NSData(contentsOfFile: jsonpath)
        
       // print(data)
        //加载data 判断是否有内容 如果没有 加载本地的 json 
        if data == nil {
            //从bundle 加载data
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            data = NSData(contentsOfFile: path!)
        
        }
        
        //data  会有一个内容 反序列化 转化成数组
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as! [[String:AnyObject]]
            else {
                
            return
        }
        
        print(array)
        
        ///从bundle里加载配置的json
        //1，路径
        // let Path = Bundle.main.path(forResource: "main.json", ofType: nil)
        // print(Path)
        // print(NSData(contentsOfFile: Path!))
        /*
        guard let jsonPath = Bundle.main.path(forResource: "main.json", ofType: nil),
              let data = NSData(contentsOfFile: jsonPath),
              let array = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [[String:AnyObject]]
        else {
            
            return
        }
        */
        
      //print(array)
        /*
        let array = [
            ["clsName":"WBHomeViewController", "title":"首页","imageName":"tabbar_home", "visitorInfo":["imageName":"", "message":"关注一些人，回到这里看看有什么惊喜"]],
             ["clsName":"WBMessageViewController", "title":"消息","imageName":"tabbar_message_center", "visitorInfo":["imageName":"visitordiscover_image_message", "message":"登录后，评论别人的微博，别人给你发消息会在这里收到通知"]],
             ["clsName":"UIViewController"],
             
             ["clsName":"WBDiscoverController", "title":"发现","imageName":"tabbar_discover","visitorInfo":["imageName":"visitordiscover_image_profile", "message":"hhaha"]],
             ["clsName":"WBMineViewController", "title":"我","imageName":"tabbar_profile","visitorInfo":["imageName":"visitordiscover_image_profile", "message":"登陆后你的微博会显示在这里，展示给别人"]],
        ]
 */
        //测试数据结构是否正确 
        
     //   let filePath:String = NSHomeDirectory() + "/Documents/tf.json"

    //    (array as NSArray).write(toFile: filePath, atomically: true)
    // let tfArray = NSArray(contentsOfFile:NSHomeDirectory() + "/Documents/WBBase.plist")
        
       // print("sssssssssss    \(filePath)")
        //数组到json 序列化
      //  let data = try!JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
     //    (data as NSData).write(toFile: filePath, atomically: true)
        
        var arrayM = [UIViewController]()
        for dict in array {
          arrayM.append(controller(dict: dict as [String : AnyObject]))
        }
        viewControllers = arrayM
    }
    // 使用字典创建所有的自控制器
    private func controller(dict:[String:AnyObject])->UIViewController{
        //获取字典内容 
        //print(dict["clsName"])
       // print(Bundle.main.namespace+"." + (dict["clsName"]! as! String))
        //print(NSClassFromString(dict["clsName"]! as! String)as? UIViewController.Type)
        guard let clsName = dict["clsName"] as? String,
            let imagename = dict["imageName"] as? String,
            let title = dict["title"] as? String,
            //反射机制 获得类型
        
            let cls = NSClassFromString(Bundle.main.namespace+"." + clsName)as? WBBaseViewController.Type,
            let visitorDict = dict["visitorInfo"] as? [String:String]
            else {
            return UIViewController()
        }
        let vc = cls.init()
        vc.title = title
        vc.visitorInfoDic = visitorDict
        vc.tabBarItem.image = UIImage(named: imagename)
        vc.tabBarItem.selectedImage = UIImage(named: imagename + "_highlighted")?.withRenderingMode(.alwaysOriginal)
        //设置tabBar 标题字体大小
   vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blue], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.red], for: .selected)
        
        //系统默认 是12号字体 设置字体大小是设置normal状态
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 12)], for: .normal);
        let nav = WBNavigationController(rootViewController: vc)
        return nav
        
    }
    
}
//MARK ****************  定时器相关方法
extension WBTabBarController{
    fileprivate func setupTimer(){
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer(){
        if !WBNetWorkManger.share.userLogin {
            return
        }
        WBNetWorkManger.share.requestUnreadCount { (unreadCount) in
            self.tabBar.items?[0].badgeValue = unreadCount > 0 ? "\(unreadCount)": nil
            UIApplication.shared.applicationIconBadgeNumber = unreadCount;
        }
    }
    
}
//MARK ******************** UITabBarControllerDelegate

extension WBTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        //1. 获取控制器在数组中的索引
         let index = (childViewControllers as NSArray).index(of: viewController)
        //2. 获取当前索引为0  并且将要跳转都的是首页 说明重复点击首页
        if selectedIndex == 0 && index == 0 {
            print("重复点击首页")
            // 3 让表格滚动到顶部
            let NaVC = childViewControllers[0] as! UINavigationController
            let VC = NaVC.childViewControllers[0] as! WBHomeViewController
            //滚动到顶部 
            //VC.tableView?.setContentOffset(CGPoint(x:0,y:-64), animated: true)
            VC.tableView?.scrollToRow(at: IndexPath.init(row: 0, section: 0), at:.top, animated: true)
            //延迟一秒加载数据
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                VC.loadData()
            })
            //清楚 首页角标  清楚app  角标
            VC.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        
        //判断是否是UIviewController 的子类 如果不是不加载 解决+号按钮的穿帮问题
        return !viewController.isMember(of: UIViewController.self)
    }
}

//新特性视图处理

extension WBTabBarController{
    func setupNewFeatures() {
        //判断用户是否登录
        if !WBNetWorkManger.share.userLogin {
            return
        }
        
        //检查版本是否更新
        
        //如果更新 显示新特性 
        let v = isNewVersion ? WBNewFeatureView.setupWBNewFeatureView() : WBWelcomView.setupWBWelcomView()
        
        //未更新 显示欢迎界面
        view.addSubview(v)
        
       }
    //计算型属性 不占用存储空间 extension 可以有计算型属性
    //构造函数 给属性分配空间
//
    /// b版本号 知识
    /**在appStore 更新程序每次只能递增 不能递减
     组成 ： 主版本号 次版本号 修订版本号
     主版本号:意味着大的修改 对使用者有较大影响
     次版本号:意味着小的改变 某些函数方法的使用或者参数的变化
     修订版本号:框架程序内部bug 的修正 不会对使用者产生影响
     
      */
    
    private var isNewVersion:Bool{
        //1.取出当前版本号1.0.2
        print(Bundle.main.infoDictionary)
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        print("当前版本号 \(currentVersion)")
        
        //2.取出保存在document（itunes备份）中的版本号 （最理想是保存到用户偏好设置）
        //取出用户偏好中的版本号 
        let JFVersion = UserDefaults.standard.string(forKey: "JFVersion")
        
        /*
        let path:String = ("version" as NSString).yw_appendDocumentDir()
        let sandBoxVersion = (try? String.init(contentsOfFile: path)) ?? ""
        print("沙盒路径 \(path)")
        print("沙盒版本号  \(sandBoxVersion)")
        //3.将当前版本号保存到沙盒1.0.2
        _ = try? currentVersion.write(toFile: path, atomically: true, encoding: .utf8)
        */
        //3.将当前版本号保存到用户偏好
        UserDefaults.standard.set(currentVersion, forKey: "JFVersion")
        print("用户偏好设置的版本号   \(JFVersion)")

        //4.返回两个版本号是否一致 not new 显示欢迎
        
        return currentVersion != JFVersion
        //return currentVersion == JFVersion
    }
}
