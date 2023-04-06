//
//  WisdomRouterProtocol.swift
//  WisdomRouterKit
//
//  Created by jianfeng on 2019/10/8.
//  Copyright © 2019 All over the sky star. All rights reserved.
//

import UIKit


public protocol WisdomRouterRegisterProtocol {
    
    //MARK: - Register Router Protocol
    static func registerRouter()
}


@objc public protocol WisdomRouterShareProtocol{
    
    //MARK: - Router Shared Protocol
    func routerShared() -> WisdomRouterModel;
}

