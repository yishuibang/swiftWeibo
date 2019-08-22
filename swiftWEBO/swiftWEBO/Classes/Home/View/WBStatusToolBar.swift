//
//  WBStatusToolBar.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/6/13.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit

class WBStatusToolBar: UIView {
    var viewModel:WBStatusViewModel?{
        didSet{
//            reposts_count.setTitle("\(String(describing: viewModel?.status.reposts_count))", for: [])
//            comments_count.setTitle("\(String(describing: viewModel?.status.comments_count))", for: [])
//            attitudes_count.setTitle("\(String(describing: viewModel?.status.attitudes_count))", for: [])
            reposts_count.setTitle(viewModel?.reposts_countStr, for: [])
            comments_count.setTitle(viewModel?.comments_countStr, for: [])
            attitudes_count.setTitle(viewModel?.attitudes_countstr, for: [])
        }
    }
    /// 转发
    @IBOutlet weak var reposts_count: UIButton!
    /// 评论
    @IBOutlet weak var comments_count: UIButton!
    /// 点赞
    @IBOutlet weak var attitudes_count: UIButton!
   

}
