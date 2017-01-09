//
//  UIResponder+Nurse.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/1/6.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "UIResponder+Nurse.h"
#import "YSNurse.h"

@implementation UIResponder (Nurse)

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (![self respondsToSelector:aSelector]) {
        YSNurse *obj = [YSNurse shareInstance];
        obj.clazzName = NSStringFromClass([self class]);
        return obj;
    }
    return nil;
}

@end
