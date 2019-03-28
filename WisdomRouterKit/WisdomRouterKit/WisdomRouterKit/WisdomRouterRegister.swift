//
//  WisdomRouterRegister.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/15.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

public typealias WisdomRouterClosure = (Any,UIViewController) -> ()

struct WisdomRouterRegisterInfo {
    private(set) var vcClassType: UIViewController.Type!
    private(set) var modelList: [WisdomRouterRegisterModel]=[]
    private(set) var handerList: [WisdomRouterRegisterHander]=[]
    
    init(vcClassType: UIViewController.Type) {
        self.vcClassType = vcClassType
    }
    
    mutating func add(model: WisdomRouterRegisterModel) {
        self.modelList.append(model)
    }
    
    mutating func add(hander: WisdomRouterRegisterHander) {
        self.handerList.append(hander)
    }
}

struct WisdomRouterRegisterModel {
    private(set) var modelClass: AnyClass?
    private(set) var modelName: String=""

    init(modelName: String, modelClass: AnyClass) {
        self.modelName = modelName
        self.modelClass = modelClass
    }
    
    mutating func updateModelClass(modelClass: AnyClass) {
        self.modelClass = modelClass
    }
}

struct WisdomRouterRegisterHander{
    private(set) var handerValue: WisdomRouterClosure!
    private(set) var handerName: String!
    
    init(handerName:String, handerValue: @escaping WisdomRouterClosure) {
        self.handerName = handerName
        self.handerValue = handerValue
    }
    
    mutating func updateHanderValue(handerValue: @escaping WisdomRouterClosure){
        self.handerValue = handerValue
    }
}


struct WisdomRouterRegisterProperty{
    private(set) var nameType: String!
    private(set) var name: String!
    
    init(name:String, nameType:String ) {
        self.name = name
        self.nameType = nameType
    }
}
