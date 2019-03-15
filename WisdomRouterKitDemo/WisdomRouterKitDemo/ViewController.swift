//
//  ViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/14.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    var testModel: TestModel = TestModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickPushNoDateBtn(_ sender: UIButton) {
        WisdomRouterKit.router(currentVC: self, targetVC: "SecundViewController")
    }
    
    @IBAction func clickPushHasDateBtn(_ sender: UIButton) {
        WisdomRouterKit.router(currentVC: self, targetVC: "SecundViewController", param: WisdomRouterParam.creat(param: "Wisdom", key: "name"))
    }
    
     @IBAction func clickPushHasDateModelBtn(_ sender: UIButton) {
        testModel.name = "名字"
        testModel.title = "文字"
        testModel.des = "描述"
        testModel.res = true
        testModel.size = CGSize(width: 100, height: 100)
        WisdomRouterKit.router(currentVC: self, targetVC: "SecundViewController", param: WisdomRouterParam.creat(param: testModel, key: "testModel"))
    }
}

