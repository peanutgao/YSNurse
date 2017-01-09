//
//  NSAttributedString+Nurse.m
//  YSNurse
//
//  Created by Joseph Gao on 2016/12/16.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "NSAttributedString+Nurse.h"
#import "YSNurse.h"
#import "YSNurseSwizz.h"

@implementation NSAttributedString (Nurse)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class clazz = objc_getClass("NSConcreteAttributedString");
        
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(initWithString:)
                    withSwizzMethod:@selector(ys_initWithString:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(attributedSubstringFromRange:)
                    withSwizzMethod:@selector(ys_attributedSubstringFromRange:)];
//        [YSNurseSwizz exchangeClass:clazz
//               systemInstanceMethod:@selector(attribute:atIndex:effectiveRange:)
//                    withSwizzMethod:@selector(ys_attribute:atIndex:effectiveRange:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(initWithString:attributes:)
                    withSwizzMethod:@selector(ys_initWithString:attributes:)];
    });
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


/// attributedSubstringFromRange:
- (NSAttributedString *)ys_attributedSubstringFromRange:(NSRange)range {
    NSUInteger loc = range.location;
    NSUInteger len = range.length;
    if (self.length == 0) {
        if (loc != 0 || len != 0) {
            YS_NURSE_STRING_RANGE_ASSERT(range);
            return nil;
        }
    }
    else if (loc >= self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        return nil;
    }
    else if (loc + len > self.length) {
        YS_NURSE_STRING_RANGE_ASSERT(range);
        len = self.length - loc;
    }
    
    return [self ys_attributedSubstringFromRange:NSMakeRange(loc, len)];
}


///// attribute:atIndex:effectiveRange:
//- (id)ys_attribute:(NSString *)attrName atIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range {
//    NSUInteger loc = range->location;
//    NSUInteger len = range->length;
//    if (self.length == 0) {
//        if (loc != 0 || len != 0) {
//            YS_NURSE_STRING_RANGE_ASSERT(NSMakeRange(loc, len));
//        }
//        return nil;
//    }
//    else if (location >= self.length) {
//        YS_NURSE_STRING_INDEX_ASSERT(location);
//        return nil;
//    }
//    
//    return [self ys_attribute:attrName atIndex:location effectiveRange:range];
//}


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
