//
//  WisdomRouterModel.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/14.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

@objcMembers public class WisdomRouterModel: NSObject {
    required override init() {
        
    }
    
    override public func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override public func setValue(_ value: Any?, forKey key: String) {
        if value != nil {
            super.setValue(value, forKey: key)
        }
    }
}

class WisdomRouterModelList: NSObject {
    
}
