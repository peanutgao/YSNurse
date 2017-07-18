//
//  YSNurse+AttributedString.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/7/16.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSNurse+AttributedString.h"
#import "YSNurseSwizz.h"
#import "YSNurseMacro.h"


#pragma mark - Category Of NSAttributedString

@implementation NSAttributedString (Nurse)

- (instancetype)ys_initWithString:(NSString *)str {
    NSString *s = str.copy;
    YS_NURSE_CHECK_PARAM_IS_NIL(str, NO, s = @"");
    
    return [self ys_initWithString:s];
}


- (NSAttributedString *)ys_attributedSubstringFromRange:(NSRange)range {
    YS_NURSE_CHECK_RANGE(self.length, range, nil);
    
    return [self ys_attributedSubstringFromRange:range];
}


- (instancetype)ys_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    NSString *s = str.copy;
    YS_NURSE_CHECK_PARAM_IS_NIL(str, NO, s = @"");
    
    return [self ys_initWithString:s attributes:attrs];
}

@end



#pragma mark - Category Of NSMutableAttributedString

@implementation NSMutableAttributedString (Nurse)

- (void)ys_deleteCharactersInRange:(NSRange)range {
    YS_NURSE_CHECK_RANGE(self.length, range, return);
    
    [self ys_deleteCharactersInRange:range];
}


- (void)ys_insertAttributedString:(NSAttributedString *)attrString atIndex:(NSUInteger)loc {
    YS_NURSE_CHECK_PARAM_IS_NIL(attrString, NO, return);
    YS_NURSE_CHECK_INDEX(loc > self.length, loc, return);
    
    [self ys_insertAttributedString:attrString atIndex:loc];
}


- (void)ys_replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    YS_NURSE_CHECK_PARAM_IS_NIL(str, NO, return);
    YS_NURSE_CHECK_RANGE(self.length, range, return);
    
    return [self ys_replaceCharactersInRange:range withString:str];
}


- (instancetype)ys_initWithString:(NSString *)str {
    NSString *s = str.copy;
    YS_NURSE_CHECK_PARAM_IS_NIL(str, NO, s = @"");
    
    return [self ys_initWithString:s];
}


- (instancetype)ys_initWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    NSString *s = str.copy;
    YS_NURSE_CHECK_PARAM_IS_NIL(str, NO, s = @"");
    
    return [self ys_initWithString:s attributes:attrs];
}

@end



#pragma mark - Category Of YSNurse

@implementation YSNurse (AttributedString)

+ (void)ys_attributedStringMethodSwizz {
    [self __attributedStringMethodSwizz];
    [self __mutableAttributedStringMethodSwizz];
}


+ (void)__attributedStringMethodSwizz {
    Class clazz = objc_getClass("NSConcreteAttributedString");
    
    instanceMethodSwizz(clazz, @selector(initWithString:), @selector(ys_initWithString:));
    instanceMethodSwizz(clazz, @selector(attributedSubstringFromRange:), @selector(ys_attributedSubstringFromRange:));
    instanceMethodSwizz(clazz, @selector(initWithString:attributes:), @selector(ys_initWithString:attributes:));
}


+ (void)__mutableAttributedStringMethodSwizz {
    Class clazz = objc_getClass("NSConcreteMutableAttributedString");
    
    instanceMethodSwizz(clazz, @selector(deleteCharactersInRange:), @selector(ys_deleteCharactersInRange:));
    instanceMethodSwizz(clazz, @selector(insertAttributedString:atIndex:), @selector(ys_insertAttributedString:atIndex:));
    instanceMethodSwizz(clazz, @selector(replaceCharactersInRange:withString:), @selector(ys_replaceCharactersInRange:withString:));
    instanceMethodSwizz(clazz, @selector(initWithString:), @selector(ys_initWithString:));
    instanceMethodSwizz(clazz, @selector(initWithString:attributes:), @selector(ys_initWithString:attributes:));
}

@end
