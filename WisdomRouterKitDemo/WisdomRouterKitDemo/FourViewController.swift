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
    
    var handerBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Click Hander", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.addTarget(self, action: #selector(clickHander), for: .touchUpInside)
        return btn
    }()
    
    static func register() {
        WisdomRouterKit.register(vcClassType: self, handerName: "closure") { (hander: Any) -> (UIViewController) in
            let VC = FourViewController()
            VC.closure = (hander as! ((String) -> Void))
            return VC
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(handerBtn)
        handerBtn.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        handerBtn.center = view.center
    }
    
    @objc private func clickHander() {
        if closure != nil {
            closure!("我是回调\n数据")
        }
    }
}


