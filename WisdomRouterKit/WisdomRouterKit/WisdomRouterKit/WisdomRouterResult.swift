//
//  WisdomRouterResult.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/22.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

public class WisdomRouterResult: NSObject {
    
    let vcClass: UIViewController.Type!
    
    let infos: WisdomRouterRegisterInfo!
    
    init(vcClassType: UIViewController.Type, info: WisdomRouterRegisterInfo) {
        vcClass = vcClassType
        infos = info
        super.init()
    }
    
    
    /** 追加注册模型 */
    @discardableResult
    @objc public func register(modelListName: String, modelListClass: WisdomRouterModel.Type) -> WisdomRouterResult{
        return WisdomRouterManager.shared.register(vcClassType: vcClass,
                                                   modelListName: modelListName,
                                                   modelListClass: modelListClass)
    }
    
    
    /** 追加注册Handler  */
    @discardableResult
    @objc public func register(handlerName: String, handler: @escaping RouterRegisterHandler) -> WisdomRouterResult {
        return WisdomRouterManager.shared.register(vcClassType: vcClass,
                                                   handlerName: handlerName,
                                                   handler: handler)
    }
}
