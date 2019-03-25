//
//  WisdomRouterKit.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/14.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

class WisdomRouterKit: NSObject {
    /** 🌟注册控制器 classType:  UIViewController.Type */
    @discardableResult
    class func register(vcClassType: UIViewController.Type) -> WisdomRouterResult{
        return WisdomRouterManager.shared.register(vcClassType: vcClassType)
    }
    
    /** 🌟注册控制器,并注册它的Model属性,属性需要继承 WisdomRouterModel
        1：vcClassType:    UIViewController.Type
        2：modelName:      模型属性名称
        3：modelClassType: WisdomRouterModel.Type
     */
    @discardableResult
    class func register(vcClassType: UIViewController.Type, modelName: String, modelClassType: WisdomRouterModel.Type) -> WisdomRouterResult{
        return WisdomRouterManager.shared.register(vcClassType: vcClassType, modelName: modelName, modelClassType: modelClassType)
    }
    
    /** 🌟注册控制器,并注册它的Hander(回调)属性
       1：vcClassType: UIViewController.Type
       2：handerName:  闭包名称
       3：hander:      (Any)->(UIViewController), 调用router时会调用
     */
    @discardableResult
    class func register(vcClassType: UIViewController.Type, handerName: String, hander: @escaping WisdomRouterClosure) -> WisdomRouterHanderResult{
        return WisdomRouterManager.shared.register(vcClassType: vcClassType, handerName: handerName, hander: hander)
    }
    
    /** ✨Router: 无参数，无回调 */
    class func router(targetVC: String) -> UIViewController{
        return WisdomRouterManager.shared.router(targetVC: targetVC)
    }
    
    /** ✨Router: 有参数，无回调 */
    class func router(targetVC: String, param: WisdomRouterParam) -> UIViewController{
        return WisdomRouterManager.shared.router(targetVC: targetVC, param: param)
    }
    
    /** ✨Router: 无参数，有回调 */
    class func router(targetVC: String, hander: WisdomRouterHander) -> UIViewController{
        return WisdomRouterManager.shared.router(targetVC: targetVC, hander: hander)
    }
    
    /** ✨Router: 有参数，有回调 */
    class func router(targetVC: String, param: WisdomRouterParam, hander: WisdomRouterHander) -> UIViewController{
        return WisdomRouterManager.shared.router(targetVC: targetVC, param: param, hander: hander)
    }
    
    /** ✨Router: 自定义参数集合 */
    class func router(targetVC: String, params: [WisdomRouterParam]) -> UIViewController{
        return WisdomRouterManager.shared.router(targetVC: targetVC, params: params, handers: [])
    }
    
    /** ✨Router: 自定义回调集合 */
    class func router(targetVC: String, handers: [WisdomRouterHander]) -> UIViewController{
        return WisdomRouterManager.shared.router(targetVC: targetVC, params: [], handers: handers)
    }
    
    /** ✨Router: 自定义参数集合和回调集合 */
    class func router(targetVC: String, params: [WisdomRouterParam], handers: [WisdomRouterHander]) -> UIViewController{
        return WisdomRouterManager.shared.router(targetVC: targetVC, params: params, handers: handers)
    }
}


extension UIApplication {
    override open var next: UIResponder? {
        UIApplication.routerKitRunOnce
        return super.next
    }
    
    private static let routerKitRunOnce: Void = {
        WisdomRouterKitToSeeHere.routerKitFunction()
    }()
}

protocol WisdomRouterRegisterProtocol: class{
    static func register()
}

class WisdomRouterKitToSeeHere {
    static func routerKitFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        
        for index in 0 ..< typeCount {
            (types[index] as? WisdomRouterRegisterProtocol.Type)?.register()
        }
        types.deallocate()
    }
}
