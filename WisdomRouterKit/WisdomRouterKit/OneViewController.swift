//
//  SecundViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/14.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

class OneViewController: UIViewController {
    
    lazy var label: UILabel = {
        let lab = UILabel()
        lab.text = "WisdomRouterKit\nFunc:\n无参数无闭包\nRouter Test"
        lab.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        lab.center = self.view.center
        lab.backgroundColor = UIColor(white: 0.5, alpha: 0.7)
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WisdomRouterKit"
        view.backgroundColor = UIColor.white
        view.addSubview(label)
    }
}
