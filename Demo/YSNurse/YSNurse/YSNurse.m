//
//  YSNurse.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/1/5.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSNurse.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation YSNurse

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static YSNurse *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methoSignature = [super methodSignatureForSelector:aSelector];
    if (methoSignature == nil && self.debugEnable == NO) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    } else {
        return methoSignature;
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL aSelector = anInvocation.selector;
    if ([self respondsToSelector:@selector(ignorException:)]
        && self.debugEnable == NO) {
        [self ignorException:aSelector];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

- (void)ignorException:(SEL)aSelector {
    NSLog(@"*** [%@ %@] unrecognized selector sent to instance !!! ****",
          [YSNurse shareInstance].clazzName, NSStringFromSelector(aSelector));
    return;
}


@end
