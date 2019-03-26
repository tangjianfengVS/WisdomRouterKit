//
//  WisdomRouterParam.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/14.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

public class WisdomRouterParam: NSObject {
    private(set) var valueClass: AnyClass = NSObject.self
    private(set) var value: Any?
    private(set) var valueTargetKey: String=""
    private(set) var keyValue: [[String:Any]] = []
    
    /** Param: ModelList */
    @objc public class func creat(key: String, modelList: [WisdomRouterModel]) -> WisdomRouterParam{
        let obj = WisdomRouterParam()
        obj.value = modelList
        obj.valueTargetKey = key
        obj.valueClass = WisdomRouterModelList.self
        let propertyList = WisdomRouterManager.propertyList(targetClass: modelList.first!.classForCoder as! WisdomRouterModel.Type)
        
        for ject in modelList {
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
    @objc public class func creat(key: String, model: WisdomRouterModel) -> WisdomRouterParam{
        let obj = WisdomRouterParam()
        obj.value = model
        obj.valueTargetKey = key
        obj.valueClass = WisdomRouterModel.self
        let propertyList = WisdomRouterManager.propertyList(targetClass: model.classForCoder as! WisdomRouterModel.Type)
        var dict: [String:Any] = [:]
        
        for key in propertyList {
            let value = model.value(forKey: key)
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
    @objc public class func creat(key: String, string: String) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: string, key: key)
    }

    /** Param: Double */
    @objc public class func creat(key: String, double: Double) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: double, key: key)
    }

    /** Param: NSInteger */
    @objc public class func creat(key: String, integer: NSInteger) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: integer, key: key)
    }

    /** Param: Int */
    @objc public class func creatInt(key: String, int: Int) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: int, key: key)
    }

    /** Param: CGPoint */
    @objc public class func creat(key: String, point: CGPoint) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: point, key: key)
    }

    /** Param: CGSize */
    @objc public class func creat(key: String, size: CGSize) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: size, key: key)
    }

    /** Param: CGFloat */
    @objc public class func creat(key: String, float: CGFloat) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: float, key: key)
    }

    /** Param: CGRect */
    @objc public class func creat(key: String, rect: CGRect) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: rect, key: key)
    }

    /** Param: Data */
    @objc public class func creat(key: String, data: Data) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: data, key: key)
    }
    
    /** Param: URL */
    @objc public class func creat(key: String, url: URL) -> WisdomRouterParam{
        return WisdomRouterParam.creatAny(param: url, key: key)
    }
 
    private class func creatAny(param: Any, key: String) -> WisdomRouterParam {
        let obj = WisdomRouterParam()
        obj.value = param
        obj.valueTargetKey = key
        return obj
    }
}
