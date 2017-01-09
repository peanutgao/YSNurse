//
//  YSNurseSwizz.h
//  YSNurse
//
//  Created by Joseph Gao on 2016/12/26.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface YSNurseSwizz : NSObject

+ (void)exchangeClass:(Class)clazz systemInstanceMethod:(SEL)systemSEL withSwizzMethod:(SEL)swizzSEL;
+ (void)exchangeClass:(Class)clazz systemClassMethod:(SEL)systemSEL withSwizzMethod:(SEL)swizzSEL;

+ (void)replaceInstanceMethod:(SEL)aSEL ofClass:(Class)aClazz withReplaceMethod:(SEL)replaceSEL ofClass:(Class)replaceClazz;

@end


