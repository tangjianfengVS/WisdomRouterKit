//
//  WisdomRouterParam.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/14.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

enum WisdomRouterParamType {
    
    case dic
}

class WisdomRouterParam: NSObject {
    private(set) var valueClass: AnyClass = NSObject.self
    private(set) var value: Any?
    private(set) var valueTargetKey: String=""
    private(set) var keyValue: [String:Any] = [:]

    /** Param: List set */
    class func creat(param: [Any], key: String) -> WisdomRouterParam{
        return WisdomRouterParam()
    }
    
    /** Param: String */
    class func creat(param: String, key: String) -> WisdomRouterParam{
        let obj = WisdomRouterParam()
        obj.value = param
        obj.valueTargetKey = key
        return obj
    }
    
    /** Param: Model
        1: Model 类型匹配 ---> 直接赋值
        2: Model 类型不匹配 ---> 对同名属性赋值
     */
    class func creat(param: WisdomRouterModel, key: String) -> WisdomRouterParam{
        let obj = WisdomRouterParam()
        obj.value = param
        obj.valueTargetKey = key
        obj.valueClass = WisdomRouterModel.self
        
        let propertyList = WisdomRouterKit.propertyList(targetClass: param.classForCoder as! WisdomRouterModel.Type)
        for key in propertyList {
            let value = param.value(forKey: key)
            if value != nil{
                obj.keyValue[key] = value
            }
        }
        return obj
    }
}
