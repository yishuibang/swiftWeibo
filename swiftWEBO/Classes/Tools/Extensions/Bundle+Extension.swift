//
//  Bundle+Extension.swift
//  swift-WeBo
//
//  Created by AVGD on 17/1/14.
//  Copyright © 2017年 JFF. All rights reserved.
//

import Foundation

extension Bundle{
    //计算行 属性没有参数有返回值
    var namespace:String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
}
