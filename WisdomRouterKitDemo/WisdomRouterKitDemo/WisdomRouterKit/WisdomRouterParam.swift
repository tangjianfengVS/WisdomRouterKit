//
//  WisdomRouterParam.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/14.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

class WisdomRouterParam: NSObject {
    private(set) var valueClass: AnyClass = NSObject.self
    private(set) var value: Any?
    private(set) var valueTargetKey: String=""
    private(set) var keyValue: [[String:Any]] = []
    
    /** Param: 模型数组 */
    class func creat(param: [WisdomRouterModel], key: String) -> WisdomRouterParam{
        let obj = WisdomRouterParam()
        obj.value = param
        obj.valueTargetKey = key
        obj.valueClass = WisdomRouterModelList.self
        
        if param.count > 0{
            let propertyList = WisdomRouterKit.propertyList(targetClass: param.first!.classForCoder as! WisdomRouterModel.Type)
            for ject in param {
                var dict: [String:Any] = [:]
                for key in propertyList {
                    let valueNew = ject.value(forKey: key)
                    if valueNew != nil{
                        dict[key] = valueNew
                    }
                }
                obj.keyValue.append(dict)
            }
        }
        return obj
    }
    
    /** Param: Model */
    class func creat(param: WisdomRouterModel, key: String) -> WisdomRouterParam{
        let obj = WisdomRouterParam()
        obj.value = param
        obj.valueTargetKey = key
        obj.valueClass = WisdomRouterModel.self
        let propertyList = WisdomRouterKit.propertyList(targetClass: param.classForCoder as! WisdomRouterModel.Type)
        var dict: [String:Any] = [:]
        
        for key in propertyList {
            let value = param.value(forKey: key)
            if value != nil{
                dict[key] = value
            }
        }
        if dict.count > 0{
            obj.keyValue.append(dict)
        }
        return obj
    }
    
    /** Param: String */
    class func creat(param: String, key: String) -> WisdomRouterParam{
        let obj = WisdomRouterParam()
        obj.value = param
        obj.valueTargetKey = key
        return obj
    }
}
