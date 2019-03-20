//
//  WisdomRouterRegister.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/15.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

struct WisdomRouterRegister {
    
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
