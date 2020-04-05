//
//  WisdomRouterHandler.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/18.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

public class WisdomRouterHandler: NSObject {
    
    private(set) var value: Any?
    
    private(set) var valueTargetKey: String=""
    
    @objc public class func create(key: String, handler: Any) -> WisdomRouterHandler{
        let obj = WisdomRouterHandler()
        obj.valueTargetKey = key
        obj.value = handler;
        return obj
    }
}
