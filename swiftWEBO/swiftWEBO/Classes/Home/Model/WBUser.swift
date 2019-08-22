//
//  WBUser.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/6/5.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit
//微博用户模型
class WBUser: NSObject {
    //基本数据类型 private 不能使用KVC设置
    var id:Int64 = 0
//    用户昵称
    var screen_name:String?
//  头像中图
    var profile_image_url:String?
//    微博认证类型 1.没有认证  0. 认证用户 2，3，4 企业认证 220 认证达人
    var verified_type:Int = 0
    
    var source:String?
    
//    会员等级 0-6
    var mbrank:Int = 0
    
    override var description: String{
        return yy_modelDescription()
    }
    
}
