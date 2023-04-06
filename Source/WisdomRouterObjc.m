//
//  WisdomRouterObjc.m
//  WisdomRouterKit
//
//  Created by jianfeng on 2023/4/6.
//  Copyright © 2023 All over the sky star. All rights reserved.
//

#import "WisdomRouterObjc.h"
#import <objc/runtime.h>

@implementation WisdomRouterObjc

+ (void)load {
    Class protocolCla = objc_getClass("WisdomRouterKit.WisdomRouterKitToSeeHere");
    SEL sel = NSSelectorFromString(@"routerKitFunction");

    IMP imp = [protocolCla methodForSelector:sel];
    void (*func)(id, SEL) = (void *)imp;
    func(protocolCla, sel);
}

@end
