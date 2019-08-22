//
//  WBUserAccount.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/5/31.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit

fileprivate let filePath:NSString = "userAccount.json"
class WBUserAccount: NSObject {
///访问令牌
    var access_token:String?
    //用户代码 uuId
    var uid:String?
    //accessToken 的过期日期 单位是秒 
    //开发者 5年 
    //使用者 3天
    var expires_in:TimeInterval = 0.0{
        didSet{
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    
    var screen_name : String?
    var profile_image_url :String?
    var avatar_large:String?
    
    override init() {
        super.init()
        //从磁盘加载保存的userAccount
        //1>从磁盘加载文件到二进制数据 如果没有直接返回
      guard let path = filePath.yw_appendDocumentDir(),
        let data = NSData(contentsOfFile: path),
        let dic = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String:AnyObject]
        else{
            return
        }
        
        //使用字典设置属性值
//        判断用户登录关键
        yy_modelSet(with: dic ?? [:])
        //判断token  是否过期
        //账户过期测试
        //expires_date = Date(timeIntervalSinceNow: -3600*24)
      if  expires_date?.compare(Date()) != .orderedDescending
      {
        print("账户过期  ")
        //清空token  和  uid
       access_token = nil
        uid = nil
        //删除账户文件
       _ = try? FileManager.default.removeItem(atPath: path)
        
     }
        print("账户正常 \(self)")
    }
    
    //token 过期日期的处理  以及开发者和使用者 的区别
    var expires_date:Date?
    override var description: String{
        return yy_modelDescription()
    }
    
    /**
        1.偏好设置（小）- xcode8 beta 无效！
        2.沙盒 - 归档/plist/json
        3.数据库（FMDB/coreData）
        4.钥匙串访问（小/自动加密 - 需要使用框架 SSKeyChain）
    */
    func saveAccount() {
        //1.模型转字典
        var dic = self.yy_modelToJSONObject() as? [String:AnyObject] ?? [:]
        //删除expires_in
        dic.removeValue(forKey: "expires_in")
        //2.字典转data         //3.写入磁盘文档目录

     guard let data = try? JSONSerialization.data(withJSONObject: dic, options: []),
        let filepath = (filePath as NSString).yw_appendDocumentDir() else{
             return
        }
        (data as NSData).write(toFile: filepath, atomically: true)
        print("useraccount保存路径 \(filepath))")
    }
}
