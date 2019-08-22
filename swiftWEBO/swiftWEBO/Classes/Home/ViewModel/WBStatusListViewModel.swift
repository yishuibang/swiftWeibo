//
//  WBStatusListViewModel.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/5/10.
//  Copyright © 2017年 JFF. All rights reserved.
//

import Foundation

//微博数据列表 数据模型
//父类的选择 
/*
 如果需要使用‘KVC’ 或者字典转模型的框架设置对象值，类就需要父类
 - 如果类只是包装一些代码逻辑 （写了一些函数），就可以不用任何父类 好处：更加轻量级
 
 - 提示 如果是用OC写 一律继承自NSObject 即可
 */

/*
 负责微博数据的处理
 1.字典转模型
 2.下拉/上啦刷新数据的处理
 */
//上啦刷新最大尝试次数
fileprivate let maxPullUpTimes = 3

class WBStatusListViewModel {
    lazy var statusList = [WBStatusViewModel]()
    //上啦刷新错误次数
    private var pullUpErrorTimes = 0
    // since_id 上啦刷新 取出数组中第一条微博的id
    // max_id 下拉刷新 取出数组中最后一条微博的 id
    // compsition 完成回调 是否有更多的上啦刷新
    func loadStatus(pullUp:Bool,compsition:@escaping (_ isSuccess:Bool, _ hasMorePullup:Bool)->()) {
        //判断是否是上啦刷新  同时检查上啦刷新
        if pullUpErrorTimes > maxPullUpTimes {
            compsition(true,false)
            return
        }
        //取出数组的第一条元素 下拉
        let since_id = pullUp ? 0: (statusList.first?.status.id ?? 0)
        //取出数组的最后一条元素 上啦
        let max_id = !pullUp ? 0 :(statusList.last?.status.id ?? 0)
        WBNetWorkManger.share.stausList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            if !isSuccess{
                compsition(false, false)
                return
            }
            //1.字典转模型
            var array = [WBStatusViewModel]()
            
            //遍历服务器返回字典数组，字典转模型
           // print(list)
            for dic in list ?? [] {
                
//                //创建微博模型 - 创建失败 继续遍历
//                guard let model = WBStatus.yy_model(with: dic) else{
//                    continue
//                }
//                //将视图模型添加到数组
//                array.append(WBStatusViewModel(model: model))
                //  调用构造函数  创建 对象肯定存在
                let  status = WBStatus()
                // 设置字典模型
                status.yy_modelSet(with: dic)
                
                //使用微博模型 创建微博视图模型
                let  statusViewModel = WBStatusViewModel(model: status)
                
                array.append(statusViewModel)
                
            }
//            //字典转模型
//            guard  let array = NSMutableArray.yy_modelArray(with: WBStatusViewModel.self, json: list ?? []) as? [WBStatusViewModel]
//                else{
//                    compsition(isSuccess,false)
//                    return
//            }
            if pullUp{//上啦
                self.statusList += array
            }else{//下拉
                
                self.statusList = array + self.statusList
            
            }
            //判断上啦刷新的数据量
            if pullUp && array.count == 0{
                self.pullUpErrorTimes += 1
                //没有上啦刷新
                compsition(isSuccess,false)
            }else{
                //完成回调
                self.cashSignolImage(list: self.statusList)
                compsition(isSuccess,true)
            }
            print("vvvvvvvvvvvvvvvvrrrrrr \(list!)")
            print("ccccccccccccccc \(self.statusList)")
        }
   
    }
    
//    准备缓存单张图片
    func cashSignolImage(list:[WBStatusViewModel])  {
//        便利数组，有单张图片的缓存
        for vm in list {
            if vm.picUrls?.count != 1 {
                continue
            }
            // =1 代码执行到此，数组中有且只有一张图片
            let pic = vm.picUrls!
            
            
            
        }
        
        
    }
    
}
