//
//  WisdomRouterResult.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/22.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

public class WisdomRouterResult: NSObject {
    
    let vcClassTypes: UIViewController.Type!
    
    let infos: WisdomRouterRegisterInfo!
    
    init(vcClassType: UIViewController.Type, info: WisdomRouterRegisterInfo) {
        vcClassTypes = vcClassType
        infos = info
        super.init()
    }
    
    /** 追加注册模型 */
    @discardableResult
    @objc public func register(modelName: String, modelClassType: WisdomRouterModel.Type) -> WisdomRouterResult{
        return WisdomRouterManager.shared.register(vcClassType: vcClassTypes, modelName: modelName, modelClassType: modelClassType)
    }
    
    /** 追加注册Hander */
    @discardableResult
    @objc public func register(handerName: String, hander: @escaping WisdomRouterClosure) -> WisdomRouterResult{
        return WisdomRouterManager.shared.register(vcClassType: vcClassTypes, handerName: handerName, hander: hander)
    }
}
