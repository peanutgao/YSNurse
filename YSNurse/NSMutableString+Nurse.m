//
//  NSMutableString+Nurse.m
//  YSNurse
//
//  Created by Joseph Gao on 2016/12/16.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "NSMutableString+Nurse.h"
#import "YSNurse.h"
#import "YSNurseSwizz.h"

@implementation NSMutableString (Nurse)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class clazz = objc_getClass("__NSCFString");

        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(replaceOccurrencesOfString:withString:options:range:)
                    withSwizzMethod:@selector(ys_replaceOccurrencesOfString:withString:options:range:)];
        
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(setString:)
                    withSwizzMethod:@selector(ys_setString:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(appendString:)
                    withSwizzMethod:@selector(ys_appendString:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(deleteCharactersInRange:)
                    withSwizzMethod:@selector(ys_deleteCharactersInRange:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(replaceCharactersInRange:withString:)
                    withSwizzMethod:@selector(ys_replaceCharactersInRange:withString:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(insertString:atIndex:)
                    withSwizzMethod:@selector(ys_insertString:atIndex:)];
    });
}


/// replaceOccurrencesOfString:withString:options:range:
- (NSUInteger)ys_replaceOccurrencesOfString:(NSString *)target
                                 withString:(NSString *)replacement
                                    options:(NSStringCompareOptions)options
                                      range:(NSRange)searchRange {
    if ((target == nil || [target isEqual:[NSNull null]])
        || replacement == nil) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return 0;
    }
    
    NSUInteger loc = searchRange.location;
    NSUInteger len = searchRange.length;
    if (self.length == 0) {
        if (loc != 0 || len != 0) YS_NURSE_STRING_RANGE_ASSERT(searchRange);
        return 0;
    }
    if (loc > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(searchRange);
        return 0;
    }
    if (loc == self.length && len != 0) {
        YS_NURSE_STRING_RANGE_ASSERT(searchRange);
        return 0;
    }
    if (loc + len > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(searchRange);
        len = self.length - loc;
    }
    
    return [self ys_replaceOccurrencesOfString:target
                                    withString:replacement
                                       options:options
                                         range:NSMakeRange(loc, len)];
}


/// setString:
- (void)ys_setString:(NSString *)aString {
    if (aString == nil || [aString isEqual:[NSNull null]]) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }
    [self ys_setString:aString];
}


/// appendString:
- (void)ys_appendString:(NSString *)aString {
    if (aString == nil || [aString isEqual:[NSNull null]]) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }
    [self ys_appendString:aString];
}


/// deleteCharactersInRange:
- (void)ys_deleteCharactersInRange:(NSRange)range {
    NSUInteger loc = range.location;
    NSUInteger len = range.length;
    if (self.length == 0) {
        if (loc != 0 || len != 0) YS_NURSE_STRING_RANGE_ASSERT(range);
        return;
    }
    if (loc > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        return;
    }
    if (loc == self.length && len != 0) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        return;
    }
    if (loc + len > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        len = self.length - loc;
    }
    
    [self ys_deleteCharactersInRange:NSMakeRange(loc, len)];
}


/// replaceCharactersInRange:withString:
/// system also call the function, just use @try-@catch to avoid crash
- (void)ys_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    if (aString == nil || [aString isEqual:[NSNull null]]) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }
    
    @try {
        [self ys_replaceCharactersInRange:range withString:aString];
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception callStackSymbols]);
    } @finally {
        
    }
}


/// insertString:atIndex:
- (void)ys_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    if (aString == nil || [aString isEqual:[NSNull null]]) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }
    if (self.length == 0) {
        if (loc != 0) {
            YS_NURSE_STRING_INDEX_ASSERT(loc);
            loc = 0;
        }
    }
    else if (loc >= self.length) {
        YS_NURSE_STRING_INDEX_ASSERT(loc);
        return;
    }
    
    [self ys_insertString:aString atIndex:loc];
}

@end
