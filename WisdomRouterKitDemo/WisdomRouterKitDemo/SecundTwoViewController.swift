//
//  SecundTwoViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/20.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

@objcMembers class SecundTwoViewController: UIViewController,WisdomRouterRegisterProtocol {
    static func register() {
        WisdomRouterKit.register(vcClassType: self)
    }
    
    var name99: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "参数: name: String"
        view.backgroundColor = UIColor.white
        let lab = UILabel()
        view.addSubview(lab)
        lab.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        lab.center = view.center
        lab.textAlignment = .center
        lab.text = "name:  " + (name99 ?? " ")
    }
}
