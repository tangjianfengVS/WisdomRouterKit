//
//  TestShareModel.swift
//  WisdomRouterKit
//
//  Created by jianfeng on 2019/10/7.
//  Copyright © 2019 All over the sky star. All rights reserved.
//

import UIKit

class TestShareModel: WisdomRouterModel, WisdomRouterShareProtocol {
    
    func share() -> WisdomRouterModel {
        return TestShareModel.share;
    }
    
    static let share : TestShareModel = TestShareModel()
    
    var name: String = "Wisdom"
    var title: String = "Title"
    var des: String = "描述"
    var res: Bool = false
    var size: CGSize = CGSize(width: 22, height: 100)
    var ages: NSInteger=30
}
