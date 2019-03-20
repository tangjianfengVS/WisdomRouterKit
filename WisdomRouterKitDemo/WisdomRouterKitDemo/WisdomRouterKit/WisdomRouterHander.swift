//
//  WisdomRouterHander.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/18.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

class WisdomRouterHander: NSObject {
    private(set) var value: Any?
    private(set) var valueTargetKey: String=""
    
    class func creat(key: String, hander: Any) -> WisdomRouterHander{
        let obj = WisdomRouterHander()
        obj.valueTargetKey = key
        obj.value = hander;
        return obj
    }
}

struct WisdomRouterHanderType {
    private(set) var handerValue: ((Any)->(UIViewController))?
    private(set) var handerName: String=""
    
    init(handerName:String, handerValue: @escaping (Any)->(UIViewController)) {
        self.handerName = handerName
        self.handerValue = handerValue
    }
    
    mutating func updateHanderValue(handerValue: @escaping (Any)->(UIViewController)){
        self.handerValue = handerValue
    }
}
