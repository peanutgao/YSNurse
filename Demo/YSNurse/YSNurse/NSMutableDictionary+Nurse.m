//
//  NSMutableDictionary+Nurse.m
//  YSNurse
//
//  Created by Joseph Gao on 2016/12/16.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "NSMutableDictionary+Nurse.h"
#import "YSNurse.h"
#import "YSNurseSwizz.h"

@implementation NSMutableDictionary (Nurse)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class clazz = objc_getClass("__NSDictionaryM");

        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(setObject:forKey:)
                    withSwizzMethod:@selector(ys_setObject:forKey:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(removeObjectForKey:)
                    withSwizzMethod:@selector(ys_removeObjectForKey:)];
    });
}


/// setObject:forKey:
- (void)ys_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (aKey == nil) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }
    if (anObject == nil) {
        YS_NURSE_PARAM_NIL_ASSERT;
        anObject = [NSNull null];
    }
    [self ys_setObject:anObject forKey:aKey];
}


/// removeObjectForKey:
- (void)ys_removeObjectForKey:(id)aKey {
    if (aKey == nil) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }
    [self ys_removeObjectForKey:aKey];
}
@end
