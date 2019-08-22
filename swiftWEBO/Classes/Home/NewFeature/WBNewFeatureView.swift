

//
//  WBNewFeatureView.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/6/2.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit

class WBNewFeatureView: UIView {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var newFeaturePageC: UIPageControl!
    
    let viewCount = 4
    
   
    @IBAction func enter(_ sender: UIButton) {
        removeFromSuperview()
    }
    
   class func setupWBNewFeatureView() -> WBNewFeatureView {
        let nib = UINib(nibName: "WBNewFeatureView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: [:])[0] as! WBNewFeatureView
        v.frame = UIScreen.main.bounds
    
        return v
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        enterButton.isHidden = true
//        let viewCount = 4
        let rect = UIScreen.main.bounds
        
        for i in 0 ..< viewCount{
            
            let iv = UIImageView(image: UIImage(named: "new_feature_\(i+1)"))
            //设置大小
            
            iv.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            scrollView.addSubview(iv)
            
            print("vvvvvvvv \(i, scrollView.subviews.count)")
            
        }
        scrollView.backgroundColor = UIColor.clear
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: CGFloat(viewCount + 1) * rect.width, height: rect.height)
        print("vvvvvvvv \( scrollView.subviews.count)")

    
    }
    
}


extension WBNewFeatureView:UIScrollViewDelegate{
    //只要滑动就掉用
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        enterButton.isHidden = true
        
        //计算当前是偏移量
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        
        //分页隐藏
        newFeaturePageC.isHidden = (page == scrollView.subviews.count)
        
        
    }
    
    //滑动结束减速的时候调用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 滚动到最后一屏，让视图删除
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
//        print(page)
//        print(scrollView.subviews)
//        print(scrollView.subviews.count)
        newFeaturePageC.currentPage = page
        //倒数第二页显示按钮
        enterButton.isHidden = (page != viewCount - 1)
        
        //判断是否最后一页
        if page == viewCount {
            self.removeFromSuperview()
        }
        
    }
    
    
    
}
