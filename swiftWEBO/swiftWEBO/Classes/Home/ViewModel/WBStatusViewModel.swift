//
//  WBStatusViewModel.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/6/6.
//  Copyright © 2017年 JFF. All rights reserved.
//

import Foundation
// 单条微博的视图模型
class WBStatusViewModel:CustomStringConvertible {
    var status:WBStatus
    
    /// 构造函数
    ///
    /// - Parameter model: 微博模型 
//    如果没有任何父类  需要在开发时输出测试信息 需要
//    需要遵守CustomStringConvertible
//    需要实现description属性
//    存储型属性 （用内存换cpu）
    
    var mbImage:UIImage?
    //    微博认证类型 1.没有认证  0. 认证用户 2，3，4 企业认证 220 认证达人

    var VIPIcon:UIImage?
    
    var reposts_countStr:String?
    var comments_countStr:String?
    var attitudes_countstr:String?
    
    var pictureViewSize = CGSize()
//    被转发微博的文字
    
    var retweedText:String?
//    如果是被转发微博，原创微博一定没有图
    
    var picUrls:[WBStatusPicture]? {
//        如果是被转发微博，返回被转发微博的数据
//        如果是原创微博，返回原创微博的配图
//        如果都没有返回nil
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
    //retun 单条微博视图模型
    init(model:WBStatus) {
        self.status = model
        //直接计算出等级 0 - 6
//        print("mbRank \(model.user?.mbrank)")
        if (model.user?.mbrank)! > 0 && (model.user?.mbrank)! < 7 {
            mbImage = UIImage(named: "common_icon_membership_level\(String(describing: model.user?.mbrank ?? 1))")
//    、、print(mbImage)
        }else{
            mbImage = UIImage(named: "common_icon_membership_expired")
        }
        //    微博认证类型 -1.没有认证  0. 认证用户 2，3，4 企业认证 220 认证达人
        switch model.user?.verified_type ?? -1 {
        case -1:
            VIPIcon = UIImage(named: "avatar_vip")
        case 2,3,5:
        VIPIcon = UIImage(named: "avatar_vip")
        case 220:
            VIPIcon = UIImage(named: "avatar_vip")

    default:
            break
        }
        reposts_countStr = countStr(count: model.reposts_count, defaultStr: "转发")
        comments_countStr = countStr(count: model.reposts_count, defaultStr: "评论")
        attitudes_countstr = countStr(count: model.reposts_count, defaultStr: "赞")
        
//        计算配图是图大小， 如果是被转发的就计算被转发的， 如果是原创的就计算原创的
        pictureViewSize = calcPictureSize(count: picUrls?.count ?? 0)
//        设置被转发微博的文字
        
//        retweedText = "@"+(status.retweeted_status?.user?.screen_name ?? "") + ":" + (status.retweeted_status?.text ?? "")
        retweedText = "@\(status.retweeted_status?.user?.screen_name ?? "")+: :\(status.retweeted_status?.text ?? "")"
       
        
    }
    var description: String {
        return status.description
    }
    
  /// 计算配图视图的大小
  ///
  /// - Parameter count: 图片个数
  /// - Returns: 配图视图的大小
  private func calcPictureSize(count:Int) -> CGSize {
    if count == 0 {
        return CGSize()
    }
//    1.计算配图视图的宽度

    
//    3 计算高度
//    count 计算行数1--9
    /**
     123 = 0 1 2 = 0 + 1 = 1
     456 = 345 = 1 + 1 = 2
     789 = 456 = 2+1 = 3
     
    */
   
    let row = CGFloat((count - 1)/3 + 1)
    let height = pictureOutterMargin + row * smallImageWidth + (row - 1)*pictureInMargin
    
        return CGSize(width: pictureWidth, height: height)
    }
    
    /// 处理底部工具栏的显示
    ///
    /// - Parameters:
    ///   - count: 数量
    ///   - defaultStr: 默认显示文本 评论／转发／赞
    /// - Returns: 显示文本
    func countStr(count:Int,defaultStr:String) -> String {
        if count == 0 {
            return defaultStr
        }
        if count < 10000 {
            return count.description
        }
        return String(format: "%.02f 万",Double(count)/10000)
    }
    
    
   
}
