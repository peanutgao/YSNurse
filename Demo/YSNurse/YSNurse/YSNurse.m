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
#import "YSNurseMacro.h"
#import "YSNurse+Array.h"
#import "YSNurse+Dictionary.h"
#import "YSNurse+String.h"
#import "YSNurse+AttributedString.h"
#import "YSNurse+Object.h"

@implementation YSNurse

+ (void)configEnable:(BOOL)enable {
    if (enable == NO) return;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ys_arrayMethodSwizz];
        [self ys_dictionaryMethodSwizz];
        [self ys_stringMethodSwizz];
        [self ys_attributedStringMethodSwizz];
        [self ys_objectMethodSwizz];
    });
}

//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    NSMethodSignature *methoSignature = [super methodSignatureForSelector:aSelector];
//    if (methoSignature == nil) {
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    } else {
//        return methoSignature;
//    }
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    SEL aSelector = anInvocation.selector;
//    if ([self respondsToSelector:@selector(ignorException:)]) {
//        [self ignorException:aSelector];
//    } else {
//        [super forwardInvocation:anInvocation];
//    }
//}
//
//- (void)ignorException:(SEL)aSelector {
//    NSLog(@"*** [%@ %@] unrecognized selector sent to instance !!! ****",
//          [YSNurse shareInstance].clazzName, NSStringFromSelector(aSelector));
//    return;
//}

@end
