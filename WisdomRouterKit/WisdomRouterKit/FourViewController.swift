//
//  FourViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/18.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

@objcMembers class FourViewController: UIViewController,WisdomRouterRegisterProtocol {
    
    var closure: ((String) -> Void)?
    
    static func register() {
        WisdomRouterKit.register(vcClassType: self, handlerName: "closure") { (handler: Any, vc: UIViewController) in
            let VC = vc as! FourViewController
            VC.closure = (handler as! ((String) -> Void))
        }
    }
    
    var handerBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Click Hander", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.addTarget(self, action: #selector(clickHander), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WisdomRouterKit"
        view.backgroundColor = UIColor.white
        view.addSubview(handerBtn)
        handerBtn.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        handerBtn.center = view.center
    }
    
    @objc private func clickHander() {
        if closure != nil {
            closure!("closure \n闭包被调用了!")
        }
    }
}


