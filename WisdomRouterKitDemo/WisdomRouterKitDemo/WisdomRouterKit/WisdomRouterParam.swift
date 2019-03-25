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
    
    /** Param: ModelList */
    class func creat(key: String, param: [WisdomRouterModel]) -> WisdomRouterParam{
        let obj = WisdomRouterParam()
        obj.value = param
        obj.valueTargetKey = key
        obj.valueClass = WisdomRouterModelList.self
        let propertyList = WisdomRouterManager.propertyList(targetClass: param.first!.classForCoder as! WisdomRouterModel.Type)
        
        for ject in param {
            var dict: [String:Any] = [:]
            for key in propertyList {
                let value = ject.value(forKey: key)
                if value != nil{
                    dict[key] = value
                }
            }
            obj.keyValue.append(dict)
        }
        return obj
    }
    
    /** Param: Model */
    class func creat(key: String, param: WisdomRouterModel) -> WisdomRouterParam{
        let obj = WisdomRouterParam()
        obj.value = param
        obj.valueTargetKey = key
        obj.valueClass = WisdomRouterModel.self
        let propertyList = WisdomRouterManager.propertyList(targetClass: param.classForCoder as! WisdomRouterModel.Type)
        var dict: [String:Any] = [:]
        
        for key in propertyList {
            let value = param.value(forKey: key)
            if value != nil{
                dict[key] = value
            }
        }
        obj.keyValue.append(dict)
        return obj
    }
    
    /** Param: [String:Any] */
    //class func creat(key: String, param: [String: Any]) -> WisdomRouterParam{
    //    return WisdomRouterParam.creatAny(param: param, key: key)
    //}
    
    /** Param: String */
    class func creat(key: String, param: String) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: param, key: key)
    }

    /** Param: Double */
    class func creat(key: String, param: Double) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: param, key: key)
    }

    /** Param: NSInteger */
    class func creat(key: String, param: NSInteger) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: param, key: key)
    }

    /** Param: Int */
    class func creatInt(key: String, param: Int) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: param, key: key)
    }

    /** Param: CGPoint */
    class func creat(key: String, param: CGPoint) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: param, key: key)
    }

    /** Param: CGSize */
    class func creat(key: String, param: CGSize) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: param, key: key)
    }

    /** Param: CGFloat */
    class func creat(key: String, param: CGFloat) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: param, key: key)
    }

    /** Param: CGRect */
    class func creat(key: String, param: CGRect) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: param, key: key)
    }

    /** Param: Data */
    class func creat(key: String, param: Data) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: param, key: key)
    }
    
    /** Param: URL */
    class func creat(key: String, param: URL) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: param, key: key)
    }
 
    private class func creatAny(param: Any, key: String) -> WisdomRouterParam {
        let obj = WisdomRouterParam()
        obj.value = param
        obj.valueTargetKey = key
        return obj
    }
}
