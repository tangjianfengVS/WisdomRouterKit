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
    
    /** 注册模型绑定逻辑值 */
    public var bloCModelValue: [String: [WisdomRouterRegister]] = [:]
    
    /** 注册闭包绑定逻辑值 */
    public var bloCHanderValue: [String: [WisdomRouterHanderType]] = [:]
    
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
        2: 注册属性列表
        3: 注册模型属性
     */
    func register(vcClassType: UIViewController.Type, modelName: String, modelClassType: WisdomRouterModel.Type){
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

        if bloCModelValue[vcCls] == nil{
            bloCModelValue[vcCls] = [WisdomRouterRegister(modelName: modelName, modelClass: modelClassType)]
        }else{
            var list = bloCModelValue[vcCls]
            for obj in list!{
                if obj.modelName == modelName {
                    return
                }
            }
            list!.append(WisdomRouterRegister(modelName: modelName, modelClass: modelClassType))
        }
    }
    
    /**
       1: 注册控制器
       2: 注册回调Hander,
     */
    func register(vcClassType: UIViewController.Type, handerName: String, hander: @escaping (Any)->(UIViewController)) {
        let vcCls = NSStringFromClass(vcClassType)
        if vcCls.contains(Dot) {
            let value = vcCls.components(separatedBy: Dot)
            if vcClassValue[value.last!] == nil {
                vcClassValue[value.last!] = vcClassType
            }
        }
        
        if bloCHanderValue[vcCls] == nil{
            bloCHanderValue[vcCls] = [WisdomRouterHanderType.init(handerName: handerName, handerValue: hander)]
        }else{
            var list = bloCHanderValue[vcCls]
            for obj in list!{
                if obj.handerName == handerName {
                    return
                }
            }
            list!.append(WisdomRouterHanderType.init(handerName: handerName, handerValue: hander))
        }
    }
    
    /**
       1: 注册控制器
       2: 注册属性列表
       3: 注册模型属性
       4: 注册回调Hander,
     */
    func register(vcClassType: UIViewController.Type,
                    modelName: String, modelClassType: WisdomRouterModel.Type,
                   handerName: String, hander: @escaping (Any)->(UIViewController)){
        register(vcClassType: vcClassType, modelName: modelName, modelClassType: modelClassType)
        register(vcClassType: vcClassType, handerName: handerName, hander: hander)
    }
    
    /** Router: 无参数，无回调 */
    func router(targetVC: String) -> UIViewController{
        guard let typeClass = vcClassValue[targetVC] as? UIViewController.Type else {
            return UIViewController()
        }
        return typeClass.init()
    }

    /** Router: 有参数，无回调 */
    func router(targetVC: String, param: WisdomRouterParam) -> UIViewController {
        guard let typeClass = vcClassValue[targetVC] as? UIViewController.Type else {
            return UIViewController()
        }

        let target = typeClass.init()
        if WisdomRouterKit.hasPropertyList(targetClass: typeClass, targetParamKey: param.valueTargetKey){
            if param.valueClass == WisdomRouterModel.self {
                setPropertyList(param: param, target: target)
            }else if param.valueClass == WisdomRouterModelList.self {
                setListPropertyList(param: param, target: target)
            }else{
                target.setValue(param.value, forKey: param.valueTargetKey)
            }
        }
        return target
    }
    
    /** Router: 无参数，有回调 */
    func router(targetVC: String, hander: WisdomRouterHander) -> UIViewController {
        guard let typeClass = vcClassValue[targetVC] as? UIViewController.Type else {
            return UIViewController()
        }
        let target = typeClass.init()
        let clsStr = NSStringFromClass(target.classForCoder)
        if WisdomRouterKit.hasPropertyList(targetClass: typeClass, targetParamKey: hander.valueTargetKey){
            if hander.value != nil{
                if let list = bloCHanderValue[clsStr] {
                    for obj in list{
                        if obj.handerName == hander.valueTargetKey {
                            let VC = obj.handerValue!(hander.value!)
                            return VC
                        }
                    }
                }
            }
        }
        return target
    }
    
    /** Router: 有参数，有回调 */
    func router(targetVC: String, param: WisdomRouterParam, hander: WisdomRouterHander) -> UIViewController {
        guard let typeClass = vcClassValue[targetVC] as? UIViewController.Type else {
            return UIViewController()
        }
        
        let target = typeClass.init()
        let clsStr = NSStringFromClass(target.classForCoder)
        if WisdomRouterKit.hasPropertyList(targetClass: typeClass, targetParamKey: param.valueTargetKey){
            if param.valueClass == WisdomRouterModel.self {
                setPropertyList(param: param, target: target)
            }else if param.valueClass == WisdomRouterModelList.self {
                setListPropertyList(param: param, target: target)
            }else{
                target.setValue(param.value, forKey: param.valueTargetKey)
            }
        }
        
        if WisdomRouterKit.hasPropertyList(targetClass: typeClass, targetParamKey: hander.valueTargetKey){
            if hander.value != nil{
                if let list = bloCHanderValue[clsStr] {
                    for obj in list{
                        if obj.handerName == hander.valueTargetKey {
                            let VC = obj.handerValue!(hander.value!)
                            return VC
                        }
                    }
                }
            }
        }
        return target
    }
    
    /** Router: 自定义参数，自定义回调 */
    func router(currentVC: UIViewController, targetVC: String, paramClosure: () -> [WisdomRouterParam],
                                                              handerClosure: () -> [WisdomRouterHander]) {
//        guard let typeClass = vcClassValue[targetVC] as? UIViewController.Type else {
//            currentVC.present(UIViewController(), animated: true, completion: nil)
//            return
//        }
//
//        let target = typeClass.init()
////        if WisdomRouterKit.hasPropertyList(targetClass: typeClass, targetParamKey: param.valueTargetKey){
////            if param.valueClass == WisdomRouterModel.self {
////                setPropertyList(param: param, target: target)
////            }else if param.valueClass == WisdomRouterModelList.self {
////                setListPropertyList(param: param, target: target)
////            }else{
////                target.setValue(param.value, forKey: param.valueTargetKey)
////            }
////        }
//        currentVC.present(target, animated: true, completion: nil)
    }
    
    /// model属性赋值
    private func setPropertyList(param: WisdomRouterParam, target: UIViewController){
        if let model = target.value(forKey: param.valueTargetKey) as? WisdomRouterModel {
            let classStr = NSStringFromClass(model.classForCoder)
            let propertyList = modelClassValue[classStr] ?? []
            
            for obj in propertyList {
                let value = param.keyValue.first![obj]
                if value != nil {
                    model.setValue(value, forKey: obj)
                }
            }
        }else{
            let clsStr = NSStringFromClass(target.classForCoder)
            if let list = bloCModelValue[clsStr] {
                for obj in list{
                    if obj.modelName == param.valueTargetKey {
                        
                        if let modelClass = obj.modelClass! as? WisdomRouterModel.Type {
                            let model = modelClass.init()
                            let classStr = NSStringFromClass(model.classForCoder)
                            let propertyList = modelClassValue[classStr] ?? []
                            
                            for obj in propertyList {
                                let value = param.keyValue.first![obj]
                                if value != nil {
                                    model.setValue(value, forKey: obj)
                                }
                            }
                            target.setValue(model, forKey: obj.modelName)
                            return
                        }
                    }
                }
            }
        }
    }
    
    /// modelList属性赋值
    private func setListPropertyList(param: WisdomRouterParam, target: UIViewController){
        func setPropert(obj: WisdomRouterRegister, modelList: inout [WisdomRouterModel]){
            for ject in param.keyValue {
                if let modelClass = obj.modelClass! as? WisdomRouterModel.Type {
                    let model = modelClass.init()
                    let classStr = NSStringFromClass(model.classForCoder)
                    let propertyList = modelClassValue[classStr] ?? []
                    
                    for key in propertyList {
                        let value = ject[key]
                        if value != nil {
                            model.setValue(value, forKey: key)
                        }
                    }
                    modelList.append(model)
                }
            }
            target.setValue(modelList, forKey: obj.modelName)
        }

        if var modelList = target.value(forKey: param.valueTargetKey) as? [WisdomRouterModel] {
            let clsStr = NSStringFromClass(target.classForCoder)
            if let list = bloCModelValue[clsStr] {
                for obj in list{
                    if obj.modelName == param.valueTargetKey {
                        setPropert(obj: obj, modelList: &modelList)
                        return
                    }
                }
            }
        }else{
            let clsStr = NSStringFromClass(target.classForCoder)
            if let list = bloCModelValue[clsStr] {
                for obj in list{
                    if obj.modelName == param.valueTargetKey {
                        var modelList: [WisdomRouterModel] = []
                        setPropert(obj: obj, modelList: &modelList)
                        return
                    }
                }
            }
        }
    }
}
