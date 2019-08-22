
//
//  WBWelcomView.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/6/2.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit
import SDWebImage

class WBWelcomView: UIView {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var bottomSpace: NSLayoutConstraint!
    /// 欢迎视图
    ///
    /// - Returns: <#return value description#>
  
   class func setupWBWelcomView() -> WBWelcomView {
        
        let nib = UINib(nibName: "WBWelcomView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nib, options: nil)[0] as! WBWelcomView
        //从xib 加载视图 默认是 600*600
        v.frame = UIScreen.main.bounds
        
        return v
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //纯代码入口
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //xib 入口
        //提示 initWithCoder 只是刚刚从xib 二进制视图数据加载完毕
        //还没有和代码建立联系 所以开发时千万不要在这个方法建立UI
       // fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        //url 
        guard let urlStr = WBNetWorkManger.share.userAccount.profile_image_url,
              let url = NSURL(string: urlStr) as URL?
            else{
               return
        }
        
        //设置头像
        iconView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        iconView.layer.cornerRadius = iconView.bounds.width / 2.0
        iconView.clipsToBounds = true
        let userName = WBNetWorkManger.share.userAccount.screen_name ?? ""
        tipLabel.text = userName + "欢迎归来"
        
    }
    /// 视图已经显示 将动画写到此处
    
    override func didMoveToWindow() {
        //视图是用自动布局设置的 只是设置了约束
        //当时图被添加到父视图上 根据父视图的大小 计算子视图的frame
        //如果frame 没有计算好 所有的约束一起动画
    
       super.didMoveToWindow()
        self.layoutIfNeeded()
        bottomSpace.constant = bounds.size.height - 200
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: { 
            //更新约束
            self.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.tipLabel.alpha = 1
            }, completion: { (_) in
                self.removeFromSuperview()
            })
        }
        
    }
    


}
