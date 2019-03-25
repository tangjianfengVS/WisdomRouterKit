//
//  FiveViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/20.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

@objcMembers class FiveViewController: UIViewController, WisdomRouterRegisterProtocol {
    static func register() {
//        WisdomRouterKit.register(vcClassType: self,
//                                   modelName: "testModel",
//                              modelClassType: SecundTestModel.self,
//                                  handerName: "hander") {(hander: Any, vc: UIViewController?) -> UIViewController in
//            let VC = FiveViewController()
//            VC.hander = (hander as! ((String,NSInteger) -> Bool))
//            return VC
//        }
    }
    
    var testModel: SecundTestModel = SecundTestModel()
    
    var hander: ((String,NSInteger)->(Bool))?
    
    var handerBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Click Hander", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.addTarget(self, action: #selector(clickHander), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "属性加Hander"
        view.backgroundColor = UIColor.white
        view.addSubview(handerBtn)
        handerBtn.frame = CGRect(x: 100, y: UIScreen.main.bounds.height - 200,
                                 width: UIScreen.main.bounds.width - 200, height: 40)
        
        let lab = UILabel()
        view.addSubview(lab)
        lab.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        lab.center = view.center
        lab.textAlignment = .center
        lab.numberOfLines = 0
        var text: String = "testModel:  \n"
        
        let propertyList = WisdomRouterManager.propertyList(targetClass: SecundTestModel.self)
        for key in propertyList {
            let res = testModel.value(forKey: key)
            var str = ""
            if let resStr = res as? CGSize{
                str = String.init(format:"%.2f,%.2f",resStr.width,resStr.height)
            }else if let resStr = res as? Bool{
                str = resStr ? "True":"Fales"
            }else if let resStr = res as? NSInteger{
                str = String(resStr)
            }else if let resStr = res as? String{
                str = resStr
            }
            text = text + key + ": " + str + "\n"
        }
        lab.text = text
    }
    
    @objc private func clickHander() {
        if hander != nil {
            let res = hander!("我是回调\n数据",70)
            print(res)
        }
    }
}
