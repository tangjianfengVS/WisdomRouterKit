//
//  WisdomRouterProtocol.swift
//  WisdomRouterKit
//
//  Created by jianfeng on 2019/10/8.
//  Copyright © 2019 All over the sky star. All rights reserved.
//

import UIKit


@objc public protocol WisdomRouterRegisterProtocol {
    
    //MARK: - Register Protocol
    static func register()
}


@objc public protocol WisdomRouterShareProtocol{
    
    //MARK: - Router Shared Protocol
    func routerShared() -> WisdomRouterModel;
}

