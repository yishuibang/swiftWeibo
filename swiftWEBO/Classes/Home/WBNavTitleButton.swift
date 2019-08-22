//
//  WBNavTitleButton.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/6/2.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit

class WBNavTitleButton: UIButton {
    
  /// 重载构造函数
  ///
  /// - Parameter title: title == nil  显示首页，否则显示昵称 和 图片
  init(title: String?) {
        super.init(frame: CGRect())
    if title == nil {
        setTitle("首页", for: .normal)
    }else{
 
        setTitle(title!, for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
    }
    //默认 17 粗细
    titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    setTitleColor(UIColor.orange, for: .normal)
    setTitleColor(UIColor.darkGray, for: .selected)
    sizeToFit()
    //调用一次  解决bug
    layoutSubviews()
    
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let titleLab = titleLabel,
              let imageV = imageView
        else {
            return
        }
//        FIXME：有bug  已解决 
        
        titleLab.frame = titleLab.frame.offsetBy(dx: -imageV.bounds.width, dy: 0)
        imageV.frame = imageV.frame.offsetBy(dx: titleLab.bounds.width+5, dy: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
