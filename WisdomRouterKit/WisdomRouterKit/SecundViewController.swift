//
//  SecundTwoViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/20.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

@objcMembers class SecundViewController: UIViewController,WisdomRouterRegisterProtocol {
    static func register() {
//        WisdomRouterKit.register(vcClassType: self)
    }
    
    var testSize: UInt64=1
    
    lazy var label: UILabel = {
        let lab = UILabel()
        lab.text = "WisdomRouterKit\nFunc:\n"
        lab.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        lab.center = self.view.center
        lab.backgroundColor = UIColor(white: 0.5, alpha: 0.7)
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WisdomRouterKit"
        view.backgroundColor = UIColor.white
        view.addSubview(label)
        
//        if testSize > 0 {
//            label.text = label.text! + "Double: \n" + String.init(format:"%.2f",testSize)
//        }else{
//            label.text = label.text! + "Router传参数失败"
//            label.textColor = UIColor.red
//        }
    }
}
