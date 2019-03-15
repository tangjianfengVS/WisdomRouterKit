//
//  WisdomRouterRegister.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/15.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

class WisdomRouterRegister: NSObject {
    
    private(set) var modelClass: AnyClass?
    private(set) var modeName: String=""
    

    init(modeName: String, modelClass: AnyClass) {
        self.modeName = modeName
        self.modelClass = modelClass
    }
    
    func updateModelClass(modelClass: AnyClass) {
        self.modelClass = modelClass
    }
}
