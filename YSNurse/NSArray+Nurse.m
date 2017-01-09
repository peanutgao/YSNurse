//
//  NSArray+Nurse.m
//  YSNurse
//
//  Created by Joseph Gao on 2016/12/15.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "NSArray+Nurse.h"
#import "YSNurse.h"
#import "YSNurseSwizz.h"

@implementation NSArray (Nurse)

+ (void)load {
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class clazz = objc_getClass("__NSArrayI");
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(subarrayWithRange:)
                    withSwizzMethod:@selector(ys_subarrayWithRange:)];
        [YSNurseSwizz exchangeClass:clazz
                  systemInstanceMethod:@selector(objectsAtIndexes:)
                    withSwizzMethod:@selector(ys_objectsAtIndexes:)];
//        [YSNurseSwizz exchangeClass:objc_getClass("__NSArray0")
//                  systemInstanceMethod:@selector(objectAtIndex:)
//                    withSwizzMethod:@selector(ys_objectAtIndex:)];
        [YSNurseSwizz exchangeClass:clazz
                  systemInstanceMethod:@selector(objectAtIndex:)
                    withSwizzMethod:@selector(ys_objectAtIndex:)];
        [YSNurseSwizz exchangeClass:clazz
                  systemInstanceMethod:@selector(arrayByAddingObject:)
                    withSwizzMethod:@selector(ys_arrayByAddingObject:)];
        
        [YSNurseSwizz exchangeClass:clazz
                  systemClassMethod:@selector(arrayWithObjects:count:)
                    withSwizzMethod:@selector(ys_arrayWithObjects:count:)];
    });
}


/// subarrayWithRange
- (NSArray *)ys_subarrayWithRange:(NSRange)range {
    NSUInteger loc = range.location;
    NSUInteger len = range.length;
    if (self.count == 0) {
        loc = 0;
        len = 0;
    }
    else {
        if (loc >= self.count) {
            YS_NURSE_ARRAY_RANGE_ASSERT(range);
            return nil;
        }
        if (loc + len > self.count) {
            YS_NURSE_ARRAY_RANGE_ASSERT(range);
            len = self.count - loc;
        }
    }

    return [self ys_subarrayWithRange:range];
}


/// objectsAtIndexes
/// System also call this method, can not override it!
- (NSArray *)ys_objectsAtIndexes:(NSIndexSet *)indexes {
    @try {
        return [self ys_objectsAtIndexes:indexes];
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception callStackSymbols]);
        return nil;
    }
}


/// arrayByAddingObject:
- (NSArray *)ys_arrayByAddingObject:(NSArray *)anArray {
    if (anArray == nil) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return [self ys_arrayByAddingObject:@[]];
    }
    else {
        return [self ys_arrayByAddingObject:anArray];
    }
}


/// objectAtIndex:
- (id)ys_objectAtIndex:(NSInteger)index {
    if (index < 0 || index > self.count - 1) {
        YS_NURSE_ARRAY_INDEX_ASSERT(index);
        return nil;
    }
    else {
        return [self ys_objectAtIndex:index];
    }
}


/// arrayWithObjects:count:
/// TODO: It will cause EXC_BAD_ACCESS Error if cnt is bigger than objects' length.
+ (instancetype)ys_arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    @try {
        return [self ys_arrayWithObjects:objects count:cnt];
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception callStackSymbols]);
        
        // click with Option key
        id _Nonnull __unsafe_unretained safeObjects[cnt];

        NSInteger safeCnt = 0;
        for (NSUInteger i = 0; i < cnt; i++) {
            @autoreleasepool {
                id  _Nonnull __unsafe_unretained obj = objects[i];
                if (!obj) {
                    YSAssert(@"A value of dictionary is nil !!!");
                    continue;
                }
                
                safeObjects[safeCnt] = obj;
                safeCnt++;
            }
        }
        return [self ys_arrayWithObjects:safeObjects count:safeCnt];
    }
}


@end
