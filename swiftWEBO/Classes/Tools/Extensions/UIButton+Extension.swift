//
//  UIButton+Extension.swift
//  swiftWEBO
//
//  Created by AVGD on 17/1/14.
//  Copyright © 2017年 JFF. All rights reserved.
//

import Foundation
extension UIButton{
    class func creatButton(backGroundImage:String, normalImage:String, seledImage:String)->UIButton{
        let button = UIButton()
        button.setBackgroundImage(UIImage(named:backGroundImage), for: .normal)
        button.setImage(UIImage(named:normalImage), for: .normal)
        button.setImage(UIImage(named:seledImage), for: .selected)
        button.sizeToFit()
        return button;
        
    }
}
