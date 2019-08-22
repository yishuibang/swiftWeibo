//
//  WBBaseViewController.swift
//  swift-WeBo
//
//  Created by AVGD on 17/1/14.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit


//面试题 ：OC 中支持多继承吗 如果不支持 如何替代 使用协议替代
//swift 写法更类似于多继承 WBBaseViewController:UITableViewDataSource, UITableViewDelegate
//extension swift中 利用extension 可以吧函数按照功能来分类管理 便于阅读和维护
//注意
//extension 里面不能写属性
//extension 不能重写父类的方法 重写父类的方法是子类的职责 扩展是对类的扩展 父类的方法写在本类里面  子类重写仍然放在本类

class WBBaseViewController: UIViewController {
    //重要的属性写在上面 不重要的属性写在下面
    //
    var visitorInfoDic: [String:String]?
    
    
//    if (@available(iOS 11.0, *)) {
//    CGFloat a =  [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
//    NSLog(@"%f",a);
//    } else {
//    // Fallback on earlier versions
//    }lb
    

    

    
    //自定义导航条
    
    lazy var navigationBar = UINavigationBar(frame: CGRect(x:0,y:self.calNaviTop() > 0 ? 24 : 0,width:UIScreen.main.bounds.width, height:0))
    
    //懒加载创建tableView
    var tableView:UITableView?
    
    //刷新控件
    var refreshControl:UIRefreshControl?
    
    //是否上啦刷新
    var isPull = false
    
    //用户登录标记
    //var isLogonIn = true
    
    //自定义导航条目 - 以后设置导航栏内容  设置 navinItem
    lazy var navinItem = UINavigationItem()

    func calNaviTop() -> Float {
        if #available(iOS 11.0, *) {
            let safeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets
            return Float(safeAreaInsets?.bottom ?? 0)
        } else {
            // Fallback on earlier versions
            return 0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        WBNetWorkManger.share.userLogin ? loadData() : ()
        //登录成功的通知
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: NSNotification.Name(rawValue: WBUserLoginSuccessNotification), object: nil)
    }
    
    //移除观察者
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override var title: String?{
        didSet{
          navinItem.title = title
        }
    }
    
}


extension WBBaseViewController{
    func loadData() {
        //如果子类不实现任何方法 默认关闭刷新
        refreshControl?.endRefreshing()
    }
    
   fileprivate func setupUI(){
        configureNavigationBar()
         WBNetWorkManger.share.userLogin ? setupTableview() : setupVisitorView()
    
    }
    //用户登录后做 设置表格
    func setupTableview()  {
        automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.sc_bottom, left: 0, bottom:44, right: 0)
        tableView?.delegate = self
        tableView?.dataSource = self
        view.insertSubview(tableView!, at: 0)
        //修改指示条缩进  强行解包 是为了拿到一个确定有的insets
        tableView?.scrollIndicatorInsets = tableView!.contentInset
        //实例化控件
        refreshControl = UIRefreshControl()
        //添加监听
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView?.addSubview(refreshControl!)
        
        
    }
    func configureNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.items = [navinItem]
        navigationBar.barTintColor = UIColor.init(colorLiteralRed: 15, green: 246, blue: 246, alpha: 1.0)
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.darkGray]
        //设置系统按钮的文字渲染颜色
        navigationBar.tintColor = UIColor.orange

    }
    func setupVisitorView() {
        //1.添加访问视图
        let vistorView = WBVisitorView(frame: view.bounds)
        vistorView.visitorInfo = visitorInfoDic
        view.insertSubview(vistorView, belowSubview: navigationBar)
        //2.添加监听方法
        vistorView.registBtn.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        vistorView.logonBtn.addTarget(self, action: #selector(logonInAction), for: .touchUpInside)
        //3.设置导航条按钮
        navinItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerAction))
        navinItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(logonInAction))
        
        
    }
    
    
    
}

extension WBBaseViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    //基类只是准备方法 子类负责具体实现  子类发数据源方法不需要super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //只是保证没有语法错误
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //1.判断indexpath是否是最后一行 
        //indexPath.section(最大)/indexPath.row（最后一行）
        let row  = indexPath.row
        let  section = tableView.numberOfSections - 1
        if row < 0 || section < 0 {
            return
        }
        let count = tableView.numberOfRows(inSection: section)
    //如果是最后一行  并且不是下拉刷新
        if row == (count - 1) && !isPull {
            print("上啦刷新")
            isPull = true
            loadData()
        }
        
    }
}
//注册 登录按钮的点击事件
extension WBBaseViewController{
    @objc fileprivate func registerAction(){
        print("注册")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldRegisterNotification), object: nil)

    }
    @objc fileprivate func logonInAction(){
        print("登录")
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
        
    }
}
//登录成功的 方法
extension WBBaseViewController {
    @objc fileprivate func loginSuccess(){
        //重新设置导航栏
        //登录前  左边是 登录  
        navinItem.leftBarButtonItem = nil
        navinItem.rightBarButtonItem = nil

        //登录成功更新UI  显示tableView
        //需要重新设置view 
        //  在调用getter方法时 如果view == nil 会调用loadview ——>viewDidLoad
        view = nil
        //注销通知   避免通知被重复注册 
        //注销通知 ->重新执行viewDidLoad 会再次被注册 避免通知重复注册 会重复通知的（发多次的情况）
        NotificationCenter.default.removeObserver(self)
    }
}

