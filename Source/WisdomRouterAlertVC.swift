//
//  WisdomRouterAlertVC.swift
//  WisdomRouterKit
//
//  Created by jianfeng on 2019/8/31.
//  Copyright © 2019 All over the sky star. All rights reserved.
//

import UIKit

class WisdomRouterAlertVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /** 系统界面提示 */
    @objc public static func alert(title: String,
                                   message: String,
                                   closeActionText: String?,
                                   rightActionText: String?,
                                   handler: ((UIAlertAction) -> Void)?) -> WisdomRouterAlertVC{
        let alertVC = WisdomRouterAlertVC()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if closeActionText != nil {
            let cancelAction = UIAlertAction(title: closeActionText, style: .default, handler: { action in
                
                if handler != nil{
                    handler!(action)
                }
                alert.dismiss(animated: true, completion: nil)
                alertVC.navigationController?.popViewController(animated: true)
            })
            alert.addAction(cancelAction)
        }
        
        if rightActionText != nil {
            let rightAction = UIAlertAction(title: rightActionText, style: UIAlertAction.Style.default, handler: { action in
                if handler != nil{
                    handler!(action)
                }
            })
            alert.addAction(rightAction)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            alertVC.present(alert, animated: true, completion: nil)
        }
        return alertVC
    }
}
