//
//  WisdomRouterKit.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/14.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

extension UIApplication {
    override open var next: UIResponder? {
        UIApplication.runOnce
        return super.next
    }
    
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()
}

protocol WisdomRouterRegisterProtocol: class{
    static func register()
}

class NothingToSeeHere {
    static func harmlessFunction() {
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


class WisdomRouterKit: NSObject {
    /** 🌟注册控制器
        1：classType:  UIViewController.Type
     */
    class func register(vcClassType: UIViewController.Type){
        WisdomRouterManager.shared.register(classType: vcClassType)
    }
    
    /** 🌟注册控制器和属性,属性需要继承-> WisdomRouterModel
        1：vcClassType:    UIViewController.Type
        2：modelName:      属性名称
        3：modelClassType: WisdomRouterModel.Type
     */
    class func register(vcClassType: UIViewController.Type, modelName: String, modelClassType: WisdomRouterModel.Type){
        WisdomRouterManager.shared.register(vcClassType: vcClassType, modelName: modelName, modelClassType: modelClassType)
    }
    
    /** 🌟注册控制器和Hander回调
        1：vcClassType: UIViewController.Type
        2：handerName:  闭包名称
        3：hander:      (Any)->(UIViewController), 调用router时会调用
     */
    class func register(vcClassType: UIViewController.Type, handerName: String, hander: @escaping (Any)->(UIViewController)) {
        WisdomRouterManager.shared.register(vcClassType: vcClassType, handerName: handerName, hander: hander)
    }
    
    /** 🌟注册控制器，属性和Hander回调
       1：vcClassType:    UIViewController.Type
       2：modelName:      属性名称
       3：modelClassType: WisdomRouterModel.Type
       4：handerName:     闭包名称
       5：hander:         (Any)->(UIViewController), 调用router时会调用
     */
    class func register(vcClassType: UIViewController.Type,
                          modelName: String,
                     modelClassType: WisdomRouterModel.Type,
                         handerName: String,
                             hander: @escaping (Any)->(UIViewController)) {
        WisdomRouterManager.shared.register(vcClassType: vcClassType, modelName: modelName, modelClassType: modelClassType)
        WisdomRouterManager.shared.register(vcClassType: vcClassType, handerName: handerName, hander: hander)
    }
    
    
    /** Router: 无参数，无回调 */
    class func router(targetVC: String) -> UIViewController {
        return WisdomRouterManager.shared.router(targetVC: targetVC)
    }
    
    /** Router: 有参数，无回调 */
    class func router(targetVC: String, param: WisdomRouterParam) -> UIViewController {
        return WisdomRouterManager.shared.router(targetVC: targetVC, param: param)
    }
    
    /** Router: 无参数，有回调 */
    class func router(targetVC: String, hander: WisdomRouterHander) -> UIViewController {
        return WisdomRouterManager.shared.router(targetVC: targetVC, hander: hander)
    }
    
    /** Router: 有参数，有回调 */
    class func router(targetVC: String, param: WisdomRouterParam, hander: WisdomRouterHander) -> UIViewController {
        return WisdomRouterManager.shared.router(targetVC: targetVC, param: param, hander: hander)
    }
    
    
    /** Router: 自定义参数，自定义回调 */
//    class func router(currentVC: UIViewController, targetVC: String, paramClosure: ()->[WisdomRouterParam],
//                                                                    handerClosure: ()->[WisdomRouterHander]) {
//        WisdomRouterManager.shared.router(currentVC: currentVC, targetVC: targetVC, paramClosure: paramClosure, handerClosure: handerClosure)
//    }
    
    class func hasPropertyList(targetClass: AnyClass, targetParamKey: String) -> Bool {
        var count: UInt32 = 0
        let list = class_copyPropertyList(targetClass, &count)
        
        for i in 0..<Int(count) {
            let pty = list?[i]
            let cName = property_getName(pty!)
            let name = String(utf8String: cName)
            if name == targetParamKey{
                free(list)
                return true
            }
        }
        free(list)
        return false
    }

    class func propertyList(targetClass: WisdomRouterModel.Type) -> [String] {
        var count: UInt32 = 0
        var nameLsit: [String] = []
        let list = class_copyPropertyList(targetClass.classForCoder(), &count)
        
        for i in 0..<Int(count) {
            let pty = list?[i]
            let cName = property_getName(pty!)
            let name = String(utf8String: cName)
            if name != nil{
                nameLsit.append(name!)
            }
        }
        free(list)
        return nameLsit
    }
}
