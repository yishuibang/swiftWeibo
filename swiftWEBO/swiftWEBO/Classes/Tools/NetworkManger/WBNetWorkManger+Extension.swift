//
//  WBNetWorkManger+Extension.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/5/9.
//  Copyright © 2017年 JFF. All rights reserved.
//

import Foundation
//Mark: - 封装新浪微博的网络请求方法
extension WBNetWorkManger{
    //加载微博字典数组
    //since_id 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    //max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    //composition 完成回调
    func stausList(since_id:Int64,max_id:Int64,composition: @escaping (_ list:[[String:AnyObject]]?, _ ISsuccess:Bool)->()) {
        //swift 中Int 可以转为anyobject int64不行  可以将其转化长字符串 放入字典
        let parmas = ["max_id":"\(max_id > 0 ? (max_id - 1):0)", "since_id":"\(since_id)"]
        let urlstring = "https://api.weibo.com/2/statuses/home_timeline.json"
        //从json 中获取stastuses 字典数组
        //如果 as? 失败 result = nil
        tokenRequest(urlString: urlstring, paramas:parmas as [String : AnyObject]) { (json, isSuccess) in
            let result = json?["statuses"] as? [[String:AnyObject]]
            //print("jsonjsonjson   \(json)")
//            print("result result \(result)")
            composition(result, isSuccess)
        
        }
    }
    //未读数量
    func requestUnreadCount(composetion:(_ unreadCount:Int)->()) {
        composetion(6)
    }
    
    
}

// MARK: - 用户信息的获取
extension WBNetWorkManger{
    
    /// 获取用户信息

    func loadUserInfo(composetion:@escaping (_ json:[String:AnyObject])->()) {
        guard let uid = self.userAccount.uid else {
            return
        }
        let urlString = "https://api.weibo.com/2/users/show.json"
        let parmas = ["uid":uid] as [String:AnyObject]
        tokenRequest(urlString: urlString, paramas: parmas) { (json, isSuccess) in
            composetion((json as?[String :AnyObject]) ?? [:])
            
    }
        
    }
}
//MARK: ************* auth授权
//网络异步加载  需要神马返回神马 

extension WBNetWorkManger {
    func accessToken(code:String, composetion:@escaping (_ isSuccess:Bool)->()) {
        //加载accessToken
        let urlStr = "https://api.weibo.com/oauth2/access_token"
        let params = ["client_id":WBAppKey,"client_secret":WBAppSecret,"grant_type":"authorization_code","code":code,"redirect_uri":WBRedirectURL]
        //如果失败  不会对用户产生任何影响 
        request(method: .POST,urlString: urlStr, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            print("请求授权    。。。。。。。。 \(String(describing: json))")
            //用字典直接设置 userAccount  属性 用空字典解包  json  是可选的  通过code 获取token
            self.userAccount.yy_modelSet(with: (json as? [String : AnyObject]) ?? [:])
            self.loadUserInfo(composetion: {(dic) in
                //用户信息 加载成功 再回调
                composetion(isSuccess)
                //拿到用户名 和 头像
                self.userAccount.yy_modelSet(with: (dic))
                //保存用户信息
                self.userAccount.saveAccount()
                print(self.userAccount)

            })
            print(self.userAccount)
        }
      
        
    }
   
}
