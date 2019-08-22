//
//  WBNetWorkManger.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/5/8.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit
import AFNetworking  //导入的是文件夹的名字
//swift 支持任何数据类型 
// switch /enum 在OC中只支持整数
enum WBHTTPMethod{
    case GET
    case POST 
}

//网络管理工具
class WBNetWorkManger: AFHTTPSessionManager {
//静态区、常量。 闭包
    //swift 单例
    //在第一次访问时，执行闭包 将闭包保存到shared常量中
    static let share:WBNetWorkManger = {
        //实例化对象
        let instance = WBNetWorkManger()
        //设置相应反应队列
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        //返回对象
        return instance
    }()
    //懒加载 创建用户对象
  lazy var userAccount = WBUserAccount()
    
    //访问令牌 有时限（为了保证用户的安全，时限是三天）
   // var access_token:String?// = "2.00UfNaWFD3q5XDd08a5aec7bp9icYB"
   //计算型属性 记录用户是否的登录
    var userLogin:Bool {
        return userAccount.access_token != nil
    }
    
    
    func tokenRequest(method:WBHTTPMethod = .GET, urlString:String,paramas:[String:AnyObject]?,composition:@escaping (_ json:AnyObject?, _ issuccess:Bool)->()) {
        //处理token 字典
        //>0判断token是否为空 为nil 直接返回
        guard let token = userAccount.access_token else {
            //FIXME:发送通知（本方法不知道被谁调用，谁接收到通知谁处理）
            print("token 过期了")
            //程序执行过程中  token  一般不会为nil
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: "bad token")
            composition(nil,false)
            return
        }
        //1.判断参数字典是否存在 如果为nil 应该创建
        var paramasDic = paramas
        if paramasDic == nil{
            paramasDic = [String:AnyObject]()
        }
        //设置参数字典  此处一定有值
        paramasDic!["access_token"] = token as AnyObject? 
        //使用request 发起网络请求方法
        request(urlString: urlString, parameters: paramasDic, completion: composition)
    }
    func request(method:WBHTTPMethod = .GET, urlString:String,parameters:[String:AnyObject]?, completion:@escaping (_ jsonStr:AnyObject?, _ ISSuccess:Bool)->()) {
        let success = {(task:URLSessionDataTask,json:Any?)->() in
            completion(json as AnyObject,true)
        }
        let failure = {(task:URLSessionDataTask?,error:Error)->()in
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("token 过期了")
                
                //FIXME:发送通知（本方法不知道被谁调用，谁接收到通知谁处理）
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: "bad token")
            }
            print("网络请求错误\(error)")
            completion(nil,false)

        }
        
        if method == .GET {
           get(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
           post(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
    
}
