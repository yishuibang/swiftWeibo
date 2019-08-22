//
//  UIImageView+WebImage.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/6/9.
//  Copyright © 2017年 JFF. All rights reserved.
//

import SDWebImage

extension UIImageView {
    /// 隔离 SDWebImage 设置图像函数
    ///
    /// - parameter urlStr:           urlString
    /// - parameter placeholderImage: 占位图像
    /// - parameter isAvatar:         是否头像（设置圆角）

    func JF_setImage(urlStr:String?,placeHolderImage:UIImage?,isAvatar:Bool=false) {
        
        guard let urlString = urlStr,
        let url = URL(string: urlString)
        else {
            image = placeHolderImage
            return
        }
        //可选项只是用在 Swift，OC 有的时候 用！同样可以传入 nil/ weak self 防止循环引用
        sd_setImage(with: url, placeholderImage: placeHolderImage, options: [], progress: nil) {  [weak self] (image, _, _, _) in
            if isAvatar && image != nil{
                
                self?.image =  image?.JF_avatarImage(size: self?.bounds.size)
            }
        }
        
        
    }
}
