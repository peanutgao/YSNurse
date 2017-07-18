//
//  YSNurse+Dictionary.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/7/16.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSNurse+Dictionary.h"
#import "YSNurseSwizz.h"
#import "YSNurseMacro.h"


#pragma mark - Category Of NSDictionary

@implementation NSDictionary (Nurse)

// TODO: It will cause EXC_BAD_ACCESS Error if cnt is bigger than objects' length.
+ (instancetype)ys_dictionaryWithObjects:(const id [])objects
                                 forKeys:(const id <NSCopying> [])keys
                                   count:(NSUInteger)cnt {
//    
//    @try {
//        return [self ys_dictionaryWithObjects:objects forKeys:keys count:cnt];
//    }
//    @catch (NSException *exception) {
//        NSLog(@"%@", [exception callStackSymbols]);
//    };

    
    if ((objects == nil || keys == nil) && cnt != 0) {
        YSAssert(@"\nThe objects or keys params is nil, but the `cnt` is NOT ZERO !!!");
        return nil;
    }
    
    id safeValues[cnt];
    id safeKeys[cnt];
    NSUInteger safeCnt = 0;
    
    //NSUInteger minCnt = MIN((sizeof((keys)) / sizeof((keys)[0])), cnt);
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
            safeValues[safeCnt] = obj;
            safeCnt++;
        }
    }
    
    return [self ys_dictionaryWithObjects:safeValues forKeys:safeKeys count:safeCnt];
}


- (instancetype)ys_initWithObjects:(NSArray<id> *)objects forKeys:(NSArray<id <NSCopying>> *)keys {
    if (objects.count == keys.count) return [self ys_initWithObjects:objects forKeys:keys];
    
    YSAssert(@"\n*****The objects and keys arrays DO NOT have the same number of elements !!! *****");
    
    NSMutableArray *safeKeysM = keys.mutableCopy;
    NSMutableArray *safeObjsM = objects != nil ? objects.mutableCopy : [NSMutableArray arrayWithCapacity:keys.count];
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



#pragma mark - Category Of NSMutableDictionary

@implementation NSMutableDictionary (Nurse)

- (void)ys_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    YS_NURSE_CHECK_PARAM_IS_NIL(aKey, YES, return);
    YS_NURSE_CHECK_PARAM_IS_NIL(anObject, YES, anObject = [NSNull null]);

    [self ys_setObject:anObject forKey:aKey];
}


- (void)ys_removeObjectForKey:(id)aKey {
    YS_NURSE_CHECK_PARAM_IS_NIL(aKey, YES, return);
    
    [self ys_removeObjectForKey:aKey];
}

@end



#pragma mark - Category Of YSNurse

@implementation YSNurse (Dictionary)

+ (void)ys_dictionaryMethodSwizz {
    [self __dictionaryMethodSwizz];
    [self __mutableDictionaryMethodSwizz];
}


+ (void)__dictionaryMethodSwizz {
    classMethodSwizz(objc_getClass("__NSDictionaryI"),
                     @selector(dictionaryWithObjects:forKeys:count:),
                     @selector(ys_dictionaryWithObjects:forKeys:count:));
    
    instanceMethodSwizz([NSDictionary class],
                        @selector(initWithObjects:forKeys:),
                        @selector(ys_initWithObjects:forKeys:));
}


+ (void)__mutableDictionaryMethodSwizz {
    Class clazz = objc_getClass("__NSDictionaryM");
    
    instanceMethodSwizz(clazz, @selector(setObject:forKey:), @selector(ys_setObject:forKey:));
    instanceMethodSwizz(clazz, @selector(removeObjectForKey:), @selector(ys_removeObjectForKey:));
}

@end
