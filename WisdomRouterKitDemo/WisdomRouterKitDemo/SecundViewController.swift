//
//  SecundViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/14.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

class SecundViewController: UIViewController, WisdomRouterRegisterProtocol {
    
    static func register() {
        WisdomRouterKit.register(vcClassType: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "无参数无回调"
        view.backgroundColor = UIColor.white
    }
}
