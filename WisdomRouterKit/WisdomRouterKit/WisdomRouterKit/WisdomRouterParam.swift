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
    
    private(set) var value: Any!
    
    private(set) var valueTargetKey: String=""
    
    private(set) var keyValue: [[String: WisdomRouterRegisterProperty]] = []
    
    private(set) var typeValue: String=""
    
    /** Param: ModelList */
    @objc public class func create(key: String, modelList: [WisdomRouterModel]) -> WisdomRouterParam{
        let obj = WisdomRouterParam()
        obj.value = modelList
        obj.valueTargetKey = key
        obj.valueClass = WisdomRouterModelList.self
        let propertyList = WisdomRouterManager.propertyList(targetClass: modelList.first!.classForCoder as! WisdomRouterModel.Type)
        
        for ject in modelList {
            var dict: [String: WisdomRouterRegisterProperty] = [:]
            
            for key in propertyList {
                let value = ject.value(forKey: key.name)
                if value != nil{
                    var property = WisdomRouterRegisterProperty(name: key.name, nameType: key.nameType)
                    property.updateValue(value: value!)
                    dict[key.name] = property
                }
            }
            obj.keyValue.append(dict)
        }
        return obj
    }
    
    
    /** Param: Model */
    @objc public class func create(key: String, model: WisdomRouterModel) -> WisdomRouterParam{
        let obj = WisdomRouterParam()
        obj.value = model
        obj.valueTargetKey = key
        obj.valueClass = WisdomRouterModel.self
        let propertyList = WisdomRouterManager.propertyList(targetClass: model.classForCoder as! WisdomRouterModel.Type)
        var dict: [String: WisdomRouterRegisterProperty] = [:]
        
        for key in propertyList {
            let value = model.value(forKey: key.name)
            if value != nil{
                var property = WisdomRouterRegisterProperty(name: key.name, nameType: key.nameType)
                property.updateValue(value: value!)
                dict[key.name] = property
            }
        }
        obj.keyValue.append(dict)
        return obj
    }
    
    
    /** Param: Bool */
    class func create(key: String, bool: Bool) -> WisdomRouterParam{
        let obj = WisdomRouterParam.createAny(param: bool, key: key)
        obj.typeValue = "Bool,BOOL"
        return obj
    }
    
    
    /** Param: String */
    @objc public class func create(key: String, string: String) -> WisdomRouterParam{
        let obj = WisdomRouterParam.createAny(param: string, key: key)
        obj.typeValue = "String,NSString"
        return obj
    }
    

    /** Param: Double */
    @objc public class func create(key: String, double: Double) -> WisdomRouterParam{
        let obj = WisdomRouterParam.createAny(param: double, key: key)
        obj.typeValue = DateBaseKey
        return obj
    }
    

    /** Param: NSInteger */
    @objc public class func create(key: String, integer: NSInteger) -> WisdomRouterParam{
        let obj = WisdomRouterParam.createAny(param: integer, key: key)
        obj.typeValue = DateBaseKey
        return obj
    }
    

    /** Param: Int */
    @objc public class func create(key: String, int: Int) -> WisdomRouterParam{
        let obj = WisdomRouterParam.createAny(param: int, key: key)
        obj.typeValue = DateBaseKey
        return obj
    }
    
    
    /** Param: CGFloat */
    @objc public class func create(key: String, cgFloat: CGFloat) -> WisdomRouterParam{
        let obj = WisdomRouterParam.createAny(param: cgFloat, key: key)
        obj.typeValue = DateBaseKey
        return obj
    }
    

    /** Param: CGPoint */
    @objc public class func create(key: String, point: CGPoint) -> WisdomRouterParam{
        let obj = WisdomRouterParam.createAny(param: point, key: key)
        obj.typeValue = "CGPoint"
        return obj
    }
    

    /** Param: CGSize */
    @objc public class func create(key: String, size: CGSize) -> WisdomRouterParam{
        let obj = WisdomRouterParam.createAny(param: size, key: key)
        obj.typeValue = "CGSize"
        return obj
    }
    

    /** Param: CGRect */
    @objc public class func create(key: String, rect: CGRect) -> WisdomRouterParam{
        let obj = WisdomRouterParam.createAny(param: rect, key: key)
        obj.typeValue = "CGRect"
        return obj
    }
    

    /** Param: Data */
    @objc public class func create(key: String, data: Data) -> WisdomRouterParam{
        let obj = WisdomRouterParam.createAny(param: data, key: key)
        obj.typeValue = "Data,NSData"
        return obj
    }
    
    
    /** Param: URL */
    @objc public class func create(key: String, url: URL) -> WisdomRouterParam{
        let obj = WisdomRouterParam.createAny(param: url, key: key)
        obj.typeValue = "URL,NSURL"
        return obj
    }
    
    
    /** Param: NSNumber */
    @objc public class func create(key: String, number: NSNumber) -> WisdomRouterParam{
        let obj = WisdomRouterParam.createAny(param: number, key: key)
        obj.typeValue = "NSNumber"
        return obj
    }
    
    
    /** Param: UIView */
    @objc public class func create(key: String, uiView: UIView) -> WisdomRouterParam {
        let obj = WisdomRouterParam.createAny(param: uiView.copy(), key: key)
        obj.typeValue = NSStringFromClass(uiView.classForCoder)
        return obj
    }
    
    
    /** Param: UIImage */
    @objc public class func create(key: String, image: UIImage) -> WisdomRouterParam {
        let obj = WisdomRouterParam.createAny(param: image.copy(), key: key)
        obj.typeValue = NSStringFromClass(image.classForCoder)
        return obj
    }
    
 
    private class func createAny(param: Any, key: String) -> WisdomRouterParam {
        let obj = WisdomRouterParam()
        obj.value = param
        obj.valueTargetKey = key
        return obj
    }
}
