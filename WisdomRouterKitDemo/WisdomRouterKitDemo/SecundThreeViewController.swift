//
//  SecundThreeViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/20.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

@objcMembers class SecundThreeViewController: UIViewController,WisdomRouterRegisterProtocol {
    static func register() {
        WisdomRouterKit.register(vcClassType: self, modelName: "testModel", modelClassType: SecundTestModel.self)
    }
    
    var testModel: SecundTestModel={
        let model = SecundTestModel()
        model.size = CGSize(width: 999, height: 999)
        model.hhhhhhhhhh = "测试时"
        return model
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Model: testModel"
        view.backgroundColor = UIColor.white
        let lab = UILabel()
        view.addSubview(lab)
        lab.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
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
}
