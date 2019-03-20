//
//  ThreeViewController.swift
//  WisdomRouterKitDemo
//
//  Created by jianfeng on 2019/3/16.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

@objcMembers class ThreeViewController: UIViewController, WisdomRouterRegisterProtocol{
    var testModelList: [ThreeTestModel]?
    
    static func register() {
        WisdomRouterKit.register(vcClassType: self, modelName: "testModelList", modelClassType: ThreeTestModel.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ModelList: testModelList"
        view.backgroundColor = UIColor.white
        view.addSubview(tabView)
    }
    
    
    lazy var tabView : UITableView = {
        let view = UITableView(frame: self.view.frame, style: .plain)
        view.register(TestCell.classForCoder(), forCellReuseIdentifier: "TestCell")
        view.rowHeight = 140
        view.dataSource = self
        return view
    }()
}


extension ThreeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testModelList != nil ? testModelList!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as! TestCell
        cell.model = testModelList![indexPath.row]
        return cell
    }
}

class TestCell: UITableViewCell {
    let labe = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 140))
    
    var model: ThreeTestModel? {
        didSet{
            labe.text = nil
            var text: String = "ThreeTestModel:  \n"
            let propertyList = WisdomRouterKit.propertyList(targetClass: ThreeTestModel.self)
            for key in propertyList {
                let res = model?.value(forKey: key)
                var str = ""
                if let resStr = res as? String{
                    str = resStr
                }
                text = text + key + ": " + str + "\n"
            }
            labe.text = text
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(labe)
        labe.textAlignment = .center
        labe.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
