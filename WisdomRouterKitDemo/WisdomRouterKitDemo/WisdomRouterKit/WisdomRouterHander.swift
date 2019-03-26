//
//  WisdomRouterHander.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/18.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

public class WisdomRouterHander: NSObject {
    private(set) var value: Any?
    private(set) var valueTargetKey: String=""
    
    @objc public class func creat(key: String, hander: Any) -> WisdomRouterHander{
        let obj = WisdomRouterHander()
        obj.valueTargetKey = key
        obj.value = hander;
        return obj
    }
}
