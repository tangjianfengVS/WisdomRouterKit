//
//  SevenViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/22.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

class SevenViewController: UIViewController,WisdomRouterRegisterProtocol {
    static func register() {
        WisdomRouterKit.register(vcClassType: self)
    }
    
    var closureOne: ((String) -> Void)?
    
    var closureTwo: ((String,CGSize) -> Void)?
    
    var closureThree: ((String,Bool) -> Void)?
    
    var handerBtnOne: UIButton = {
        let btn = UIButton(frame: CGRect(x: 10, y: UIScreen.main.bounds.height - 270, width: UIScreen.main.bounds.width - 20, height: 35))
        btn.setTitle("Click Hander One", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.addTarget(self, action: #selector(clickHanderOne), for: .touchUpInside)
        return btn
    }()
    
    var handerBtnTwo: UIButton = {
        let btn = UIButton(frame: CGRect(x: 10, y: UIScreen.main.bounds.height - 210, width: UIScreen.main.bounds.width - 20, height: 35))
        btn.setTitle("Click Hander Two", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.addTarget(self, action: #selector(clickHanderTwo), for: .touchUpInside)
        return btn
    }()
    
    var handerBtnThree: UIButton = {
        let btn = UIButton(frame: CGRect(x: 10, y: UIScreen.main.bounds.height - 150, width: UIScreen.main.bounds.width - 20, height: 35))
        btn.setTitle("Click Hander Three", for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.addTarget(self, action: #selector(clickHanderThree), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(handerBtnOne)
        view.addSubview(handerBtnTwo)
        view.addSubview(handerBtnThree)
    }
    
    @objc func clickHanderOne(){
        
    }

    @objc func clickHanderTwo(){
        
    }
    
    @objc func clickHanderThree(){
        
    }
}
