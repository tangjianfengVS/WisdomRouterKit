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
        WisdomRouterKit.register(vcClassType: self, modelName: "testModel", modelClassType: SecundTestModel.self).register(handerName: "hander") { (hander, vc) in
            let VC = vc as! FiveViewController
            VC.hander = (hander as! (String,NSInteger)->(Bool))
        }
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
        title = "WisdomRouterKit"
        view.backgroundColor = UIColor.white
        view.addSubview(handerBtn)
        handerBtn.frame = CGRect(x: 100, y: UIScreen.main.bounds.height - 200,
                                 width: UIScreen.main.bounds.width - 200, height: 40)
        
        let lab = UILabel()
        view.addSubview(lab)
        lab.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
        lab.center = view.center
        lab.textAlignment = .center
        lab.numberOfLines = 0
        lab.backgroundColor = UIColor(white: 0.5, alpha: 0.7)
        var text: String = "WisdomRouterKit\nFunc:\ntestModel属性如下：\n"
        
        let propertyList = WisdomRouterManager.propertyList(targetClass: SecundTestModel.self)
        for key in propertyList {
            let res = testModel.value(forKey: key.name)
            var str = ""
            if let resStr = res as? CGSize{
                str = String.init(format:"%.2f,%.2f",resStr.width,resStr.height)
            }else if let resStr = res as? Bool{
                str = resStr ? "true":"fales"
            }else if let resStr = res as? NSInteger{
                str = String(resStr)
            }else if let resStr = res as? String{
                str = resStr
            }else if res == nil{
                str = "nil"
            }
            text = text + "\n" + key.name + ": " + str
        }
        lab.text = text
    }
    
    @objc private func clickHander() {
        if hander != nil {
            let _ = hander!("我是回调\n数据",70)
        }
    }
}
