//
//  WBCommonContext.swift
//  
//
//  Created by 姬方方 on 2017/5/26.
//
//

import Foundation


/// 应用程序信息
//应用程序 ID
let WBAppKey = "3241938711"
//应用程序加密信息 （开发者可以申请修改）
let WBAppSecret = "26a13333b19c30513d8ca4e3419fbfba"

//回调地址 - 登录完成回调的URL 参数以 get 方式拼接参数
let WBRedirectURL = "http://baidu.com"
//MARK  :********* 全局通知定义
//用户需要登录通知
let WBUserShouldLoginNotification = "WBUserShouldLoginNotification"
//用户登录成功通知 
let WBUserLoginSuccessNotification = "WBUserLoginSuccessNotification"


let WBUserShouldRegisterNotification = "WBUserShouldRegisterNotification"

//    配图视图常数准备
let pictureOutterMargin:CGFloat = 12
let pictureInMargin:CGFloat = 3
let pictureWidth = UIScreen.yw_screenWidth() - 2 * pictureOutterMargin
let smallImageWidth = (pictureWidth - 2*pictureInMargin)/3.0
