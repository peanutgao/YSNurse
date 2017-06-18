//
//  NSString+Nurse.m
//  YSNurse
//
//  Created by Joseph Gao on 2016/12/16.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "NSString+Nurse.h"
#import "YSNurse.h"
#import "YSNurseSwizz.h"

@implementation NSString (Nurse)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class clazz = objc_getClass("__NSCFString");

        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(stringByReplacingCharactersInRange:withString:)
                    withSwizzMethod:@selector(ys_stringByReplacingCharactersInRange:withString:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(stringByReplacingOccurrencesOfString:withString:options:range:)
                    withSwizzMethod:@selector(ys_stringByReplacingOccurrencesOfString:withString:options:range:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(stringByPaddingToLength:withString:startingAtIndex:)
                    withSwizzMethod:@selector(ys_stringByPaddingToLength:withString:startingAtIndex:)];
        
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(rangeOfComposedCharacterSequenceAtIndex:)
                    withSwizzMethod:@selector(ys_rangeOfComposedCharacterSequenceAtIndex:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(rangeOfComposedCharacterSequencesForRange:)
                    withSwizzMethod:@selector(ys_rangeOfComposedCharacterSequencesForRange:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(rangeOfString:options:range:)
                    withSwizzMethod:@selector(ys_rangeOfString:options:range:)];
        
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(getCharacters:range:)
                    withSwizzMethod:@selector(ys_getCharacters:range:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(substringWithRange:)
                    withSwizzMethod:@selector(ys_substringWithRange:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(substringToIndex:)
                    withSwizzMethod:@selector(ys_substringToIndex:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(substringFromIndex:)
                    withSwizzMethod:@selector(ys_substringFromIndex:)];
    });
}



#pragma mark *** Other ***

/// stringByReplacingCharactersInRange:withString:
- (NSString *)ys_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    if (replacement == nil) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return self;
    }
    
    NSUInteger loc = range.location;
    NSUInteger len = range.length;
    if (self.length == 0) {
        if (loc != 0 || len != 0)  YS_NURSE_STRING_RANGE_ASSERT(range);
        return self;
    }
    if (loc >= self.length || loc + len > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        return self;
    }
    
    return [self ys_stringByReplacingCharactersInRange:NSMakeRange(loc, len) withString:replacement];
}


/// stringByReplacingOccurrencesOfString:withString:options:range:
- (NSString *)ys_stringByReplacingOccurrencesOfString:(NSString *)target
                                           withString:(NSString *)replacement
                                              options:(NSStringCompareOptions)options
                                                range:(NSRange)searchRange {
    if ((target == nil || [target isEqual:[NSNull null]])
        || (replacement == nil || [replacement isEqual:[NSNull null]])) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return self;
    }
    
    NSUInteger loc = searchRange.location;
    NSUInteger len = searchRange.length;
    if (self.length == 0) {
        if (loc != 0 || len != 0) YS_NURSE_STRING_RANGE_ASSERT(searchRange);
        return self;
    }
    if (loc > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(searchRange);
        return self;
    }
    if (loc == self.length && len != 0) {
        YS_NURSE_STRING_RANGE_ASSERT(searchRange);
        return self;
    }
    
    if (loc + len > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(searchRange);
        len = self.length - loc;
    }
    
    return [self ys_stringByReplacingOccurrencesOfString:target
                                              withString:replacement
                                                 options:options
                                                   range:NSMakeRange(loc, len)];
}


/// stringByPaddingToLength:withString:startingAtIndex:
- (NSString *)ys_stringByPaddingToLength:(NSUInteger)newLength
                              withString:(NSString *)padString
                         startingAtIndex:(NSUInteger)padIndex {
    if (padString.length == 0) {
        YSAssert(@"nil or empty padString !!!");
        return nil;
    }
    if (padIndex >= padString.length) {
        YS_NURSE_STRING_INDEX_ASSERT(padIndex);
        padIndex = 0;
    }
    return [self ys_stringByPaddingToLength:newLength withString:padString startingAtIndex:padIndex];
}


#pragma mark *** String comparison and equality ***

/// 用来确定特定位置的 unichar 是不是代表单个字符（可能由多个码点组成）的码元序列的一部分。
/// 每当给另一个方法传入一个内容未知的字符串的范围作参数时都应该这样做，确保 Unicode 字符不会被从中间分开
/// rangeOfComposedCharacterSequenceAtIndex:
- (NSRange)ys_rangeOfComposedCharacterSequenceAtIndex:(NSUInteger)index {
    if (index >= self.length) {
        YS_NURSE_STRING_INDEX_ASSERT(index);
        return NSMakeRange(0, 0);
    }
    
    return [self ys_rangeOfComposedCharacterSequenceAtIndex:index];
}


/// rangeOfComposedCharacterSequencesForRange:
- (NSRange)ys_rangeOfComposedCharacterSequencesForRange:(NSRange)range {
    NSUInteger loc = range.location;
    NSUInteger len = range.length;
    if (self.length == 0) {
        if (loc != 0 || len != 0) YS_NURSE_STRING_RANGE_ASSERT(range);
        return NSMakeRange(0, 0);
    }
    if (loc > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        return NSMakeRange(0, 0);
    }
    if (loc == self.length && len != 0) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        return NSMakeRange(0, 0);
    }
    if (loc + len > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        len = self.length - loc;
    }
    
    return [self ys_rangeOfComposedCharacterSequencesForRange:NSMakeRange(loc, len)];
}


/// rangeOfString:options:range:
- (NSRange)ys_rangeOfString:(NSString *)searchString
                    options:(NSStringCompareOptions)mask
                      range:(NSRange)rangeOfReceiverToSearch {
    if (searchString == nil) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return NSMakeRange(0, 0);
    }
    
    NSUInteger loc = rangeOfReceiverToSearch.location;
    NSUInteger len = rangeOfReceiverToSearch.length;
    if (self.length == 0) {
        if (loc != 0 || len != 0) YS_NURSE_STRING_RANGE_ASSERT(rangeOfReceiverToSearch);
        return NSMakeRange(0, 0);
    }
    if (loc > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(rangeOfReceiverToSearch);
        return NSMakeRange(0, 0);
    }
    if (loc == self.length && len != 0) {
        YS_NURSE_STRING_RANGE_ASSERT(rangeOfReceiverToSearch);
        return NSMakeRange(0, 0);
    }
    if (loc + len > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(rangeOfReceiverToSearch);
        len = self.length - loc;
    }
    
    return [self ys_rangeOfString:searchString options:mask range:NSMakeRange(loc, len)];
    
    @try {
        return [self ys_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch];
    } @catch (NSException *exception) {
        YS_NURSE_STRING_RANGE_ASSERT(rangeOfReceiverToSearch);
    }
}


#pragma mark *** Substrings ***

/// getCharacters:range:
- (void)ys_getCharacters:(unichar *)buffer range:(NSRange)range {
    if (buffer == nil) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }
    
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
    
    [self ys_getCharacters:buffer range:NSMakeRange(loc, len)];
}


/// substringWithRange:
- (NSString *)ys_substringWithRange:(NSRange)range {
    NSUInteger loc = range.location;
    NSUInteger len = range.length;
    if (self.length == 0) {
        if (loc != 0 || len != 0) YS_NURSE_STRING_RANGE_ASSERT(range);
        return @"";
    }
    if (loc > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        return @"";
    }
    if (loc == self.length && len != 0) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        return @"";
    }
    
    if (loc + len > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        len = self.length - loc;
    }
    
    return [self ys_substringWithRange:NSMakeRange(loc, len)];
}


/// substringToIndex:
- (NSString *)ys_substringToIndex:(NSUInteger)to {
    if (to > self.length) {
        YS_NURSE_STRING_INDEX_ASSERT(to);
        return self;
    }
    return [self ys_substringToIndex:to];
}


/// substringFromIndex:
- (NSString *)ys_substringFromIndex:(NSUInteger)from {
    if (from > self.length) {
        YS_NURSE_STRING_INDEX_ASSERT(from);
        return @"";
    }
    return [self ys_substringFromIndex:from];
}


@end
