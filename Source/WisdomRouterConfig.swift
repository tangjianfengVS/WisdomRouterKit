//
//  WisdomRouterKitConfig.swift
//  WisdomRouterKit
//
//  Created by jianfeng on 2019/3/28.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit


class WisdomRouterKitToSeeHere {
    
    @objc static func routerKitFunction() {
        let start = CFAbsoluteTimeGetCurrent()
        let c = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: c)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(c))
        
        var list: [Int:Int] = [0: c/2, c/2+1: c]//23320-0.019
        if c>30000 {
            list = [0:c/6, c/6+1:c/6*2, c/6*2+1:c/6*3, c/6*3+1:c/6*4, c/6*4+1:c/6*5, c/6*5+1:c]//30616-0.065
        }else if c>28000 {
            list = [0:c/5, c/5+1:c/5*2, c/5*2+1:c/5*3, c/5*3+1:c/5*4, c/5*4+1:c]
        }else if c>26000 {
            list = [0:c/4, c/4+1:c/2, c/2+1:c/4*3, c/4*3+1:c]
        }else if c>24000 {
            list = [0:c/3, c/3+1:c/3*2, c/3*2+1:c]
        }
        let protocolQueue = DispatchQueue(label: "WisdomProtocolCoreQueue", attributes: DispatchQueue.Attributes.concurrent)
        for index in list { register(types: types, begin: index.key, end: index.value) }

        func register(types: UnsafeMutablePointer<AnyClass>, begin: Int, end: Int) {
            protocolQueue.async {
                for index in begin ..< end {
                    (types[index] as? WisdomRouterRegisterProtocol.Type)?.registerRouter()
                }
            }
        }

        protocolQueue.sync(flags: .barrier) {
            types.deinitialize(count: c)
            types.deallocate()
            print("[WisdomProtocol] Queue Took "+"\(CFAbsoluteTimeGetCurrent()-start) \(c) \(list.count)")
        }
    }
}


let Dot = "."

let Bracket = "{"

let Equal = "="

let DateBaseKey = "Double,double,NSInteger,Int,Int8,Int16,Int32,Int64,UInt,UInt8,UInt16,UInt32,UInt64,CGFloat,Float"

let ReplacingList : [String] = ["10","11","12","13","14","15","16","17","18","19","20"]

let valueTypesMap: Dictionary<String, String> = [
    "c" : "Int8",
    "s" : "Int16",
    "i" : "Int32",
    "q" : "Int", //also: Int64, NSInteger, only true on 64 bit platforms
    "S" : "UInt16",
    "I" : "UInt32",
    "Q" : "UInt", //also UInt64, only true on 64 bit platforms
    "B" : "Bool",
    "d" : "Double",
    "f" : "Float",
    "{" : "Decimal"
]


public typealias RouterHandler = (UIViewController) -> Void

public typealias RouterResultHandler = (UIViewController, [String]) -> Void

public typealias RouterErrorHandler = (String) -> Void

public typealias RouterRegisterHandler = (Any,UIViewController) -> Void

public typealias RouterSharedHandler = (WisdomRouterModel,[String]) -> Void
