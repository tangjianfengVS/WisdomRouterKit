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
    
    /// 无参数，无闭包
    @IBAction func clickPushNoDateBtn(_ sender: UIButton) {
        let VC = WisdomRouterKit.router(targetVC: "OneViewController")
        navigationController?.pushViewController(VC, animated: true)
    }
    
    /// 有参数，无闭包
    @IBAction func clickPushHasDateBtn(_ sender: UIButton) {
        let VC = WisdomRouterKit.router(targetVC: "SecundViewController",
                                           param: WisdomRouterParam.creat(key: "testSize", param: CGSize(width: 99, height: 99)))
        navigationController?.pushViewController(VC, animated: true)
    }
    
    /// 参数 testModel
    @IBAction func clickPushHasDateModelBtn(_ sender: UIButton) {
        testModel.name = "名字"
        testModel.title = "文字"
        testModel.des = "描述"
        testModel.res = true
        testModel.size = CGSize(width: 33, height: 33)
        testModel.ages = 30
        let VC = WisdomRouterKit.router(targetVC: "SecundThreeViewController",
                                           param: WisdomRouterParam.creat(key: "testModel",param: testModel))
        navigationController?.pushViewController(VC, animated: true)
    }
    
    /// 参数 testModelList
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
        let VC = WisdomRouterKit.router(targetVC: "ThreeViewController",
                                           param: WisdomRouterParam.creat(key: "testModelList", param: testModelList))
        navigationController?.pushViewController(VC, animated: true)
    }
    
    /// 闭包
    @IBAction func clickPushWaitHanderBtn(_ sender: UIButton) {
        let hander = WisdomRouterHander.creat(key: "closure", hander: {(name: String) in
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
        let VC = WisdomRouterKit.router(targetVC: "FourViewController",hander: hander)
        navigationController?.pushViewController(VC, animated: true)
    }
    
    ///-----------------功能进阶------------------------
    /// 一个参数和一个闭包
    @IBAction func clickPushModelAndeWaitHanderBtn(_ sender: UIButton) {
        testModel.name = "名字"
        testModel.title = "文字"
        testModel.des = "描述"
        testModel.res = true
        testModel.size = CGSize(width: 100, height: 100)
        testModel.ages = 30
        
        let param = WisdomRouterParam.creat(key: "testModel",param: testModel)
        let hander = WisdomRouterHander.creat(key: "hander", hander: {(name: String, count: NSInteger) -> (Bool) in
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
        let VC = WisdomRouterKit.router(targetVC: "FiveViewController", param: param, hander: hander)
        navigationController?.pushViewController(VC, animated: true)
    }
    
    /// 多参数集合
    @IBAction func clickPushMuchModelBtn(_ sender: UIButton) {
        testModel.name = "名字"
        testModel.title = "文字"
        testModel.des = "描述"
        testModel.res = true
        testModel.size = CGSize(width: 33, height: 33)
        testModel.ages = 30
        
        let param1 = WisdomRouterParam.creat(key: "name99", param: "我是参数一：name99")
        let param2 = WisdomRouterParam.creat(key: "testModel", param: testModel)
        testModel.name = "名字---"
        testModel.title = "文字--"
        testModel.des = "描述---"
        testModel.res = true
        testModel.size = CGSize(width: 777, height: 777)
        testModel.ages = 777
        let param3 = WisdomRouterParam.creat(key: "threeTestModel", param: testModel)
        
        let VC = WisdomRouterKit.router(targetVC: "SixViewController", params: [param1,param2,param3])
        navigationController?.pushViewController(VC, animated: true)
    }
    
    /// 多闭包集合
    @IBAction func clickPushMuchHanderBtn(_ sender: UIButton) {
        let hander1 = WisdomRouterHander.creat(key: "closureOne", hander: {(name: String) in
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
        
        let hander2 = WisdomRouterHander.creat(key: "closureTwo", hander: {(name: String, size: CGSize) in
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
        
        let hander3 = WisdomRouterHander.creat(key: "closureThree", hander: {(name: String, count: NSInteger) -> (Bool) in
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
        let VC = WisdomRouterKit.router(targetVC: "SevenViewController", handers: [hander1,hander2,hander3])
        navigationController?.pushViewController(VC, animated: true)
    }
    
    /// 多参数和闭包集合
    @IBAction func clickPushMuchHanderAndMuchDataBtn(_ sender: UIButton) {
        testModel.name = "名字"
        testModel.title = "文字"
        testModel.des = "描述"
        testModel.res = true
        testModel.size = CGSize(width: 33, height: 33)
        testModel.ages = 30
        
        let param1 = WisdomRouterParam.creat(key: "name99", param: "我是参数一：name99")
        let param2 = WisdomRouterParam.creat(key: "testModel", param: testModel)
        testModel.name = "名字---"
        testModel.title = "文字--"
        testModel.des = "描述---"
        testModel.res = true
        testModel.size = CGSize(width: 777, height: 777)
        testModel.ages = 777
        let param3 = WisdomRouterParam.creat(key: "threeTestModel", param: testModel)
        
        let hander1 = WisdomRouterHander.creat(key: "closureOne", hander: {(name: String) in
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
        
        let hander2 = WisdomRouterHander.creat(key: "closureTwo", hander: {(name: String, size: CGSize) in
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
        
        let hander3 = WisdomRouterHander.creat(key: "closureThree", hander: {(name: String, count: NSInteger) -> (Bool) in
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
        let VC = WisdomRouterKit.router(targetVC: "EightViewController", params: [param1,param2,param3], handers: [hander1,hander2,hander3])
        navigationController?.pushViewController(VC, animated: true)
    }
}
