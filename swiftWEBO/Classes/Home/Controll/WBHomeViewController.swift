//
//  WBHomeViewController.swift
//  swift-WeBo
//
//  Created by AVGD on 17/1/14.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit
import AFNetworking
private let cellId = "cellId"
private let retweedid = "retweedid"

private var stausList = [String]()
class WBHomeViewController: WBBaseViewController {
    
    //懒加载创建视图模型
    fileprivate lazy var listViewModel = WBStatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
}
    override func loadData() {
        print("开始加载数 %ld  %ld", self.isPull, listViewModel.statusList.count);
        // jia 点注释 
        listViewModel.loadStatus(pullUp: self.isPull) { (isSuccess,shouldRefresh) in
            self.refreshControl?.endRefreshing()
            self.isPull = false
            
            if shouldRefresh{
                print("开始加载数 %ld  %ld", self.isPull, self.listViewModel.statusList.count);
   
            self.tableView?.reloadData()

            }
        }
//        //模拟延时加载
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//            
//            for i in 0...10 {
//                if self.isPull {
//                    stausList.append("上啦\(i)");
// 
//                }else{
//                    stausList.insert(i.description, at: 0);
// 
//                }
//            }
//            self.isPull = false
//            self.refreshControl?.endRefreshing()
//            print("刷新表格")
//            self.tableView?.reloadData()
//    
//        }
     
    }
    func showFriends() {
        let vc = WBDemoViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }

    
}

extension WBHomeViewController{
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print("gfffffffffffffffffffffff \(listViewModel.statusList.count)")
        return listViewModel.statusList.count;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        去除是图模型， 判断加载那种cell
        let datamodel = listViewModel.statusList[indexPath.row]
        let celllid = (datamodel.status.retweeted_status != nil) ? retweedid : cellId
        let cell = tableView.dequeueReusableCell(withIdentifier: celllid, for: indexPath) as! WBStatusCell
        cell.viewModel = datamodel
        return cell
    }
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
  
}
extension WBHomeViewController {
    override func setupTableview() {
        super.setupTableview()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style:.plain, target: self, action: #selector(showFriends))
        navinItem.leftBarButtonItem = UIBarButtonItem(title: "好友", fontsize: 16, taget: self, action: #selector(showFriends))
        tableView?.separatorStyle = .none
        tableView?.register(UINib(nibName: "WBStatusNormalCell", bundle: nil), forCellReuseIdentifier: cellId)
         tableView?.register(UINib(nibName: "WBStatusRetweedCell", bundle: nil), forCellReuseIdentifier: retweedid)
        tableView?.estimatedRowHeight = 100
        //tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupNavTitle()
    
        
    }
    fileprivate func setupNavTitle(){
        let navTitle = WBNetWorkManger.share.userAccount.screen_name
        //指定构造函数 一定会创建
        let btn = WBNavTitleButton(title: navTitle)
        btn.addTarget(self, action: #selector(navTitleClick), for: .touchUpInside)
        navinItem.titleView = btn
    }
    @objc fileprivate func navTitleClick(btn:UIButton){
        btn.isSelected = !btn.isSelected
    }
  
}
