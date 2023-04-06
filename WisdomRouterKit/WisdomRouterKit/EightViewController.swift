//
//  EightViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/25.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

@objcMembers class EightViewController: UIViewController,WisdomRouterRegisterProtocol {

    static func registerRouter() {
        WisdomRouterKit.register(vcClassType: self, handlerName: "closureOne") { (closureOne, vc) in
            let VC = vc as! EightViewController
            VC.closureOne = (closureOne as! ((String) ->())
                
        )}.register(handlerName: "closureTwo") { (closureTwo, vc) in
            let VC = vc as! EightViewController
            VC.closureTwo = (closureTwo as! ((String,CGSize) -> ())
                    
        )}.register(handlerName: "closureThree") { (closureTwo, vc) in
            let VC = vc as! EightViewController
            VC.closureThree = (closureTwo as! ((String, NSInteger) -> (Bool))
                
        )}
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

    
    var closureOne: ((String) ->())?
    
    var closureTwo: ((String,CGSize) -> ())?
    
    var closureThree: ((String, NSInteger) -> (Bool))?
    
    lazy var handerBtnOne: UIButton = {
        let btn = UIButton(frame: CGRect(x: 10, y: UIScreen.main.bounds.height - 250, width: UIScreen.main.bounds.width - 20, height: 35))
        btn.setTitle("Click Hander One", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.addTarget(self, action: #selector(clickHanderOne), for: .touchUpInside)
        return btn
    }()
    
    lazy var handerBtnTwo: UIButton = {
        let btn = UIButton(frame: CGRect(x: 10, y: UIScreen.main.bounds.height - 200, width: UIScreen.main.bounds.width - 20, height: 35))
        btn.setTitle("Click Hander Two", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.addTarget(self, action: #selector(clickHanderTwo), for: .touchUpInside)
        return btn
    }()
    
    lazy var handerBtnThree: UIButton = {
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
        
        let lab = UILabel()
        view.addSubview(lab)
        lab.frame = CGRect(x: 0, y: 0, width: 270, height: 650)
        lab.center.x = view.center.x
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
