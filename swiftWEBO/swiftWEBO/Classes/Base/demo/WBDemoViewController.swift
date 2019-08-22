//
//  WBDemoViewController.swift
//  swiftWEBO
//
//  Created by AVGD on 17/1/14.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit

class WBDemoViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    func showNext() {
        let vc = WBDemoViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
extension WBDemoViewController
{
    override func setupTableview() {
      super.setupTableview()
        //无法高亮
        navinItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", taget: self, action: #selector(showNext))
     
    }
}
