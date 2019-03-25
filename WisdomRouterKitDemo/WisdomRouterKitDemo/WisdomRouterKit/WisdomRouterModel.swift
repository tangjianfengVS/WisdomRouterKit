//
//  WisdomRouterModel.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/14.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

@objcMembers class WisdomRouterModel: NSObject {

    required override init() {
        
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if value != nil {
            super.setValue(value, forKey: key)
        }
    }
}

class WisdomRouterModelList: NSObject {
    
}
