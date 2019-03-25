//
//  SixViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/22.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

@objcMembers class SixViewController: UIViewController, WisdomRouterRegisterProtocol {
    static func register() {
//        WisdomRouterKit.register(vcClassType: self, modelName: "testModel", modelClassType: SecundTestModel.self).register(modelName: "threeTestModel", modelClassType: ThreeTestModel.self)
    }
    
    /// 参数一
    var name99: String?
    
    /// 参数二
    var testModel: SecundTestModel={
        let model = SecundTestModel()
        model.size = CGSize(width: 999, height: 999)
        model.hhhhhhhhhh = "测试时"
        return model
    }()
    
    /// 参数三
    var threeTestModel: ThreeTestModel={
        let model = ThreeTestModel()
        model.size = CGSize(width: 999, height: 999)
        return model
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "多参数Router"
        view.backgroundColor = UIColor.white
        let lab = UILabel()
        view.addSubview(lab)
        lab.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
        lab.center = view.center
        lab.textAlignment = .center
        lab.numberOfLines = 0
        var text: String = "参数一:\nname99：\n"+(name99 ?? " ")+"\n   \n参数二：\n"+"testModel:  \n"
        
        var propertyList = WisdomRouterManager.propertyList(targetClass: SecundTestModel.self)
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
        
        text = text + "\n参数三：\n"+"threeTestModel:  \n"
        propertyList = WisdomRouterManager.propertyList(targetClass: ThreeTestModel.self)
        for key in propertyList {
            let res = threeTestModel.value(forKey: key)
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
