//
//  SecundViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/14.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

@objcMembers class SecundViewController: UIViewController, WisdomRouterRegisterProtocol {
    var name: String?
    
    var testModel: SecundTestModel?// = SecundTestModel()
    
    static func register() {
        //WisdomRouterKit.register(classType: self)
        WisdomRouterKit.register(vcClassType: self, modeName: "testModel", modelClassType: SecundTestModel.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        
        let lab = UILabel()
        view.addSubview(lab)
        lab.frame = CGRect(x: 0, y: 0, width: 100, height: 500)
        lab.center = view.center
        
        lab.textColor = UIColor.white
        if testModel != nil{
            lab.text = (testModel!.title ?? " ") + " + " + (testModel!.des ?? " ")
        }
    }
}
