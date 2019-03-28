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
        WisdomRouterKit.register(vcClassType: self, modelName: "testModel", modelClassType: SecundTestModel.self).register(modelName: "threeTestModel", modelClassType: ThreeTestModel.self)
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
        title = "WisdomRouterKit"
        view.backgroundColor = UIColor.white
        let lab = UILabel()
        view.addSubview(lab)
        lab.frame = CGRect(x: 0, y: 0, width: 250, height: 500)
        lab.center = view.center
        lab.textAlignment = .center
        lab.numberOfLines = 0
        lab.backgroundColor = UIColor(white: 0.5, alpha: 0.7)
        
        var text = "WisdomRouterKit\nFunc:\n \n"
        text = text + "参数一name99:\n"+(name99 ?? "nil")+"\n   \n参数二：\n"+"testModel属性如下:  \n"
        
        var propertyList = WisdomRouterManager.propertyList(targetClass: SecundTestModel.self)
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
            }else if str.count == 0{
                str = "nil"
            }
            text = text + key.name + ": " + str + "\n"
        }
        
        text = text + "\n参数三：\n"+"threeTestModel属性如下:  \n"
        propertyList = WisdomRouterManager.propertyList(targetClass: ThreeTestModel.self)
        for key in propertyList {
            let res = threeTestModel.value(forKey: key.name)
            var str = ""
            if let resStr = res as? CGSize{
                str = String.init(format:"%.2f,%.2f",resStr.width,resStr.height)
            }else if let resStr = res as? Bool{
                str = resStr ? "true":"fales"
            }else if let resStr = res as? NSInteger{
                str = String(resStr)
            }else if let resStr = res as? String{
                str = resStr
            }else if str.count == 0{
                str = "nil"
            }
            text = text + key.name + ": " + str + "\n"
        }
        lab.text = text
    }
}
