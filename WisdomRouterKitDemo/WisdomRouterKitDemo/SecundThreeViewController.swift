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
    
    var testModel: SecundTestModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Model: testModel"
        view.backgroundColor = UIColor.white
        let lab = UILabel()
        view.addSubview(lab)
        lab.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
        lab.center = view.center
        lab.textAlignment = .center
        lab.numberOfLines = 0
        var text: String = "testModel:  \n"
        
        let propertyList = WisdomRouterKit.propertyList(targetClass: SecundTestModel.self)
        for key in propertyList {
            let res = testModel?.value(forKey: key)
            var str = ""
            if let resStr = res as? String{
                str = resStr
            }
            text = text + key + ": " + str + "\n"
        }
        lab.text = text
    }
}
