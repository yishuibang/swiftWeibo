//
//  WBVisitorView.swift
//  swiftWEBO
//
//  Created by 姬方方 on 2017/5/4.
//  Copyright © 2017年 JFF. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {
    //MARK  *************** 设置访客信息的视图
    //使用字典设置访客信息
    //Dic imageName Message 如果是首页 imageName = ""
    var visitorInfo: [String:String]? {
       
        didSet{
            guard let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"]
                else {
                    return
            }
            tipLabel.textAlignment = .center
            //设置消息
            tipLabel.text = message
            //设置图像 首页不需要设置
            if imageName == ""{
                startAnimation()
                return
            }
            iconView.image = UIImage(named: imageName)
            //将小房子 和 遮罩图 隐藏
            hourseIcon.isHidden = true
            maskIconView.isHidden = true
        }
    }
    private func startAnimation(){
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * Double.pi;
        animation.duration = 25
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        iconView.layer.add(animation, forKey: nil)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    //MARK ************* 私有控件
    //MARK ************* 遮罩层
   fileprivate lazy var maskIconView:UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    //图像视图
   fileprivate lazy var iconView:UIImageView = UIImageView(image: UIImage(named:"visitordiscover_feed_image_smallicon"))
    //添加房子视图
    fileprivate lazy var hourseIcon:UIImageView = UIImageView(image: UIImage(named:"visitordiscover_feed_image_house"))
    //提示视图
   fileprivate lazy var tipLabel:UILabel = UILabel.yw_label(withText: "关注一些人，关注一些事，你会发现世界那么大！！！！！", fontSize: 14, color: UIColor.darkGray)
    //注册按钮
    lazy var registBtn:UIButton = UIButton.yw_textButton("注册", fontSize: 14, normalColor: UIColor.orange, highlightedColor: UIColor.lightGray, backgroundImageName: "common_button_white_disable")
    //登录按钮
    lazy var logonBtn:UIButton = UIButton.yw_textButton("登录", fontSize: 14, normalColor: UIColor.orange, highlightedColor: UIColor.lightGray, backgroundImageName: "common_button_white_disable")
    
}
extension WBVisitorView{
    func setupUI() {
        backgroundColor = UIColor.yw_color(withHex: 0xEDEDED)
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(hourseIcon)
        addSubview(tipLabel)
        addSubview(registBtn)
        addSubview(logonBtn)
        addConstraintsForViews()
       
    }
    
    func addConstraintsForViews() {
        //2.取消autoresizeing 与autolayout 不能共存
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        //自动布局
        //图像视图
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -60))
        
        //>小房子
        addConstraint(NSLayoutConstraint(item: hourseIcon, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: hourseIcon, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        //tipLabel
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant:236))
        
        //regis
        addConstraint(NSLayoutConstraint(item: registBtn, attribute: .top, relatedBy: .equal, toItem: tipLabel, attribute: .bottom, multiplier: 1.0, constant: 40))
        addConstraint(NSLayoutConstraint(item: registBtn, attribute: .left, relatedBy: .equal, toItem: tipLabel, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant:100))
        
        //logon
        addConstraint(NSLayoutConstraint(item: logonBtn, attribute: .top, relatedBy: .equal, toItem: registBtn, attribute: .top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: logonBtn, attribute: .right, relatedBy: .equal, toItem: tipLabel, attribute: .right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: logonBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant:100))
        //使用VFL 布局
        /*
         V:表示纵向
         H:表示横向
         |表示父视图边缘
         -表示距离
         >=表示视图间距、宽度或高度必须大于或等于某个值
         <=表示视图间距、宽度或高度必须小宇或等于某个值
         ==表示视图间距、宽度或高度必须等于某个值
         @表示>=、<=、==限制，最大为1000
         */
        //views : 定义 VFL 中的控件名称和实际名称的映射关系
        //metrics ：定义 VFL 中 （）制定常熟映射关系
        let viewDict = ["maskIconView":maskIconView, "registBtn":registBtn] as [String : Any]
        let metrics = ["spacing":20]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[maskIconView]-0-|", options: [], metrics: metrics, views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[maskIconView]-(spacing)-[registBtn]", options: [], metrics: metrics, views: viewDict))
        
    }
    
}
