//
//  WBStatusCell.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/6/5.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit

class WBStatusCell: UITableViewCell {
    var viewModel:WBStatusViewModel? {
        didSet{
            memberIcon.image = viewModel?.mbImage
            screenName.text = viewModel?.status.user?.screen_name
            contentLabel.text = viewModel?.status.text
            source.text = viewModel?.status.user?.source
            vipIcon.image = viewModel?.VIPIcon
            iconView.JF_setImage(urlStr: viewModel?.status.user?.profile_image_url, placeHolderImage: UIImage(named: "paceholder"),isAvatar: true)
            toolBar.viewModel = viewModel
            pictureHeightCons.constant = viewModel?.pictureViewSize.height ?? 0
            
//            配置视图的URL数据
////            测试四张图
//            if (viewModel?.status.pic_urls?.count)! > 4 {
//                //修改数组 将末尾的数据全部删除
//                var picUrls = viewModel?.status.pic_urls!
//                picUrls?.removeSubrange(((picUrls?.startIndex)! + 4)..<(picUrls?.endIndex)!)
//                pictureView.urls = picUrls
//
//            }else{
//            pictureView.urls = viewModel?.status.pic_urls
//            }
//             设置配图 （）原创和被转发
                pictureView.urls = viewModel?.picUrls
             oraginalL?.text = viewModel?.retweedText
        }
    }
    //头像视图
    @IBOutlet weak var iconView: UIImageView!
    //昵称
    @IBOutlet weak var screenName: UILabel!
    //会员认证
    @IBOutlet weak var memberIcon: UIImageView!
    //时间
    @IBOutlet weak var timeLabel: UILabel!
    //来源
    @IBOutlet weak var source: UILabel!
    //vip认证
    @IBOutlet weak var vipIcon: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var oraginalL: UILabel?
    @IBOutlet weak var toolBar: WBStatusToolBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//配图试图
    @IBOutlet weak var pictureView: WBStatusPictureView!
//    高度约束
    @IBOutlet weak var pictureHeightCons: NSLayoutConstraint!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
