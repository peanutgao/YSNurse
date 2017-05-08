//
//  NSDictionary+Nurse.m
//  YSNurse
//
//  Created by Joseph Gao on 2016/12/16.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "NSDictionary+Nurse.h"
#import "YSNurse.h"
#import "YSNurseSwizz.h"

@implementation NSDictionary (Nurse)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [YSNurseSwizz exchangeClass:objc_getClass("__NSDictionaryI")
                  systemClassMethod:@selector(dictionaryWithObjects:forKeys:count:)
                    withSwizzMethod:@selector(ys_dictionaryWithObjects:forKeys:count:)];
        [YSNurseSwizz exchangeClass:[self class]
               systemInstanceMethod:@selector(initWithObjects:forKeys:)
                    withSwizzMethod:@selector(ys_initWithObjects:forKeys:)];
    });
}


/// dictionaryWithObjects:forKeys:count:
+ (instancetype)ys_dictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects
                                 forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys
                                   count:(NSUInteger)cnt  {
    if ((objects == nil || keys == nil) && cnt != 0) {
        YSAssert(@"One or more params is nil, but the `count` is not 0 !!!");
        return nil;
    }
    
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger safeCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        @autoreleasepool {
            id  _Nonnull __unsafe_unretained key = keys[i];
            id  _Nonnull __unsafe_unretained obj = objects[i];
            if (!key) {
                YSAssert(@"A key of dictionary is nil !!!");
                continue;
            }
            if (!obj) {
                YSAssert(@"A value of dictionary is nil !!!");
                obj = [NSNull null];
            }
            
            safeKeys[safeCnt] = key;
            safeObjects[safeCnt] = obj;
            safeCnt++;
        }
    }
    return [self ys_dictionaryWithObjects:safeObjects forKeys:safeKeys count:safeCnt];
}


/// initWithObjects:forKeys:
- (instancetype)ys_initWithObjects:(NSArray<id> *)objects forKeys:(NSArray<id <NSCopying>> *)keys {
    if (keys.count == 0) {
        return [self ys_initWithObjects:objects forKeys:keys];
    }
    
    NSMutableArray *safeKeysM = keys.mutableCopy;
    NSMutableArray *safeObjsM = objects != nil ? objects.mutableCopy : [NSMutableArray arrayWithCapacity:keys.count];
    if (safeObjsM.count < safeKeysM.count) YSAssert(@"objectes.count != keys.count !!!");
    while (safeObjsM.count < safeKeysM.count) {
        [safeObjsM addObject:[NSNull null]];
        continue;
    }
    while (safeObjsM.count > safeKeysM.count) {
        [safeObjsM removeLastObject];
        continue;
    }
    
    return [self ys_initWithObjects:safeObjsM.copy forKeys:safeKeysM.copy];
}

@end
