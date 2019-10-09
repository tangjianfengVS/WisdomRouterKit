//
//  WisdomRouterKit.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/14.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

/** Register Protocol */
public protocol WisdomRouterRegisterProtocol: NSObject{
    static func register()
}


public class WisdomRouterKit: NSObject {
    
    /**
      🌟register: 注册控制器
       - parameter classType:  UIViewController.Type
       - returns : WisdomRouterResult
     */
    @discardableResult
    @objc public class func register(vcClassType: UIViewController.Type) -> WisdomRouterResult{
        return WisdomRouterManager.shared.register(vcClassType: vcClassType)
    }
    
    
    /**
       🌟register: 注册控制器,并注册它的Model属性,属性需要继承 WisdomRouterModel
       - parameter vcClassType:    UIViewController.Type
       - parameter modelName:      模型属性名称
       - parameter modelClassType: 模型属性类型
       - returns : WisdomRouterResult
     */
    @discardableResult
    @objc public class func register(vcClassType: UIViewController.Type, modelName: String, modelClassType: WisdomRouterModel.Type) -> WisdomRouterResult{
        return WisdomRouterManager.shared.register(vcClassType: vcClassType, modelName: modelName, modelClassType: modelClassType)
    }
    
    
    /**
       🌟register: 注册控制器,并注册它的Hander(回调)属性
       - parameter vcClassType: UIViewController.Type
       - parameter handerName:  闭包名称
       - parameter hander:      (Any)->(UIViewController)实现闭包, 调用router时会调用
       - returns : WisdomRouterResult
     */
    @discardableResult
    @objc public class func register(vcClassType: UIViewController.Type, handerName: String, hander: @escaping WisdomRouterClosure) -> WisdomRouterResult{
        return WisdomRouterManager.shared.register(vcClassType: vcClassType, handerName: handerName, hander: hander)
    }
    
    
    /**
       🔥router: 无参数，无回调
       - parameter targetVC: 无参数，无回调
       - returns : UIViewController
     */
    @objc public class func router(targetVC: String) -> UIViewController{
        return WisdomRouterManager.shared.router(targetVC: targetVC)
    }
    
    
    /**
       🔥router: 有参数，无回调
       - parameter param: 参数
       - returns : UIViewController
     */
    @objc public class func router(targetVC: String, param: WisdomRouterParam) -> UIViewController{
        return WisdomRouterManager.shared.router(targetVC: targetVC, param: param)
    }
    
    
    /**
       🔥router: 无参数，有回调
       - parameter hander: 回调
       - returns : UIViewController
     */
    @objc public class func router(targetVC: String, hander: WisdomRouterHander) -> UIViewController{
        return WisdomRouterManager.shared.router(targetVC: targetVC, hander: hander)
    }
    
    
    /**
       🔥router: 有参数，有回调
       - parameter param: 参数
       - parameter hander: 回调
       - returns : UIViewController
     */
    @objc public class func router(targetVC: String, param: WisdomRouterParam, hander: WisdomRouterHander) -> UIViewController{
        return WisdomRouterManager.shared.router(targetVC: targetVC, param: param, hander: hander)
    }
    
    
    /**
       🔥router: 自定义参数集合
       - parameter params: 自定义参数集合
       - returns : UIViewController
     */
    @objc public class func router(targetVC: String, params: [WisdomRouterParam]) -> UIViewController{
        return WisdomRouterManager.shared.router(targetVC: targetVC, params: params, handers: [])
    }
    
    
    /**
       🔥router: 自定义回调集合
       - parameter handers: 自定义回调集合
       - returns : UIViewController
     */
    @objc public class func router(targetVC: String, handers: [WisdomRouterHander]) -> UIViewController{
        return WisdomRouterManager.shared.router(targetVC: targetVC, params: [], handers: handers)
    }
    
    
    /**
       🔥router: 自定义参数集合和回调集合
       - parameter params: 自定义参数集合
       - parameter handers: 自定义回调集合
       - returns : UIViewController
     */
    @objc public class func router(targetVC: String, params: [WisdomRouterParam], handers: [WisdomRouterHander]) -> UIViewController{
        return WisdomRouterManager.shared.router(targetVC: targetVC, params: params, handers: handers)
    }
    
    
    /**
       ❄️routerShare: 获取全局单列 Model
       - parameter shareName: 全局单列 Name
       - parameter targetSubstituteClass: 替身 Model 类型
       - returns : 返回值 WisdomRouterModel
       - returns : WisdomRouterModel
     */
    @objc public class func routerShare(shareName: String, targetSubstituteClass: WisdomRouterModel.Type) -> WisdomRouterModel{
        return WisdomRouterManager.routerShare(shareName: shareName, targetSubstituteClass: targetSubstituteClass)
    }
}

