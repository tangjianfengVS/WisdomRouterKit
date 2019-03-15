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
    
    /** 注册控制器 */
    class func register(classType: UIViewController.Type){
        WisdomRouterManager.shared.register(classType: classType)
    }
    
    /**
        1: 注册控制器
        2: 注册继承 WisdomRouterModel 的模型对象属性,
     */
    class func register(vcClassType: UIViewController.Type, modeName: String, modelClassType: WisdomRouterModel.Type){
        WisdomRouterManager.shared.register(vcClassType: vcClassType, modeName: modeName, modelClassType: modelClassType)
    }
    
    /** Router: 无参数，无回调 */
    class func router(currentVC: UIViewController, targetVC: String) {
        WisdomRouterManager.shared.router(currentVC: currentVC, targetVC: targetVC)
    }
    
    /** Router: 有参数，无回调 */
    class func router(currentVC: UIViewController, targetVC: String, param: WisdomRouterParam) {
        WisdomRouterManager.shared.router(currentVC: currentVC, targetVC: targetVC, param: param)
    }
    
    /** 查询属性 */
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

    /** 获取所以属性 */
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
