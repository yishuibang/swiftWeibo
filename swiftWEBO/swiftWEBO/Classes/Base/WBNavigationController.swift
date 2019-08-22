//
//  WBNavigationController.swift
//  swift-WeBo
//
//  Created by AVGD on 17/1/14.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit

class WBNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //隐藏默认的bar
        navigationBar.isHidden = true
    }
    //重写push 方法 viewController 是被push的 controller    设置左侧按钮作为返回按钮
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //如果不是站底部的控制器  才需要隐藏 跟控制器不需要处理
        if childViewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true
            if let VC = viewController as? WBBaseViewController{
                //
                var title = "返回"
                if childViewControllers.count == 1 {
                    title = childViewControllers.first?.title ?? "返回"
                }
                VC.navinItem.leftBarButtonItem = UIBarButtonItem(title: title, taget: self, action: #selector(popToBack) ,isBackbutton:true)
            }
        }
                super.pushViewController(viewController, animated: true)
        
    }
    func popToBack() {
        popViewController(animated: true)
    }

}
