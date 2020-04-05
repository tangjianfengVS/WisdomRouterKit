//
//  WisdomRouterKit.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/14.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit


public protocol WisdomRouterRegisterProtocol {
    //MARK: - Register Protocol
    static func register()
}


public class WisdomRouterKit {
    
    //MARK: - register VC's 属性数组元素类型, 元素类型需要继承 WisdomRouterModel
    // - parame targetVC:        target VC's class name
    // - parame modelListName:   target VC's array name
    // - parame modelListClass:  array's Element class
    @discardableResult
    @objc public class func register(vcClassType: UIViewController.Type,
                                     modelListName: String,
                                     modelListClass: WisdomRouterModel.Type) -> WisdomRouterResult{
        
        return WisdomRouterManager.shared.register(vcClassType: vcClassType,
                                                   modelListName: modelListName,
                                                   modelListClass: modelListClass)
    }
    
    
    //MARK: - register VC's 属性闭包, 在handler中确认转换类型
    // - parame targetVC:        target VC's class name
    // - parame handlerName:     target VC's handler name
    // - parame handler:         target VC's handler
    @discardableResult
    @objc public class func register(vcClassType: UIViewController.Type,
                                     handlerName: String,
                                     handler: @escaping RouterRegisterHandler) -> WisdomRouterResult{
        
        return WisdomRouterManager.shared.register(vcClassType: vcClassType,
                                                   handlerName: handlerName,
                                                   handler: handler)
    }
    
    
    //MARK: - router 无参数，无Handler
    // - parame targetVC:             target VC's class name
    // - parame project:              target VC's class of project
    // - parame routerHandler:        router handler, succeed
    // - parame routerErrorHandler:   router handler, error
    @objc public class func router(targetVC: String,
                                   project: String,
                                   routerHandler: RouterHandler,
                                   routerErrorHandler: RouterErrorHandler) {
        
        WisdomRouterManager.router(targetVC: targetVC,
                                   project: project,
                                   routerHandler: routerHandler,
                                   routerErrorHandler: routerErrorHandler)
    }
    
    
    //MARK: - router 有参数，无Handler
    // - parame targetVC:             target VC's class name
    // - parame project:              target VC's class of project
    // - parame param:                target VC's property of WisdomRouterParam
    // - parame routerResultHandler:  router result handler, succeed
    // - parame routerErrorHandler:   router handler, error
    @objc public class func router(targetVC: String,
                                   project: String,
                                   param: WisdomRouterParam,
                                   routerResultHandler: RouterResultHandler,
                                   routerErrorHandler: RouterErrorHandler) {
        
        WisdomRouterManager.router(targetVC: targetVC,
                                   project: project,
                                   param: param,
                                   routerResultHandler: routerResultHandler,
                                   routerErrorHandler: routerErrorHandler)
    }
    
    
    //MARK: - router 无参数，有Handler
    // - parame targetVC:             target VC's class name
    // - parame project:              target VC's class of project
    // - parame handler:              target VC's handler of WisdomRouterHandler
    // - parame routerResultHandler:  router result handler, succeed
    // - parame routerErrorHandler:   router handler, error
    @objc public class func router(targetVC: String,
                                   project: String,
                                   handler: WisdomRouterHandler,
                                   routerResultHandler: RouterResultHandler,
                                   routerErrorHandler: RouterErrorHandler) {
        
        WisdomRouterManager.router(targetVC: targetVC,
                                   project: project,
                                   handler: handler,
                                   routerResultHandler: routerResultHandler,
                                   routerErrorHandler: routerErrorHandler)
    }
    
    
    //MARK: - router 有参数，有Handler
    // - parame targetVC:             target VC's class name
    // - parame project:              target VC's class of project
    // - parame param:                target VC's property of WisdomRouterParam
    // - parame handler:              target VC's handler of WisdomRouterHandler
    // - parame routerResultHandler:  router result handler, succeed
    // - parame routerErrorHandler:   router handler, error
    @objc public class func router(targetVC: String,
                                   project: String,
                                   param: WisdomRouterParam,
                                   handler: WisdomRouterHandler,
                                   routerResultHandler: RouterResultHandler,
                                   routerErrorHandler: RouterErrorHandler) {
        
        WisdomRouterManager.router(targetVC: targetVC,
                                   project: project,
                                   param: param,
                                   handler: handler,
                                   routerResultHandler: routerResultHandler,
                                   routerErrorHandler: routerErrorHandler)
    }
    
    
    //MARK: - router 多参数集合，无Handler
    // - parame targetVC:             target VC's class name
    // - parame project:              target VC's class of project
    // - parame params:               target VC's property of WisdomRouterParam array
    // - parame routerResultHandler:  router result handler, succeed
    // - parame routerErrorHandler:   router handler, error
    @objc public class func router(targetVC: String,
                                   project: String,
                                   params: [WisdomRouterParam],
                                   routerResultHandler: RouterResultHandler,
                                   routerErrorHandler: RouterErrorHandler) {
        
        WisdomRouterManager.router(targetVC: targetVC,
                                   project: project,
                                   params: params,
                                   routerResultHandler: routerResultHandler,
                                   routerErrorHandler: routerErrorHandler)
    }
    
    
    //MARK: - router 无参数，多Handler集合
    // - parame targetVC:             target VC's class name
    // - parame project:              target VC's class of project
    // - parame handlers:             target VC's property of WisdomRouterHandler array
    // - parame routerResultHandler:  router result handler, succeed
    // - parame routerErrorHandler:   router handler, error
    @objc public class func router(targetVC: String,
                                   project: String,
                                   handlers: [WisdomRouterHandler],
                                   routerResultHandler: RouterResultHandler,
                                   routerErrorHandler: RouterErrorHandler) {
        
        WisdomRouterManager.router(targetVC: targetVC,
                                   project: project,
                                   handlers: handlers,
                                   routerResultHandler: routerResultHandler,
                                   routerErrorHandler: routerErrorHandler)
    }
    
    
    //MARK: - router 多参数集合，多Handler集合
    // - parame targetVC:             target VC's class name
    // - parame project:              target VC's class of project
    // - parame params:               target VC's property of WisdomRouterParam array
    // - parame handlers:             target VC's property of WisdomRouterHandler array
    // - parame routerResultHandler:  router result handler, succeed
    // - parame routerErrorHandler:   router handler, error
    @objc public class func router(targetVC: String,
                                   project: String,
                                   params: [WisdomRouterParam],
                                   handlers: [WisdomRouterHandler],
                                   routerResultHandler: RouterResultHandler,
                                   routerErrorHandler: RouterErrorHandler) {
        
        WisdomRouterManager.router(targetVC: targetVC,
                                   project: project,
                                   params: params,
                                   handlers: handlers,
                                   routerResultHandler: routerResultHandler,
                                   routerErrorHandler: routerErrorHandler)
    }
    
    
    //MARK: - getShared  获取全局单列 Model
    // - parame sharedClassName:       target shared's class name
    // - parame project:               target shared's class of project
    // - parame substituteClassType:   substitute of shared's class info
    // - parame routerSharedHandler:   router shared handler, succeed
    // - parame routerErrorHandler:    router handler, error
    @objc public class func getShared(sharedClassName: String,
                                      project: String,
                                      substituteModelType: WisdomRouterModel.Type,
                                      routerSharedHandler: RouterSharedHandler,
                                      routerErrorHandler: RouterErrorHandler) {
        
        WisdomRouterManager.routerShared(sharedClassName: sharedClassName,
                                         project: project,
                                         substituteModelType: substituteModelType,
                                         routerSharedHandler: routerSharedHandler,
                                         routerErrorHandler: routerErrorHandler)
    }
}

