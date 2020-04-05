//
//  WisdomRouterKitConfig.swift
//  WisdomRouterKit
//
//  Created by jianfeng on 2019/3/28.
//  Copyright © 2019年 All over the sky star. All rights reserved.
//

import UIKit

extension UIApplication {
    override open var next: UIResponder? {
        UIApplication.routerKitRunOnce
        return super.next
    }
    
    private static let routerKitRunOnce: Void = {
        WisdomRouterKitToSeeHere.routerKitFunction()
    }()
}


class WisdomRouterKitToSeeHere {
    static func routerKitFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        
        for index in 0 ..< typeCount {
            (types[index] as? WisdomRouterRegisterProtocol.Type)?.register()
        }
        types.deallocate()
    }
}


let Dot = "."

let Bracket = "{"

let Equal = "="

let errorCount: Int = 5

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
