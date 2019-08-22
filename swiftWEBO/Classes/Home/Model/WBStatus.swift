//
//  WBStatus.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/5/10.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit

class WBStatus: NSObject {
// Int 类型， 在64位的机器是64位，在32位的机器是32位 
    //如果不写 Int64 在ipad 2/iphone5/5c/4s/4无法运行
    var id: Int64 = 0
    //微博信息内容
    var text:String?
    var reposts_count:Int=0
    var comments_count:Int=0
    var attitudes_count:Int=0
//    注意服务器返回的key要一致
    var user:WBUser?
//    被转发的原创微博
    var retweeted_status:WBStatus?
    var pic_urls:[WBStatusPicture]?
    //重写 description 的计算型属性
    override var description: String {
        return yy_modelDescription()
    }
    
    /// 类函数 —》告诉第三方框架yy_MOdel 如果遇到数组类型的属性 数组中存放什么类型的对象
//    NSARRAY 保存的对象通常是‘ID’泪腺
    ///OC中的泛类型是 swift 推出后 苹果为了兼容给 OC 添加的，从运行时的角度看 仍然不知道数组中存放什么类型的对象
    /// - Returns: <#return value description#>
    class func modelContainerPropertyGenericClass() -> [String:AnyClass] {
        return ["pic_urls":WBStatusPicture.self]
    }
}
