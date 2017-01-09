//
//  NSMutableAttributedString+Nurse.m
//  YSNurse
//
//  Created by Joseph Gao on 2016/12/16.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "NSMutableAttributedString+Nurse.h"
#import "YSNurse.h"
#import "YSNurseSwizz.h"

@implementation NSMutableAttributedString (Nurse)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class clazz = objc_getClass("NSConcreteMutableAttributedString");
        
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(deleteCharactersInRange:)
                    withSwizzMethod:@selector(ys_deleteCharactersInRange:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(insertAttributedString:atIndex:)
                    withSwizzMethod:@selector(ys_insertAttributedString:atIndex:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(replaceCharactersInRange:withString:)
                    withSwizzMethod:@selector(ys_replaceCharactersInRange:withString:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(initWithString:)
                    withSwizzMethod:@selector(ys_initWithString:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(initWithString:attributes:)
                    withSwizzMethod:@selector(ys_initWithString:attributes:)];
    });
}


/// deleteCharactersInRange:
- (void)ys_deleteCharactersInRange:(NSRange)range {
    NSUInteger loc = range.location;
    NSUInteger len = range.length;
    if (self.length == 0) {
        if (loc != 0 || len != 0) YS_NURSE_STRING_RANGE_ASSERT(range);
        return;
    }
    else if (loc >= self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        return;
    }
    else if (loc + len > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        len = self.length - loc;
    }
    
    [self ys_deleteCharactersInRange:NSMakeRange(loc, len)];
}


/// insertAttributedString:atIndex:
- (void)ys_insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc {
    if (attrString == nil || [attrString isEqual:[NSNull null]]) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }
    
    if (self.length == 0) {
        if (loc != 0) YS_NURSE_STRING_INDEX_ASSERT(loc);
        loc = 0;
    }
    else if (loc >= self.length) {
        YS_NURSE_STRING_INDEX_ASSERT(loc);
        loc = self.length - 1;
    }
    
    [self ys_insertAttributedString:attrString atIndex:loc];
}


/// replaceCharactersInRange:withString:
- (void)ys_replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    if (str == nil || [str isEqual:[NSNull null]]) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }
    
    NSUInteger loc = range.location;
    NSUInteger len = range.length;
    if (self.length == 0) {
        if (loc != 0 || len != 0) {
            YS_NURSE_STRING_RANGE_ASSERT(range);
            return;
        }
    }
    else if (loc >= self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        return;
    }
    else if (loc + len > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        len = self.length - loc;
    }
    
    return [self ys_replaceCharactersInRange:NSMakeRange(loc, len) withString:str];
}


/// initWithString:
- (instancetype)ys_initWithString:(NSString *)str {
    NSString *s = str;
    if (str == nil || [str isEqual:[NSNull null]]) {
        YS_NURSE_PARAM_NIL_ASSERT;
        s = @"";
    }
    return [self ys_initWithString:s];
}


/// initWithString:attributes:
- (instancetype)ys_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    NSString *s = str;
    if (str == nil || [str isEqual:[NSNull null]]) {
        YS_NURSE_PARAM_NIL_ASSERT;
        s = @"";
    }
    return [self ys_initWithString:s attributes:attrs];
}

@end
