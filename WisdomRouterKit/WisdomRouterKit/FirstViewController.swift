//
//  FirstViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/20.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    var testModel: TestModel = TestModel()
    
    var testModelList: [TestModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WisdomRouterKit"
        navigationController?.navigationBar.isTranslucent = false
    }
    
    
    
    ///###########################################################################
    ///##                                                                       ##
    ///##                              基本功能                                   ##
    ///##                                                                       ##
    ///###########################################################################
    
    /// 无参数，无闭包
    @IBAction func clickPushNoDateBtn(_ sender: UIButton) {        
        WisdomRouterKit.router(targetVC: "OneViewController",
                               project: "WisdomRouterKit",
                               routerHandler: { (VC) in
            navigationController?.pushViewController(VC, animated: true)
        }) { (error) in
            
        }
    }
    
    
    /// 有参数，无闭包
    @IBAction func clickPushHasDateBtn(_ sender: UIButton) {
        WisdomRouterKit.router(targetVC: "SecundViewController",
                               project: "WisdomRouterKit",
                               param: WisdomRouterParam.create(key: "testSize", double: 99.99),
                               routerResultHandler: { (VC, warning) in
            navigationController?.pushViewController(VC, animated: true)
        }) { (error) in
            
        }
    }
    
    
    /// 参数 testModel
    @IBAction func clickPushHasDateModelBtn(_ sender: UIButton) {
        testModel.name = "名字:小米"
        testModel.title = "文字:SS"
        testModel.des = "描述:MM"
        testModel.res = true
        testModel.size = CGSize(width: 33, height: 33)
        testModel.ages = 30
        WisdomRouterKit.router(targetVC: "SecundThreeViewController",
                               project: "WisdomRouterKit",
                               param: WisdomRouterParam.create(key: "testModel",model: testModel),
                               routerResultHandler: { (VC, warning) in
            navigationController?.pushViewController(VC, animated: true)
        }) { (error) in
            
        }
    }
    
    
    /// 参数 testModelList ------------------------------------------------------
    @IBAction func clickPushHasDateModelListBtn(_ sender: UIButton) {
        for i in 0...500 {
            let model = TestModel()
            model.name = "名字-" + String(i)
            model.title = "文字-" + String(i)
            model.des = "描述-" + String(i)
            model.res = true
            model.size = CGSize(width: i, height: i)
            testModelList.append(model)
        }
        WisdomRouterKit.router(targetVC: "ThreeViewController",
                               project: "WisdomRouterKit",
                               param: WisdomRouterParam.create(key: "testModelList", modelList: testModelList),
                               routerResultHandler: { (VC, warning) in
            navigationController?.pushViewController(VC, animated: true)
        }) { (error) in
            
        }
    }
    
    
    /// 闭包 ---------------------------------------------------------
    @IBAction func clickPushWaitHanderBtn(_ sender: UIButton) {
        let handler = WisdomRouterHandler.create(key: "closure", handler: {(name: String) in
             let label = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
             label.layer.cornerRadius = 8
             label.layer.masksToBounds = true
             label.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
             label.textAlignment = .center
             label.numberOfLines = 0
             label.center = UIApplication.shared.keyWindow!.center
             label.text = name
             UIApplication.shared.keyWindow?.addSubview(label)

             DispatchQueue.main.asyncAfter(deadline: .now()+2.5, execute:{
                label.removeFromSuperview()
             })
        })

        WisdomRouterKit.router(targetVC: "FourViewController",
                               project: "WisdomRouterKit",
                               handler: handler,
                               routerResultHandler: { (VC, warning) in
            navigationController?.pushViewController(VC, animated: true)
        }) { (error) in
            
        }
    }
    
    

    ///###########################################################################
    ///##                                                                       ##
    ///##                              功能进阶                                   ##
    ///##                                                                       ##
    ///###########################################################################
    
    /// 一个参数和一个闭包
    @IBAction func clickPushModelAndeWaitHanderBtn(_ sender: UIButton) {
        testModel.name = "名字--"
        testModel.title = "文字--"
        testModel.des = "描述--"
        testModel.res = true
        testModel.size = CGSize(width: 100, height: 100)
        testModel.ages = 30
        
        let param = WisdomRouterParam.create(key: "testModel",model: testModel)
        let handler = WisdomRouterHandler.create(key: "hander", handler: {(name: String, count: NSInteger) -> (Bool) in
            let label = UILabel(frame: CGRect(x: 0, y: 100, width: 125, height: 130))
            label.layer.cornerRadius = 8
            label.layer.masksToBounds = true
            label.backgroundColor = UIColor(white: 0.5, alpha: 0.9)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.center = UIApplication.shared.keyWindow!.center
            label.text = name+"\n"+"和\n" + String(count) + "\n返回值是:true"
            UIApplication.shared.keyWindow?.addSubview(label)

            DispatchQueue.main.asyncAfter(deadline: .now()+2.5, execute:{
                label.removeFromSuperview()
            })
            return true
        })
        WisdomRouterKit.router(targetVC: "FiveViewController",
                               project: "WisdomRouterKit",
                               param: param,
                               handler: handler,
                               routerResultHandler: { (VC, warning) in
            navigationController?.pushViewController(VC, animated: true)
        }) { (error) in
            
        }
    }
    
    
    /// 多参数集合
    @IBAction func clickPushMuchModelBtn(_ sender: UIButton) {
        let param1 = WisdomRouterParam.create(key: "name99", string: "我是参数一：name99")
        
        testModel.name = "名字"
        testModel.title = "文字"
        testModel.des = "描述"
        testModel.res = true
        testModel.size = CGSize(width: 33, height: 33)
        testModel.ages = 30
        let param2 = WisdomRouterParam.create(key: "testModel", model: testModel)
        
        testModel.name = "名字---"
        testModel.title = "文字--"
        testModel.des = "描述---"
        testModel.res = true
        testModel.size = CGSize(width: 777, height: 777)
        testModel.ages = 777
        let param3 = WisdomRouterParam.create(key: "threeTestModel", model: testModel)
        
        WisdomRouterKit.router(targetVC: "SixViewController",
                               project: "WisdomRouterKit",
                               params: [param1,param2,param3],
                               routerResultHandler: { (VC, warning) in
            navigationController?.pushViewController(VC, animated: true)
        }) { (error) in
            
        }
    }
    
    
    /// 多闭包集合
    @IBAction func clickPushMuchHanderBtn(_ sender: UIButton) {
        let hander1 = WisdomRouterHandler.create(key: "closureOne", handler: {(name: String) in
            let label = UILabel(frame: CGRect(x: 0, y: 100, width: 125, height: 130))
            label.layer.cornerRadius = 8
            label.layer.masksToBounds = true
            label.backgroundColor = UIColor(white: 0.5, alpha: 0.9)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.center = UIApplication.shared.keyWindow!.center
            label.text = name
            UIApplication.shared.keyWindow?.addSubview(label)

            DispatchQueue.main.asyncAfter(deadline: .now()+2.5, execute:{
                label.removeFromSuperview()
            })
        })

        let hander2 = WisdomRouterHandler.create(key: "closureTwo", handler: {(name: String, size: CGSize) in
            let label = UILabel(frame: CGRect(x: 0, y: 100, width: 125, height: 130))
            label.layer.cornerRadius = 8
            label.layer.masksToBounds = true
            label.backgroundColor = UIColor(white: 0.5, alpha: 0.9)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.center = UIApplication.shared.keyWindow!.center
            label.text = name+"\n" + String.init(format:"%.2f,%.2f",size.width,size.height)
            UIApplication.shared.keyWindow?.addSubview(label)

            DispatchQueue.main.asyncAfter(deadline: .now()+2.5, execute:{
                label.removeFromSuperview()
            })
        })

        let hander3 = WisdomRouterHandler.create(key: "closureThree", handler: {(name: String, count: NSInteger) -> (Bool) in
            let label = UILabel(frame: CGRect(x: 0, y: 100, width: 125, height: 130))
            label.layer.cornerRadius = 8
            label.layer.masksToBounds = true
            label.backgroundColor = UIColor(white: 0.5, alpha: 0.9)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.center = UIApplication.shared.keyWindow!.center
            label.text = name+"\n"+"和\n" + String(count) + "\n返回值是:true"
            UIApplication.shared.keyWindow?.addSubview(label)

            DispatchQueue.main.asyncAfter(deadline: .now()+2.5, execute:{
                label.removeFromSuperview()
            })
            return true
        })
        
        WisdomRouterKit.router(targetVC: "SevenViewController",
                               project: "WisdomRouterKit",
                               handlers: [hander1,hander2,hander3],
                               routerResultHandler: { (VC, warning) in
            navigationController?.pushViewController(VC, animated: true)
        }) { (error) in
            
        }
    }
    
    
    /// 多参数和闭包集合
    @IBAction func clickPushMuchHanderAndMuchDataBtn(_ sender: UIButton) {
        let param1 = WisdomRouterParam.create(key: "name99", string: "我是参数一：name99")
        
        testModel.name = "名字"
        testModel.title = "文字"
        testModel.des = "描述"
        testModel.res = true
        testModel.size = CGSize(width: 33, height: 33)
        testModel.ages = 30
        let param2 = WisdomRouterParam.create(key: "testModel", model: testModel)
        
        testModel.name = "名字---"
        testModel.title = "文字--"
        testModel.des = "描述---"
        testModel.res = true
        testModel.size = CGSize(width: 777, height: 777)
        testModel.ages = 777
        let param3 = WisdomRouterParam.create(key: "threeTestModel", model: testModel)

        let hander1 = WisdomRouterHandler.create(key: "closureOne", handler: {(name: String) in
            let label = UILabel(frame: CGRect(x: 0, y: 100, width: 125, height: 130))
            label.layer.cornerRadius = 8
            label.layer.masksToBounds = true
            label.backgroundColor = UIColor(white: 0.5, alpha: 0.9)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.center = UIApplication.shared.keyWindow!.center
            label.text = name
            UIApplication.shared.keyWindow?.addSubview(label)

            DispatchQueue.main.asyncAfter(deadline: .now()+2.5, execute:{
                label.removeFromSuperview()
            })
        })

        let hander2 = WisdomRouterHandler.create(key: "closureTwo", handler: {(name: String, size: CGSize) in
            let label = UILabel(frame: CGRect(x: 0, y: 100, width: 125, height: 130))
            label.layer.cornerRadius = 8
            label.layer.masksToBounds = true
            label.backgroundColor = UIColor(white: 0.5, alpha: 0.9)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.center = UIApplication.shared.keyWindow!.center
            label.text = name+"\n" + String.init(format:"%.2f,%.2f",size.width,size.height)
            UIApplication.shared.keyWindow?.addSubview(label)

            DispatchQueue.main.asyncAfter(deadline: .now()+2.5, execute:{
                label.removeFromSuperview()
            })
        })

        let hander3 = WisdomRouterHandler.create(key: "closureThree", handler: {(name: String, count: NSInteger) -> (Bool) in
            let label = UILabel(frame: CGRect(x: 0, y: 100, width: 125, height: 130))
            label.layer.cornerRadius = 8
            label.layer.masksToBounds = true
            label.backgroundColor = UIColor(white: 0.5, alpha: 0.9)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.center = UIApplication.shared.keyWindow!.center
            label.text = name+"\n"+"和\n" + String(count) + "\n返回值是:true"
            UIApplication.shared.keyWindow?.addSubview(label)

            DispatchQueue.main.asyncAfter(deadline: .now()+2.5, execute:{
                label.removeFromSuperview()
            })
            return true
        })
        WisdomRouterKit.router(targetVC: "EightViewController",
                               project: "WisdomRouterKit",
                               params: [param1,param2,param3],
                               handlers: [hander1,hander2,hander3],
                               routerResultHandler: { (VC, warning) in
            navigationController?.pushViewController(VC, animated: true)
        }) { (error) in
            
        }
    }
    
    
    
    ///###########################################################################
    ///##                                                                       ##
    ///##                          功能进阶 -获取全局单列 Model                     ##
    ///##                                                                       ##
    ///###########################################################################
    
    /// 获取全局单列 Model
    @IBAction func clickSherdDataBtn(_ sender: UIButton) {
        
        func show(sheraModel: TestModel){
            var text = "单列数据: \nsheraModel属性如下:  \n"
            let propertyList = WisdomRouterManager.propertyList(targetClass: TestModel.self)
            for key in propertyList {
                let res = sheraModel.value(forKey: key.name)
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
            
            let label = UILabel(frame: CGRect(x: 0, y: 100, width: 250, height: 300))
            label.layer.cornerRadius = 8
            label.layer.masksToBounds = true
            label.backgroundColor = UIColor(white: 0.5, alpha: 0.9)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.center = UIApplication.shared.keyWindow!.center
            label.text = text
            UIApplication.shared.keyWindow?.addSubview(label)

            DispatchQueue.main.asyncAfter(deadline: .now()+2.5, execute:{
                label.removeFromSuperview()
            })
        }
        
        WisdomRouterKit.getShared(sharedClassName: "TestShareModel",
                                  project: "WisdomRouterKit",
                                  substituteModelType: TestModel.self,
                                  routerSharedHandler: { (model, warning) in
            show(sheraModel: model as! TestModel)
        }) { (error) in
        
        }
    }
}
