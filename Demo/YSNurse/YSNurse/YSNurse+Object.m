//
//  YSNurse+Object.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/7/16.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSNurse+Object.h"
#import "YSNurseSwizz.h"


#pragma mark - Category Of NSObject

@implementation NSObject (Nurse)

- (void)ys_setValue:(id)value forKeyPath:(NSString *)keyPath {
    @try {
        [self ys_setValue:value forKeyPath:keyPath];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception callStackSymbols]);
    }
}


- (void)ys_setValue:(id)value forKey:(NSString *)key {
    @try {
        [self ys_setValue:value forKey:key];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception callStackSymbols]);
    }
}

@end



#pragma mark - Category Of YSNurse

@implementation YSNurse (Object)

+ (void)ys_objectMethodSwizz {
    Class clazz = objc_getClass("NSObject");
    
    instanceMethodSwizz(clazz, @selector(setValue:forKeyPath:), @selector(ys_setValue:forKeyPath:));
    instanceMethodSwizz(clazz, @selector(setValue:forKey:), @selector(ys_setValue:forKey:));
}

@end
