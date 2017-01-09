//
//  YSNurse.h
//  YSNurse
//
//  Created by Joseph Gao on 2017/1/5.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSNurseMacro.h"

@interface YSNurse : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, copy) NSString *clazzName;
/// yes:   NSAssert(NO, errorDesc);
/// NO:    NSAssert(YES, errorDesc);
/// default is NO
@property (nonatomic, assign, getter=isDebugEnable) BOOL debugEnable;

@end
