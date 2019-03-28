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
    
    /** 注册控制器值 */
    private(set) var vcClassValue: [String: WisdomRouterRegisterInfo] = [:]
    
    /** 注册模型属性值 */
    private(set) var modelPropertyList: [String: [WisdomRouterRegisterProperty]] = [:]
    
    func register(vcClassType: UIViewController.Type) -> WisdomRouterResult {
        let cls = NSStringFromClass(vcClassType)
        let value = cls.components(separatedBy: Dot)
        guard let info = vcClassValue[value.last!] else {
            let newinfo = WisdomRouterRegisterInfo.init(vcClassType: vcClassType)
            vcClassValue[value.last!] = newinfo
            return WisdomRouterResult(vcClassType: vcClassType, info: newinfo)
        }
        return WisdomRouterResult(vcClassType: vcClassType, info: info)
    }
    
    /** 注册模型 */
    func register(vcClassType: UIViewController.Type, modelName: String, modelClassType: WisdomRouterModel.Type) -> WisdomRouterResult {
        let cls = NSStringFromClass(vcClassType)
        let value = cls.components(separatedBy: Dot)
        if vcClassValue[value.last!] == nil {
            vcClassValue[value.last!] = WisdomRouterRegisterInfo.init(vcClassType: vcClassType)
        }

        let clsM = NSStringFromClass(modelClassType)
        if modelPropertyList[clsM] == nil{
            let propertyList = WisdomRouterManager.propertyList(targetClass: modelClassType)
            modelPropertyList[clsM] = propertyList
        }
        
        var info = vcClassValue[value.last!]!
        if modelName.count == 0 {
            return WisdomRouterResult(vcClassType: vcClassType, info: info)
        }
        
        if info.modelList.count > 0{
            for obj in info.modelList{
                if obj.modelName == modelName {
                    return WisdomRouterResult(vcClassType: vcClassType, info: info)
                }
            }
        }
        info.add(model: WisdomRouterRegisterModel(modelName: modelName, modelClass: modelClassType))
        vcClassValue[value.last!] = info
        return WisdomRouterResult(vcClassType: vcClassType, info: info)
    }

    /** 注册闭包 */
    @discardableResult
    func register(vcClassType: UIViewController.Type, handerName: String, hander: @escaping WisdomRouterClosure) -> WisdomRouterResult{
        let cls = NSStringFromClass(vcClassType)
        let value = cls.components(separatedBy: Dot)
        if vcClassValue[value.last!] == nil {
            vcClassValue[value.last!] = WisdomRouterRegisterInfo.init(vcClassType: vcClassType)
        }

        var info = vcClassValue[value.last!]!
        if handerName.count == 0 {
            return WisdomRouterResult(vcClassType: vcClassType, info: info)
        }
        
        if info.handerList.count > 0{
            for obj in info.handerList{
                if obj.handerName == handerName {
                    return WisdomRouterResult(vcClassType: vcClassType, info: info)
                }
            }
        }
        info.add(hander: WisdomRouterRegisterHander(handerName: handerName, handerValue: hander))
        vcClassValue[value.last!] = info
        return WisdomRouterResult(vcClassType: vcClassType, info: info)
    }

    /** router 基础 */
    func router(targetVC: String) -> UIViewController{
        if vcClassValue[targetVC] == nil {
            WisdomRouterManager.showError(error: targetVC+"\n未注册\n请检查代码")
            return UIViewController()
        }
        
        guard let vcClassType = vcClassValue[targetVC]!.vcClassType else {
            return UIViewController()
        }
        return vcClassType.init()
    }

    /** router 参数 */
    func router(targetVC: String, param: WisdomRouterParam) -> UIViewController {
        if vcClassValue[targetVC] == nil {
            WisdomRouterManager.showError(error: targetVC+"\n未注册\n请检查代码")
            return UIViewController()
        }
        guard let vcClassType = vcClassValue[targetVC]!.vcClassType else {
            return UIViewController()
        }
        var error = ""
        let target = vcClassType.init()
        if WisdomRouterManager.hasPropertyList(targetClass: vcClassType, targetParamKey: param.valueTargetKey){
            if param.valueClass == WisdomRouterModel.self {
                error = setPropertyList(targetVC: targetVC, param: param, target: target)
            }else if param.valueClass == WisdomRouterModelList.self {
                error = setListPropertyList(targetVC: targetVC, param: param, target: target)
            }else{
                target.setValue(param.value, forKey: param.valueTargetKey)
            }
        }else{
            error = param.valueTargetKey+"\n属性查找失败\n请检查代码"
        }
        if error.count > errorCount {
            WisdomRouterManager.showError(error: error)
        }
        return target
    }

    /** router 闭包 */
    func router(targetVC: String, hander: WisdomRouterHander) -> UIViewController {
        if vcClassValue[targetVC] == nil {
            WisdomRouterManager.showError(error: targetVC+"\n未注册\n请检查代码")
            return UIViewController()
        }
        guard let vcClassType = vcClassValue[targetVC]!.vcClassType else {
            return UIViewController()
        }
        let target = vcClassType.init()
        if WisdomRouterManager.hasPropertyList(targetClass: vcClassType, targetParamKey: hander.valueTargetKey){
            let error = setHanderProperty(targetVC: target, target: targetVC, hander: hander)
            if error.count > errorCount {
                WisdomRouterManager.showError(error: error)
            }
        }else{
            WisdomRouterManager.showError(error: hander.valueTargetKey+"\nHander查找失败\n请检查代码")
        }
        return target
    }

    /** router 参数和闭包 */
    func router(targetVC: String, param: WisdomRouterParam, hander: WisdomRouterHander) -> UIViewController {
        if vcClassValue[targetVC] == nil {
            WisdomRouterManager.showError(error: targetVC+"\n未注册\n请检查代码")
            return UIViewController()
        }
        guard let vcClassType = vcClassValue[targetVC]!.vcClassType else {
            return UIViewController()
        }
        var errorStr = ""
        let target = vcClassType.init()
        if WisdomRouterManager.hasPropertyList(targetClass: vcClassType, targetParamKey: hander.valueTargetKey) {
            errorStr = setHanderProperty(targetVC: target, target: targetVC, hander: hander)
        }else{
            errorStr = hander.valueTargetKey+"\nHander查找失败\n请检查代码\n"
        }
        
        if WisdomRouterManager.hasPropertyList(targetClass: vcClassType, targetParamKey: param.valueTargetKey) {
            if param.valueClass == WisdomRouterModel.self {
                errorStr = errorStr + " \n" + setPropertyList(targetVC: targetVC, param: param, target: target)
            }else if param.valueClass == WisdomRouterModelList.self {
                errorStr = errorStr + " \n" + setListPropertyList(targetVC: targetVC, param: param, target: target)
            }else{
                target.setValue(param.value, forKey: param.valueTargetKey)
            }
        }else{
            errorStr = errorStr + " \n" + param.valueTargetKey+"\n属性查找失败\n请检查代码"
        }
        if errorStr.count > errorCount {
            WisdomRouterManager.showError(error: errorStr)
        }
        return target
    }

    /** router 参数集合和闭包集合 */
    func router(targetVC: String, params: [WisdomRouterParam], handers: [WisdomRouterHander]) -> UIViewController {
        if vcClassValue[targetVC] == nil {
            WisdomRouterManager.showError(error: targetVC+"\n未注册\n请检查代码")
            return UIViewController()
        }
        guard let vcClassType = vcClassValue[targetVC]!.vcClassType else {
            return UIViewController()
        }
        var errorStr = ""
        let target = vcClassType.init()
        for hander in handers {
            if WisdomRouterManager.hasPropertyList(targetClass: vcClassType, targetParamKey: hander.valueTargetKey) {
                errorStr = setHanderProperty(targetVC: target, target: targetVC, hander: hander)
            }else{
                errorStr = hander.valueTargetKey+"\nHander查找失败\n请检查代码\n"
            }
        }
        
        for param in params {
            if WisdomRouterManager.hasPropertyList(targetClass: vcClassType, targetParamKey: param.valueTargetKey) {
                if param.valueClass == WisdomRouterModel.self {
                    errorStr = errorStr + " \n" + setPropertyList(targetVC: targetVC, param: param, target: target)
                }else if param.valueClass == WisdomRouterModelList.self {
                    errorStr = errorStr + " \n" + setListPropertyList(targetVC: targetVC, param: param, target: target)
                }else{
                    target.setValue(param.value, forKey: param.valueTargetKey)
                }
            }else{
                errorStr = errorStr  + param.valueTargetKey+"\n属性查找失败\n请检查代码"
            }
        }

        if errorStr.count > errorCount {
            WisdomRouterManager.showError(error: errorStr)
        }
        return target
    }

    /// Hander属性赋值
    private func setHanderProperty(targetVC: UIViewController, target: String,hander: WisdomRouterHander) -> (String) {
        let registerInfo = vcClassValue[target]!
        for handerInfo in registerInfo.handerList {
            if handerInfo.handerName == hander.valueTargetKey {
                handerInfo.handerValue(hander.value!,targetVC)
                return ("")
            }
        }
        return (hander.valueTargetKey+"\nHander未注册\n请检查代码\n")
    }

    /// model属性赋值
    private func setPropertyList(targetVC: String, param: WisdomRouterParam, target: UIViewController)->String{
        let registerInfo = vcClassValue[targetVC]!
        for modelInfo in registerInfo.modelList {
            if modelInfo.modelName == param.valueTargetKey {
                if let modelClass = modelInfo.modelClass! as? WisdomRouterModel.Type {
                    let model = modelClass.init()
                    let classStr = NSStringFromClass(model.classForCoder)
                    let propertyList = modelPropertyList[classStr] ?? []
                    
                    for property in propertyList {
                        let value = param.keyValue.first![property.name]
                        model.setValue(value, forKey: property.name)
                    }
                    target.setValue(model, forKey: modelInfo.modelName)
                    return ""
                }
            }
        }
        return param.valueTargetKey+"\n属性类未注册\n请检查代码\n"
    }

    /// modelList属性赋值
    private func setListPropertyList(targetVC: String, param: WisdomRouterParam, target: UIViewController)->String{
        let registerInfo = vcClassValue[targetVC]!
        for modelInfo in registerInfo.modelList {
            if modelInfo.modelName == param.valueTargetKey {
                
                if let modelClass = modelInfo.modelClass! as? WisdomRouterModel.Type {
                    let classStr = NSStringFromClass(modelClass)
                    let propertyList = modelPropertyList[classStr] ?? []
                    var modelList: [WisdomRouterModel] = []
                    
                    for keyValue in param.keyValue {
                        let model = modelClass.init()
                        
                        for property in propertyList {
                            let value = keyValue[property.name]
                            model.setValue(value, forKey: property.name)
                        }
                        modelList.append(model)
                    }
                    target.setValue(modelList, forKey: modelInfo.modelName)
                    return ""
                }
            }
        }
        return param.valueTargetKey+"\n属性类未注册\n请检查代码\n"
    }
    
    class func hasPropertyList(targetClass: AnyClass, targetParamKey: String) -> Bool {
        var count: UInt32 = 0
        let list = class_copyPropertyList(targetClass, &count)
        
        for i in 0..<Int(count) {
            let pty = list?[i]
            let cName = property_getName(pty!)
            let name = String(utf8String: cName)
            if name == targetParamKey{
                let _ = WisdomRouterManager.getTypeOf(property: pty!)
                free(list)
                return true
            }
        }
        free(list)
        return false
    }
    
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
    
    class func showError(error: String){
        let label = UILabel()
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = error
        label.sizeToFit()
        label.textColor = UIColor.red
        UIApplication.shared.keyWindow?.addSubview(label)
        label.center = UIApplication.shared.keyWindow!.center
        
        DispatchQueue.main.asyncAfter(deadline: .now()+8, execute:{
            label.removeFromSuperview()
        })
    }
}
