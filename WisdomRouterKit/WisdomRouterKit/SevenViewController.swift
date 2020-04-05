//
//  SevenViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/22.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

@objcMembers class SevenViewController: UIViewController,WisdomRouterRegisterProtocol {
    static func register() {
        WisdomRouterKit.register(vcClassType: self, handlerName: "closureOne") { (closureOne, vc) in
            let VC = vc as! SevenViewController
            VC.closureOne = (closureOne as! ((String) ->())

        )}.register(handlerName: "closureTwo") { (closureTwo, vc) in
            let VC = vc as! SevenViewController
            VC.closureTwo = (closureTwo as! ((String,CGSize) -> ())

        )}.register(handlerName: "closureThree") { (closureTwo, vc) in
            let VC = vc as! SevenViewController
            VC.closureThree = (closureTwo as! ((String, NSInteger) -> (Bool))
        )}
    }
    
    var closureOne: ((String) ->())?
    
    var closureTwo: ((String,CGSize) -> ())?
    
    var closureThree: ((String, NSInteger) -> (Bool))?
    
    var handerBtnOne: UIButton = {
        let btn = UIButton(frame: CGRect(x: 10, y: UIScreen.main.bounds.height - 270, width: UIScreen.main.bounds.width - 20, height: 35))
        btn.setTitle("Click Hander One", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.addTarget(self, action: #selector(clickHanderOne), for: .touchUpInside)
        return btn
    }()
    
    var handerBtnTwo: UIButton = {
        let btn = UIButton(frame: CGRect(x: 10, y: UIScreen.main.bounds.height - 210, width: UIScreen.main.bounds.width - 20, height: 35))
        btn.setTitle("Click Hander Two", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.addTarget(self, action: #selector(clickHanderTwo), for: .touchUpInside)
        return btn
    }()
    
    var handerBtnThree: UIButton = {
        let btn = UIButton(frame: CGRect(x: 10, y: UIScreen.main.bounds.height - 150, width: UIScreen.main.bounds.width - 20, height: 35))
        btn.setTitle("Click Hander Three", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.addTarget(self, action: #selector(clickHanderThree), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WisdomRouterKit"
        view.backgroundColor = UIColor.white
        view.addSubview(handerBtnOne)
        view.addSubview(handerBtnTwo)
        view.addSubview(handerBtnThree)
    }
    
    @objc func clickHanderOne(){
        if closureOne != nil {
            closureOne!("我是闭包closureOne\n我被调用了")
        }
    }

    @objc func clickHanderTwo(){
        if closureTwo != nil {
            closureTwo!("我是闭包closureTwo\n我被调用了",CGSize(width: 77, height: 77))
        }
    }
    
    @objc func clickHanderThree(){
        if closureThree != nil {
            let _ = closureThree!("我是闭包closureThree\n我被调用了",999)
        }
    }
}
