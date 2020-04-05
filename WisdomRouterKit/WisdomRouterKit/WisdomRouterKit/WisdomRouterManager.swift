//
//  WisdomRouterManager.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/15.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

class WisdomRouterManager {
    
    static let shared = WisdomRouterManager()
    
    /// 注册控制器属性
    private(set) var registerRouterVCInfo: [String: WisdomRouterRegisterInfo] = [:]
    
    private let modelPropertyCache = NSCache<AnyObject, AnyObject>()
    
    
    /// get class
     private class func getClass(stringName: String) -> (UIViewController.Type?,String){
         guard let childVcClass = NSClassFromString(stringName) else {
             return (nil,"没有获取到对应的class: " + stringName)
         }
         
         guard let childVcType = childVcClass as? UIViewController.Type else {
             return (nil,"没有得到类型 UIViewController : " + stringName)
         }
         return (childVcType, "")
     }
     
     
     /// get shared class
     private class func getSharedClass(stringName: String) -> (WisdomRouterModel.Type?, String){
         guard let childModelClass = NSClassFromString(stringName) else {
             return (nil,"没有获取到对应的class: " + stringName)
         }
         
         guard let childModelType = childModelClass as? WisdomRouterModel.Type else {
             return (nil,"没有得到类型 Model: " + stringName)
         }
         return (childModelType, "")
     }
     
     
     /// Handler赋值
     private class func setVCRouterHandler(targetVC: UIViewController,
                                           handler: WisdomRouterHandler,
                                           className: String,
                                           project: String) -> [String] {
         var errorList : [String] = []
         let result = WisdomRouterManager.hasPropertyList(targetClass: targetVC.classForCoder,
                                                          targetParamKey: handler.valueTargetKey)
         if result.0 {
             errorList = WisdomRouterManager.shared.setHandlerProperty(targetVC: targetVC, handler: handler)
         }else{
             errorList.append(className + "⚠️未实现 Handler 属性: "+"'"+handler.valueTargetKey+"'")
         }
         return errorList
     }
     
     
     /// Hander属性赋值
     private func setHandlerProperty(targetVC: UIViewController, handler: WisdomRouterHandler) -> [String] {
         var errorList: [String] = []
         let key = NSStringFromClass(targetVC.classForCoder)
         let registerInfo = WisdomRouterManager.shared.registerRouterVCInfo[key]
         
         if registerInfo != nil {
             var has = false
             
             for registerHandler in registerInfo!.handlerList {
                 if registerHandler.handlerName == handler.valueTargetKey {
                     has = true
                     registerHandler.handlerValue(handler.value!,targetVC)
                     break
                 }
             }
             if !has {
                 let error = NSStringFromClass(targetVC.classForCoder)+" ⚠️未注册Handler：'"+handler.valueTargetKey+"'"
                 errorList.append(error)
             }
         }else{
             let error = NSStringFromClass(targetVC.classForCoder)+" ⚠️未注册Handler：'"+handler.valueTargetKey+"'"
             errorList.append(error)
         }
         return errorList
     }
     
     
     /// 参数赋值
     private class func setVCRouterParam(targetVC: UIViewController,
                                         param: WisdomRouterParam,
                                         className: String,
                                         project: String) -> [String] {
         var errorList : [String] = []
         let result = WisdomRouterManager.hasPropertyList(targetClass: targetVC.classForCoder,
                                                          targetParamKey: param.valueTargetKey)
         if result.0 {
             var error = ""
             if param.valueClass == WisdomRouterModel.self {
                 errorList = setModelProperty(targetVC: targetVC,
                                              param: param,
                                              project: project,
                                              vcModelStr: result.1)
             }else if param.valueClass == WisdomRouterModelList.self {
                 errorList = setModelListProperty(targetVC: targetVC,
                                                  param: param,
                                                  project: project,
                                                  vcModelStr: result.1)
             }else{
                 error = set_VC_Value(target: targetVC,
                                      param: param,
                                      tagerDateType: result.1,
                                      className: className)
                 if error.count > 0 {
                     errorList.append(error)
                 }
             }
         }else{
             errorList.append(className + "⚠️未实现属性: "+"'"+param.valueTargetKey+"'")
         }
         return errorList
     }
     
     
     /// model 属性赋值
     private class func setModelProperty(targetVC: UIViewController,
                                         param: WisdomRouterParam,
                                         project: String,
                                         vcModelStr: String) -> [String] {
         var errorList: [String] = []
         /// 判断是否是 Model
         if vcModelStr.contains(project) {
             let range = vcModelStr.range(of: project)
             let suffix_vcModelStr = vcModelStr.suffix(from: range!.lowerBound)
             var vcModelClassStr : String = String(suffix_vcModelStr)
             for replacing in ReplacingList {
                vcModelClassStr = vcModelClassStr.replacingOccurrences(of: replacing, with: ".")
             }
             
             if let vcModelClass = NSClassFromString(vcModelClassStr) as? WisdomRouterModel.Type {
                 let model = vcModelClass.init()

                 errorList = set_Model_Value(target:model, startProperty:param.keyValue.first!, vcModelClass: vcModelClass)
                 targetVC.setValue(model, forKey: param.valueTargetKey)
             }else{
                 errorList.append(vcModelStr+" ⚠️属性Model '"+param.valueTargetKey+"'"+" ⚠️未继承: ‘WisdomRouterModel’")
             }
         }else{
             errorList.append(vcModelStr+" ⚠️属性Model '"+param.valueTargetKey+"'"+" ⚠️未继承: ‘WisdomRouterModel’")
         }
         return errorList
     }
     
     
     /// model list 属性赋值
     private class func setModelListProperty(targetVC: UIViewController,
                                             param: WisdomRouterParam,
                                             project: String,
                                             vcModelStr: String) -> [String] {
         var errorList: [String] = []
         let key = NSStringFromClass(targetVC.classForCoder)
         let registerInfo = WisdomRouterManager.shared.registerRouterVCInfo[key]
         
         if registerInfo != nil {
             var has = false
             
             for registerModel in registerInfo!.modelList {
                 if registerModel.modelListName == param.valueTargetKey {
                     has = true
                     let modelClass : WisdomRouterModel.Type = registerModel.modelClass!
                     var rray : [WisdomRouterModel] = []

                     for property in param.keyValue {
                         let model = modelClass.init()
                         let errorArray = set_Model_Value(target:model, startProperty:property, vcModelClass: modelClass)

                         rray.append(model)
                         errorList = errorList + errorArray
                     }
                     targetVC.setValue(rray, forKey: param.valueTargetKey)
                 }
             }
             if !has {
                 let error = NSStringFromClass(targetVC.classForCoder)+" ⚠️未注册属性：'"+param.valueTargetKey+"'"
                 errorList.append(error)
             }
         }else{
             let error = NSStringFromClass(targetVC.classForCoder)+" ⚠️未注册属性：'"+param.valueTargetKey+"'"
             errorList.append(error)
         }
         return errorList
     }
     
     
     /// model  属性赋值
     private class func setSharedModelProperty(param: WisdomRouterParam,
                                               substituteModel: WisdomRouterModel,
                                               substituteModelType: WisdomRouterModel.Type) -> [String] {
         var errorList: [String] = []
         errorList = set_Model_Value(target:substituteModel,
                                     startProperty:param.keyValue.first!,
                                     vcModelClass: substituteModelType)
         return errorList
     }
     
     
     /// 判断属性实现
     class func hasPropertyList(targetClass: AnyClass, targetParamKey: String) -> (Bool,String) {
         var count: UInt32 = 0
         let list = class_copyPropertyList(targetClass, &count)

         for i in 0..<Int(count) {
             let pty = list?[i]
             let cName = property_getName(pty!)
             let name = String(utf8String: cName)
             if name == targetParamKey{
                 let type = WisdomRouterManager.getTypeOf(property: pty!)
                 free(list)
                 return (true, type)
             }
         }
         free(list)
         return (false,"")
     }
     
     
     /// VC属性赋值
     private class func set_VC_Value(target: UIViewController,
                                     param: WisdomRouterParam,
                                     tagerDateType: String,
                                     className: String) -> String{
         if param.typeValue.contains(tagerDateType) {
             target.setValue(param.value, forKey: param.valueTargetKey)
             return ""
         }else{
             let error = className + " ⚠️属性类型不匹配: "+"'"+param.valueTargetKey+"'"+" -> "+tagerDateType
             return error
         }
     }
     
     
     /// Model属性赋值
     private class func set_Model_Value(target: WisdomRouterModel,
                                        startProperty: [String: WisdomRouterRegisterProperty],
                                        vcModelClass: WisdomRouterModel.Type) -> [String]{
         var errorList: [String] = []
         let className = NSStringFromClass(vcModelClass)
         var propertyList: [WisdomRouterRegisterProperty] = []
         
         let list = WisdomRouterManager.shared.modelPropertyCache.object(forKey: className as AnyObject) as? [WisdomRouterRegisterProperty]
         if  list != nil{
             propertyList = list!
         }else{
             propertyList = WisdomRouterManager.propertyList(targetClass: vcModelClass)
             WisdomRouterManager.shared.modelPropertyCache.setObject(propertyList as AnyObject,
                                                                     forKey: className as AnyObject)
         }
         
         for registerProperty in startProperty {
             var succeed = false
             let startP = registerProperty.value

             for property in propertyList {
                 if startP.name == property.name{
                     succeed = true
                     
                     if startP.nameType == property.nameType {
                         target.setValue(startP.value, forKey: property.name)
                     }else{
                         let error = className+" ⚠️属性类型不匹配: "+"'"+startP.nameType+"'"+" -> "+property.nameType
                         errorList.append(error)
                     }
                     break
                 }
             }

             if !succeed {
                 errorList.append(className+" ⚠️未实现属性: "+"'"+startP.name+"'")
             }
         }
         return errorList
     }
     
    
     /// 属性列表
     class func propertyList(targetClass: WisdomRouterModel.Type) -> [WisdomRouterRegisterProperty] {
         var count: UInt32 = 0
         var nameLsit: [WisdomRouterRegisterProperty] = []
         let list = class_copyPropertyList(targetClass.classForCoder(), &count)

         for i in 0..<Int(count) {
             let pty = list?[i]
             let cName = property_getName(pty!)
             let name = String(utf8String: cName)
             if name != nil {
                 /// date type
                 let type = WisdomRouterManager.getTypeOf(property: pty!)
                 nameLsit.append(WisdomRouterRegisterProperty(name: name!, nameType: type))
             }
         }
         free(list)
         return nameLsit
     }
     
     
     /// 类型分类
     private class func getTypeOf(property: objc_property_t) -> String {
         let str = property_getAttributes(property)!
         guard let attributesStr = String(utf8String: str) else {
             return " "
         }
         let slices = attributesStr.components(separatedBy: "\"")

         guard slices.count > 1 else {
             return WisdomRouterManager.valueType(withAttributes: attributesStr)
         }
         let objectClassName = slices[1]
         return objectClassName
     }
     
     
     /// 类型确定
     private class func valueType(withAttributes attributes: String) -> String {
         if attributes.contains(Bracket) && attributes.contains(Equal){
             let res = attributes.components(separatedBy: Bracket)
             let res2 = res[1].components(separatedBy: Equal)
             return res2.first!
         }else{
             let tmp = attributes as NSString
             let letter = tmp.substring(with: NSMakeRange(1, 1))
             guard let type = valueTypesMap[letter] else {
                 return " "
             }
             return type
         }
     }
    
}


extension WisdomRouterManager {
    
    //MARK: - register 注册数组模型
    func register(vcClassType: UIViewController.Type,
                  modelListName: String,
                  modelListClass: WisdomRouterModel.Type) -> WisdomRouterResult {
        let key = NSStringFromClass(vcClassType)
        if var VCInfo : WisdomRouterRegisterInfo = registerRouterVCInfo[key] {
            var hasModelListName = false
            for registerModel in VCInfo.modelList {
                /// 存在不操作
                if registerModel.modelListName == modelListName {
                    hasModelListName = true
                    break
                }
            }
            
            if !hasModelListName {
                let registerModel = WisdomRouterRegisterModel(modelListName: modelListName,
                                                              modelClass: modelListClass)
                VCInfo.add(model: registerModel)
                registerRouterVCInfo[key] = VCInfo
            }
            return WisdomRouterResult(vcClassType: vcClassType, info: VCInfo)
        }else{
            var info = WisdomRouterRegisterInfo(vcClassType: vcClassType)
            let registerModel = WisdomRouterRegisterModel(modelListName: modelListName,
                                                          modelClass: modelListClass)
            info.add(model: registerModel)
            registerRouterVCInfo[key] = info
            return WisdomRouterResult(vcClassType: vcClassType, info: info)
        }
    }
    
    
    //MARK: - register 注册Handler
    func register(vcClassType: UIViewController.Type,
                  handlerName: String,
                  handler: @escaping RouterRegisterHandler) -> WisdomRouterResult{
        let key = NSStringFromClass(vcClassType)
        if var VCInfo : WisdomRouterRegisterInfo = registerRouterVCInfo[key] {
            var hasHandlerName = false
            for registerHandler in VCInfo.handlerList {
                /// 存在不操作
                if registerHandler.handlerName == handlerName {
                    hasHandlerName = true
                    break
                }
            }
            
            if !hasHandlerName {
                let registerHandler = WisdomRouterRegisterHandler(handerName: handlerName,
                                                                  handlerValue: handler)
                VCInfo.add(handler: registerHandler)
                registerRouterVCInfo[key] = VCInfo
            }
            return WisdomRouterResult(vcClassType: vcClassType, info: VCInfo)
        }else{
            var info = WisdomRouterRegisterInfo(vcClassType: vcClassType)
            let registerHandler = WisdomRouterRegisterHandler(handerName: handlerName,
                                                              handlerValue: handler)
            info.add(handler: registerHandler)
            registerRouterVCInfo[key] = info
            return WisdomRouterResult(vcClassType: vcClassType, info: info)
        }
    }
    
    
    //MARK: - router 无参数，无Handler
    public class func router(targetVC: String,
                             project: String,
                             routerHandler: RouterHandler,
                             routerErrorHandler: RouterErrorHandler) {
        let result = WisdomRouterManager.getClass(stringName: project + Dot + targetVC)
        if let vcClass = result.0 {
            let VC = vcClass.init()
            routerHandler(VC)
        } else {
            routerErrorHandler(result.1)
        }
    }
    
    
    //MARK: - router 有参数，无Handler
    public class func router(targetVC: String,
                             project: String,
                             param: WisdomRouterParam,
                             routerResultHandler: RouterResultHandler,
                             routerErrorHandler: RouterErrorHandler) {
        let className = project + Dot + targetVC
        let result = WisdomRouterManager.getClass(stringName: className)
        if let vcClass = result.0 {
            let VC = vcClass.init()
            let warning: [String] = WisdomRouterManager.setVCRouterParam(targetVC: VC,
                                                                         param: param,
                                                                         className: className,
                                                                         project: project)
            routerResultHandler(VC,warning)
        } else {
            routerErrorHandler(result.1)
        }
    }


    //MARK: - router 无参数，有Handler
    public class func router(targetVC: String,
                             project: String,
                             handler: WisdomRouterHandler,
                             routerResultHandler: RouterResultHandler,
                             routerErrorHandler: RouterErrorHandler) {
        let className = project + Dot + targetVC
        let result = WisdomRouterManager.getClass(stringName: className)
        if let vcClass = result.0 {
            let VC = vcClass.init()
            let warning: [String] = WisdomRouterManager.setVCRouterHandler(targetVC: VC,
                                                                           handler: handler,
                                                                           className: className,
                                                                           project: project)
            routerResultHandler(VC,warning)
        } else {
            routerErrorHandler(result.1)
        }
    }
    
    
    //MARK: - router 有参数，有Handler
    public class func router(targetVC: String,
                             project: String,
                             param: WisdomRouterParam,
                             handler: WisdomRouterHandler,
                             routerResultHandler: RouterResultHandler,
                             routerErrorHandler: RouterErrorHandler) {
        let className = project + Dot + targetVC
        let result = WisdomRouterManager.getClass(stringName: className)
        if let vcClass = result.0 {
            let VC = vcClass.init()
            let warningM: [String] = WisdomRouterManager.setVCRouterParam(targetVC: VC,
                                                                          param: param,
                                                                          className: className,
                                                                          project: project)
            let warningH: [String] = WisdomRouterManager.setVCRouterHandler(targetVC: VC,
                                                                            handler: handler,
                                                                            className: className,
                                                                            project: project)
            routerResultHandler(VC,warningM+warningH)
        } else {
            routerErrorHandler(result.1)
        }
    }
    
    
    //MARK: - router 多参数集合，无Handler
    public class func router(targetVC: String,
                             project: String,
                             params: [WisdomRouterParam],
                             routerResultHandler: RouterResultHandler,
                             routerErrorHandler: RouterErrorHandler) {
        let className = project + Dot + targetVC
        let result = WisdomRouterManager.getClass(stringName: className)
        if let vcClass = result.0 {
            let VC = vcClass.init()
            var warningL: [String] = []
            for param in params {
                let warningP = WisdomRouterManager.setVCRouterParam(targetVC: VC,
                                                                    param: param,
                                                                    className: className,
                                                                    project: project)
                warningL = warningL + warningP
            }
            routerResultHandler(VC,warningL)
        } else {
            routerErrorHandler(result.1)
        }
    }
    
    
    //MARK: - router 无参数集合，多Handler集合
    public class func router(targetVC: String,
                             project: String,
                             handlers: [WisdomRouterHandler],
                             routerResultHandler: RouterResultHandler,
                             routerErrorHandler: RouterErrorHandler) {
        let className = project + Dot + targetVC
        let result = WisdomRouterManager.getClass(stringName: className)
        if let vcClass = result.0 {
            let VC = vcClass.init()
            var warningL: [String] = []
            for handler in handlers {
                let warningP: [String] = WisdomRouterManager.setVCRouterHandler(targetVC: VC,
                                                                                handler: handler,
                                                                                className: className,
                                                                                project: project)
                warningL = warningL + warningP
            }
            routerResultHandler(VC,warningL)
        } else {
            routerErrorHandler(result.1)
        }
    }
    
    
    //MARK: - router 多参数集合，多Handler集合
    public class func router(targetVC: String,
                             project: String,
                             params: [WisdomRouterParam],
                             handlers: [WisdomRouterHandler],
                             routerResultHandler: RouterResultHandler,
                             routerErrorHandler: RouterErrorHandler) {
        let className = project + Dot + targetVC
        let result = WisdomRouterManager.getClass(stringName: className)
        if let vcClass = result.0 {
            let VC = vcClass.init()
            var warningL: [String] = []
            for param in params {
                let warningP = WisdomRouterManager.setVCRouterParam(targetVC: VC,
                                                                    param: param,
                                                                    className: className,
                                                                    project: project)
                warningL = warningL + warningP
            }
            
            for handler in handlers {
                let warningP: [String] = WisdomRouterManager.setVCRouterHandler(targetVC: VC,
                                                                                handler: handler,
                                                                                className: className,
                                                                                project: project)
                warningL = warningL + warningP
            }
            routerResultHandler(VC,warningL)
        } else {
            routerErrorHandler(result.1)
        }
    }
    
    
    //MARK: - routerShared 获取全局单列 Model
    class func routerShared(sharedClassName: String,
                            project: String,
                            substituteModelType: WisdomRouterModel.Type,
                            routerSharedHandler: RouterSharedHandler,
                            routerErrorHandler: RouterErrorHandler){
        let className = project + Dot + sharedClassName
        let result = WisdomRouterManager.getSharedClass(stringName: className)
        
        if let sharedClass = result.0 {
            let sharedModel = sharedClass.init()
            
            if sharedModel.responds(to: #selector(WisdomRouterShareProtocol.routerShared)){
                let model = (sharedModel as! WisdomRouterShareProtocol).routerShared()
                let param = WisdomRouterParam.create(key: "",model: model)
                let substituteModel = substituteModelType.init()
                
                let warning: [String] = setSharedModelProperty(param: param,
                                                               substituteModel: substituteModel,
                                                               substituteModelType: substituteModelType)
                routerSharedHandler(substituteModel, warning)
            }else{
                routerErrorHandler(result.1)
            }
        }else{
            routerErrorHandler(result.1)
        }
    }
    
}
