//
//  UIBarButtonItem+Extension.swift
//  swiftWEBO
//
//  Created by AVGD on 17/1/14.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //使用自定义视图 重写返回按钮
    convenience init(title:String, fontsize:Float = 16, taget:AnyObject?, action:Selector , isBackbutton:Bool = false) {
        
        /// UIButtonType.DetailDisclosure：前面带“!”图标按钮，默认文字颜色为蓝色，有触摸时的高亮效果
        ///   UIButtonType.System：前面不带图标，默认文字颜色为蓝色，有触摸时的高亮效果
        ///   UIButtonType.Custom：定制按钮，前面不带图标，默认文字颜色为白色，无触摸时的高亮效果
        /// UIButtonType.ContactAdd：前面带“+”图标按钮，默认文字颜色为蓝色，有触摸时的高亮效果
        let button = UIButton(type: .custom)
        if isBackbutton {
            let imageName = "hotweibo_back_icon"
            
            button.setImage( UIImage(named: imageName), for: .normal)
            button.setImage( UIImage(named: imageName+"_highlighted"), for: .highlighted)
        }

        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.setTitleColor(UIColor.orange, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(fontsize))
                button.addTarget(taget, action: action, for: .touchUpInside)
        button.sizeToFit()
        //self.init 实例化UIBarButtonItem
        self.init(customView:button)
        
        
    }
}
