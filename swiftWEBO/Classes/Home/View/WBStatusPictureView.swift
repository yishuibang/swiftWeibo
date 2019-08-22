//
//  WBStatusPictureView.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/6/13.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {
    var urls:[WBStatusPicture]?
    {
        didSet{
//           便利隐藏图像
            for v in subviews{
                v.isHidden = true
            }
            var index = 0
            for url in urls ?? []{
                let iv = subviews[index] as! UIImageView
                //4
                if index == 1 && urls?.count == 4 {
                    index += 1
                }
                
               iv.JF_setImage(urlStr: url.thumbnail_pic, placeHolderImage: UIImage(named: "paceholder"))
                
                iv.isHidden = false
                
                index += 1
            }
        }
    }
    
    
    override func awakeFromNib() {
        setupUI()
    }

}


extension WBStatusPictureView{
    
    /// 九宫格布局
    func setupUI() {
//    
        clipsToBounds = true
        backgroundColor = superview?.backgroundColor
        let rect = CGRect(x: 0,
                          y: pictureOutterMargin,
                          width: smallImageWidth,
                          height: smallImageWidth)
        let count = 3
        
        for i in 0..<count * count {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
            //行 Y
            let row = CGFloat(i / count)
            //列 Y
            let col = CGFloat(i % count)
//            
           let offX = col * (smallImageWidth + pictureInMargin)
           let offY = row  * (smallImageWidth + pictureInMargin)
           iv.frame = rect.offsetBy(dx: offX, dy: offY)
            addSubview(iv)
            
        }
        
    }
}
