//
//  YSNurse+String.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/7/16.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSNurse+String.h"
#import "YSNurseSwizz.h"
#import "YSNurseMacro.h"

#pragma mark - Category Of NSString

@implementation NSString (Nurse)

- (NSString *)ys_stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    YS_NURSE_CHECK_PARAM_IS_NIL(replacement, YES, return self);
    YS_NURSE_CHECK_RANGE(self.length,range, return self);
    
    return [self ys_stringByReplacingCharactersInRange:range withString:replacement];
}


- (NSString *)ys_stringByReplacingOccurrencesOfString:(NSString *)target
                                           withString:(NSString *)replacement
                                              options:(NSStringCompareOptions)options
                                                range:(NSRange)searchRange {
    YS_NURSE_CHECK_PARAM_IS_NIL(target, NO, return self);
    YS_NURSE_CHECK_PARAM_IS_NIL(replacement, NO, return self);
    YS_NURSE_CHECK_RANGE(self.length, searchRange, return self);
    
    return [self ys_stringByReplacingOccurrencesOfString:target
                                              withString:replacement
                                                 options:options
                                                   range:searchRange];
}


- (NSString *)ys_stringByPaddingToLength:(NSUInteger)newLength
                              withString:(NSString *)padString
                         startingAtIndex:(NSUInteger)padIndex {
    if (padString.length == 0) {
        YSAssert(@"nil or empty padString !!!");
        return @"";
    }
    if (padIndex >= padString.length) {
        YS_NURSE_INDEX_ASSERT(padIndex);
        return @"";
    }

    return [self ys_stringByPaddingToLength:newLength withString:padString startingAtIndex:padIndex];
}


/// 用来确定特定位置的 unichar 是不是代表单个字符（可能由多个码点组成）的码元序列的一部分。
/// 每当给另一个方法传入一个内容未知的字符串的范围作参数时都应该这样做，确保 Unicode 字符不会被从中间分开
/// rangeOfComposedCharacterSequenceAtIndex:
- (NSRange)ys_rangeOfComposedCharacterSequenceAtIndex:(NSUInteger)index {
    YS_NURSE_CHECK_INDEX((index >= self.length), index, return NSMakeRange(0, 0));
    
    return [self ys_rangeOfComposedCharacterSequenceAtIndex:index];
}


- (NSRange)ys_rangeOfComposedCharacterSequencesForRange:(NSRange)range {
    YS_NURSE_CHECK_RANGE(self.length, range, return NSMakeRange(0, 0));
    
    return [self ys_rangeOfComposedCharacterSequencesForRange:range];
}


- (NSRange)ys_rangeOfString:(NSString *)searchString
                    options:(NSStringCompareOptions)mask
                      range:(NSRange)rangeOfReceiverToSearch {
    YS_NURSE_CHECK_PARAM_IS_NIL(searchString, YES, return NSMakeRange(0, 0));
    YS_NURSE_CHECK_RANGE(self.length, rangeOfReceiverToSearch, return NSMakeRange(0, 0));
    
    return [self ys_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch];
}


- (void)ys_getCharacters:(unichar *)buffer range:(NSRange)range {
    YS_NURSE_CHECK_RANGE(self.length, range, return);
    
    [self ys_getCharacters:buffer range:range];
}


- (NSString *)ys_substringWithRange:(NSRange)range {
    YS_NURSE_CHECK_RANGE(self.length, range, return @"");
    
    return [self ys_substringWithRange:range];
}


- (NSString *)ys_substringToIndex:(NSUInteger)to {
    YS_NURSE_CHECK_INDEX((to > self.length), to, return self);

    return [self ys_substringToIndex:to];
}


- (NSString *)ys_substringFromIndex:(NSUInteger)from {
    YS_NURSE_CHECK_INDEX((from > self.length), from, return @"");

    return [self ys_substringFromIndex:from];
}

@end



#pragma mark - Category Of NSMutableString

@implementation NSMutableString (Nurse)

- (NSUInteger)ys_replaceOccurrencesOfString:(NSString *)target
                                 withString:(NSString *)replacement
                                    options:(NSStringCompareOptions)options
                                      range:(NSRange)searchRange {
    YS_NURSE_CHECK_PARAM_IS_NIL(target, NO, return 0);
    YS_NURSE_CHECK_PARAM_IS_NIL(replacement, NO, return 0);
    YS_NURSE_CHECK_RANGE(self.length, searchRange, return 0);
    
    return [self ys_replaceOccurrencesOfString:target
                                    withString:replacement
                                       options:options
                                         range:searchRange];
}


- (void)ys_setString:(NSString *)aString {
    YS_NURSE_CHECK_PARAM_IS_NIL(aString, NO, return);
    
    [self ys_setString:aString];
}


- (void)ys_appendString:(NSString *)aString {
    YS_NURSE_CHECK_PARAM_IS_NIL(aString, NO, return);
    
    [self ys_appendString:aString];
}


- (void)ys_deleteCharactersInRange:(NSRange)range {
    YS_NURSE_CHECK_RANGE(self.length, range, return);
    
    [self ys_deleteCharactersInRange:range];
}


/// system also call the function, just use @try-@catch to avoid crash
- (void)ys_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    YS_NURSE_CHECK_PARAM_IS_NIL(aString, NO, return);
    
    @try {
        [self ys_replaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception callStackSymbols]);
    }
}


- (void)ys_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    YS_NURSE_CHECK_PARAM_IS_NIL(aString, NO, return);
    YS_NURSE_CHECK_INDEX(loc > self.length, loc, return);
    
    [self ys_insertString:aString atIndex:loc];
}

@end


#pragma mark - Category Of YSNurse

@implementation YSNurse (String)

+ (void)ys_stringMethodSwizz {
    [self __stringMethodSwizz];
    [self __mutableStringMethodSwizz];
}


+ (void)__stringMethodSwizz {
    Class clazz = objc_getClass("__NSCFString");
    
    instanceMethodSwizz(clazz,
                        @selector(stringByReplacingCharactersInRange:withString:),
                        @selector(ys_stringByReplacingCharactersInRange:withString:));
    instanceMethodSwizz(clazz,
                        @selector(stringByReplacingOccurrencesOfString:withString:options:range:),
                        @selector(ys_stringByReplacingOccurrencesOfString:withString:options:range:));
    instanceMethodSwizz(clazz,
                        @selector(stringByPaddingToLength:withString:startingAtIndex:),
                        @selector(ys_stringByPaddingToLength:withString:startingAtIndex:));
    instanceMethodSwizz(clazz,
                        @selector(rangeOfComposedCharacterSequenceAtIndex:),
                        @selector(ys_rangeOfComposedCharacterSequenceAtIndex:));
    instanceMethodSwizz(clazz,
                        @selector(rangeOfComposedCharacterSequencesForRange:),
                        @selector(ys_rangeOfComposedCharacterSequencesForRange:));
    instanceMethodSwizz(clazz, @selector(rangeOfString:options:range:), @selector(ys_rangeOfString:options:range:));
    
    instanceMethodSwizz(clazz, @selector(getCharacters:range:), @selector(ys_getCharacters:range:));
    instanceMethodSwizz(clazz, @selector(substringWithRange:), @selector(ys_substringWithRange:));
    instanceMethodSwizz(clazz, @selector(substringToIndex:), @selector(ys_substringToIndex:));
    instanceMethodSwizz(clazz, @selector(substringFromIndex:), @selector(ys_substringFromIndex:));
}


+ (void)__mutableStringMethodSwizz {
    Class clazz = objc_getClass("__NSCFString");
    
    instanceMethodSwizz(clazz,
                        @selector(replaceOccurrencesOfString:withString:options:range:),
                        @selector(ys_replaceOccurrencesOfString:withString:options:range:));
    
    instanceMethodSwizz(clazz, @selector(setString:), @selector(ys_setString:));
    instanceMethodSwizz(clazz, @selector(appendString:), @selector(ys_appendString:));
    instanceMethodSwizz(clazz, @selector(deleteCharactersInRange:), @selector(ys_deleteCharactersInRange:));
    instanceMethodSwizz(clazz,
                        @selector(replaceCharactersInRange:withString:),
                        @selector(ys_replaceCharactersInRange:withString:));
    instanceMethodSwizz(clazz, @selector(insertString:atIndex:), @selector(ys_insertString:atIndex:));
}

@end
