//
//  YSNurseSwizz.m
//  YSNurse
//
//  Created by Joseph Gao on 2016/12/26.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "YSNurseSwizz.h"

@implementation YSNurseSwizz

#pragma mark -

+ (void)replaceInstanceMethod:(SEL)aSEL ofClass:(Class)aClazz withReplaceMethod:(SEL)replaceSEL ofClass:(Class)replaceClazz {
    Method aMethod = class_getInstanceMethod(aClazz, aSEL);
    Method replaceMethod = class_getInstanceMethod(replaceClazz, replaceSEL);
    if (aMethod && replaceMethod) {
        class_replaceMethod(aClazz,
                            aSEL,
                            method_getImplementation(replaceMethod),
                            method_getTypeEncoding(replaceMethod));
    }
}


+ (void)exchangeClass:(Class)clazz systemInstanceMethod:(SEL)systemSEL withSwizzMethod:(SEL)swizzSEL {
    Method systemMethod = class_getInstanceMethod(clazz, systemSEL);
    Method swizzMethod = class_getInstanceMethod(clazz, swizzSEL);
    
    // 使用class_addMethod()函数对Method Swizzling做了一层验证，如果self没有实现被交换的方法，会导致失败。
    // YES if the method was added successfully,
    // otherwise NO (for example, the class already contains a method implementation with that name).
    BOOL didAddMethod = class_addMethod(clazz,
                                        systemSEL,
                                        method_getImplementation(swizzMethod),
                                        method_getTypeEncoding(swizzMethod));
    if (didAddMethod) {
        class_replaceMethod(clazz,
                            swizzSEL,
                            method_getImplementation(systemMethod),
                            method_getTypeEncoding(systemMethod));
    }
    else {
        method_exchangeImplementations(systemMethod, swizzMethod);
    }
}


+ (void)exchangeClass:(Class)clazz systemClassMethod:(SEL)systemSEL withSwizzMethod:(SEL)swizzSEL {
    Method systemMethod = class_getClassMethod(clazz, systemSEL);
    Method swizzMethod = class_getClassMethod(clazz, swizzSEL);
    
    if (systemMethod == nil || swizzMethod == nil) return;
    method_exchangeImplementations(systemMethod, swizzMethod);
}



@end
