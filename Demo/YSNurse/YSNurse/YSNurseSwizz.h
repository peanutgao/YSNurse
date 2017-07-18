//
//  YSNurseSwizz.h
//  YSNurse
//
//  Created by Joseph Gao on 2017/7/16.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#ifndef YSNurseSwizz_h
#define YSNurseSwizz_h

#import <objc/runtime.h>

static __inline__ void instanceMethodSwizz(Class clazz, SEL originSEL, SEL swizzSEL) {
    Method originMethod = class_getInstanceMethod(clazz, originSEL);
    Method swizzMethod = class_getInstanceMethod(clazz, swizzSEL);
    
    // 先尝试給源方法添加实现，这里是为了避免源方法没有实现的情况
    // 添加成功：将源方法的实现替换到交换方法的实现
    // 添加失败：说明源方法已经有实现，直接将两个方法的实现交换即可
    // YES if the method was added successfully,
    // otherwise NO (for example, the class already contains a method implementation with that name).
    BOOL didAddMethod = class_addMethod(clazz,
                                        originSEL,
                                        method_getImplementation(swizzMethod),
                                        method_getTypeEncoding(swizzMethod));
    if (didAddMethod) {
        class_replaceMethod(clazz,
                            swizzSEL,
                            method_getImplementation(originMethod),
                            method_getTypeEncoding(originMethod));
    }
    else {
        method_exchangeImplementations(originMethod, swizzMethod);
    }
}


static __inline__ void classMethodSwizz(Class clazz, SEL originSEL, SEL swizzSEL) {
    Method originMethod = class_getClassMethod(clazz, originSEL);
    Method swizzMethod = class_getClassMethod(clazz, swizzSEL);
    
    if (!originMethod || !swizzMethod) {
        return;
    }
    
    Class metaClazz = objc_getMetaClass(class_getName(clazz)); // 类方法添加,需要将方法添加到MetaClass中
    BOOL didAddMethod = class_addMethod(metaClazz,
                                        originSEL,
                                        method_getImplementation(swizzMethod),
                                        method_getTypeEncoding(swizzMethod));
    
    if (didAddMethod) {
        class_replaceMethod(metaClazz,
                            swizzSEL,
                            method_getImplementation(originMethod),
                            method_getTypeEncoding(originMethod));
    }
    else {
        method_exchangeImplementations(originMethod, swizzMethod);
    }
}

#endif /* YSNurseSwizz_h */
