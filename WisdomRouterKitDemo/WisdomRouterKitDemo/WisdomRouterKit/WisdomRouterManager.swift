//
//  WisdomRouterManager.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/15.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

class WisdomRouterManager: NSObject {
    static let shared = WisdomRouterManager()
    
    private let Dot = "."
    
    /** 注册控制器值 */
    public var vcClassValue: [String: AnyClass] = [:]
    
    /** 注册模型属性值 */
    public var modelClassValue: [String: [String]] = [:]
    
    /** 模型和VC的绑定逻辑值 */
    public var bloCValue: [String: [WisdomRouterRegister]] = [:]
    
    /** 注册控制器 */
    func register(classType: UIViewController.Type){
        let cls = NSStringFromClass(classType)
        if cls.contains(Dot) {
            let value = cls.components(separatedBy: Dot)
            if vcClassValue[value.last!] == nil {
                vcClassValue[value.last!] = classType
            }
        }
    }
    
    /**
        1: 注册控制器
        2: 获取属性列表
        3: 注册继承 WisdomRouterModel 的模型对象属性,
     */
    func register(vcClassType: UIViewController.Type, modeName: String, modelClassType: WisdomRouterModel.Type){
        let vcCls = NSStringFromClass(vcClassType)
        if vcCls.contains(Dot) {
            let value = vcCls.components(separatedBy: Dot)
            if vcClassValue[value.last!] == nil {
                vcClassValue[value.last!] = vcClassType
            }
        }
        
        let cls = NSStringFromClass(modelClassType)
        let propertyList = WisdomRouterKit.propertyList(targetClass: modelClassType)
        if modelClassValue[cls] == nil{
            modelClassValue[cls] = propertyList
        }

        if bloCValue[vcCls] == nil{
            bloCValue[vcCls] = [WisdomRouterRegister(modeName: modeName, modelClass: modelClassType)]
        }else{
            var list = bloCValue[vcCls]
            for obj in list!{
                if obj.modeName == modeName {
                    obj.updateModelClass(modelClass: modelClassType)
                    return
                }
            }
            list!.append(WisdomRouterRegister(modeName: modeName, modelClass: modelClassType))
        }
    }
    
    /** Router: 无参数，无回调 */
    func router(currentVC: UIViewController, targetVC: String) {
        guard let typeClass = vcClassValue[targetVC] as? UIViewController.Type else {
            currentVC.present(UIViewController(), animated: true, completion: nil)
            return
        }
        currentVC.present(typeClass.init(), animated: true, completion: nil)
    }

    /** Router: 有参数，无回调 */
    func router(currentVC: UIViewController, targetVC: String, param: WisdomRouterParam) {
        guard let typeClass = vcClassValue[targetVC] as? UIViewController.Type else {
            currentVC.present(UIViewController(), animated: true, completion: nil)
            return
        }

        let target = typeClass.init()
        if WisdomRouterKit.hasPropertyList(targetClass: typeClass, targetParamKey: param.valueTargetKey){
            if param.valueClass == WisdomRouterModel.self {
                setPropertyList(param: param, target: target)
            }else{
                target.setValue(param.value, forKey: param.valueTargetKey)
            }
        }
        currentVC.present(target, animated: true, completion: nil)
    }
    
    /// model属性赋值
    private func setPropertyList(param: WisdomRouterParam, target: UIViewController){
        if let model = target.value(forKey: param.valueTargetKey) as? WisdomRouterModel {
            let classStr = NSStringFromClass(model.classForCoder)
            let propertyList = modelClassValue[classStr] ?? []
            
            for obj in propertyList {
                let value = param.keyValue[obj]
                if value != nil {
                    model.setValue(value, forKey: obj)
                }
            }
        }else{
            let clsStr = NSStringFromClass(target.classForCoder)
            if let list = bloCValue[clsStr] {
                for obj in list{
                    if obj.modeName == param.valueTargetKey {
                        
                        if let modelClass = obj.modelClass! as? WisdomRouterModel.Type {
                            let model = modelClass.init()
                            let classStr = NSStringFromClass(model.classForCoder)
                            let propertyList = modelClassValue[classStr] ?? []
                            
                            for obj in propertyList {
                                let value = param.keyValue[obj]
                                if value != nil {
                                    model.setValue(value, forKey: obj)
                                }
                            }
                            target.setValue(model, forKey: obj.modeName)
                            return
                        }
                    }
                }
            }
        }
    }
}
