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
    
    @IBAction func clickPushNoDateBtn(_ sender: UIButton) {
        let VC = WisdomRouterKit.router(targetVC: "SecundViewController")
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func clickPushHasDateBtn(_ sender: UIButton) {
        let VC = WisdomRouterKit.router(targetVC: "SecundTwoViewController", param: WisdomRouterParam.creat(param: "WisdomRouterKit", key: "name"))
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func clickPushHasDateModelBtn(_ sender: UIButton) {
        testModel.name = "名字"
        testModel.title = "文字"
        testModel.des = "描述"
        testModel.res = true
        testModel.size = CGSize(width: 100, height: 100)
        testModel.ages = 30
        let VC = WisdomRouterKit.router(targetVC: "SecundThreeViewController", param: WisdomRouterParam.creat(param: testModel, key: "testModel"))
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func clickPushHasDateModelListBtn(_ sender: UIButton) {
        for i in 0...500 {
            let model = TestModel()
            model.name = "名字-Three-" + String(i)
            model.title = "文字-Three-" + String(i)
            model.des = "描述-Three-" + String(i)
            model.res = true
            model.size = CGSize(width: 333, height: 333)
            testModelList.append(model)
        }
        let VC = WisdomRouterKit.router(targetVC: "ThreeViewController", param: WisdomRouterParam.creat(param: testModelList, key: "testModelList"))
        navigationController?.pushViewController(VC, animated: true)
    }
    
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
    
    
    @IBAction func clickPushModelAndeWaitHanderBtn(_ sender: UIButton) {
        testModel.name = "名字"
        testModel.title = "文字"
        testModel.des = "描述"
        testModel.res = true
        testModel.size = CGSize(width: 100, height: 100)
        testModel.ages = 30
        
        let param = WisdomRouterParam.creat(param: testModel, key: "testModel")
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
        let VC = WisdomRouterKit.router(targetVC: "FiveViewController", param: param, hander: hander)
        navigationController?.pushViewController(VC, animated: true)
    }
}
