//
//  NSObject+Nurse.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/1/3.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "NSObject+Nurse.h"
#import "YSNurse.h"
#import "YSNurseSwizz.h"

@implementation NSObject (Nurse)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [YSNurseSwizz exchangeClass:objc_getClass("NSObject")
               systemInstanceMethod:@selector(setValue:forKeyPath:)
                    withSwizzMethod:@selector(ys_setValue:forKeyPath:)];
        [YSNurseSwizz exchangeClass:objc_getClass("NSObject")
               systemInstanceMethod:@selector(setValue:forKey:)
                    withSwizzMethod:@selector(ys_setValue:forKey:)];
    });
}


/// setValue:forKeyPath:
- (void)ys_setValue:(id)value forKeyPath:(NSString *)keyPath {
    @try {
        [self ys_setValue:value forKeyPath:keyPath];
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception callStackSymbols]);
    }
}


/// setValue:forKey:
- (void)ys_setValue:(id)value forKey:(NSString *)key {
    @try {
        [self ys_setValue:value forKey:key];
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception callStackSymbols]);
    }
}
@end
