//
//  YSNurseMacro.h
//  YSNurse
//
//  Created by Joseph Gao on 2017/1/6.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#ifndef YSNurseMacro_h
#define YSNurseMacro_h

//
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"

#define YSAssert(desc)\
        ({\
            NSString *errorDesc __attribute__((unused)) = [NSString stringWithFormat:@"Error Reason: %@", desc];\
            NSLog(@">>> %s: %@",__func__, errorDesc);\
            NSAssert(![YSNurse shareInstance].isDebugEnable, errorDesc);\
        })

#define YS_NURSE_STRING_RANGE_ASSERT(aRange)\
        ({\
            NSString *desc = [NSString stringWithFormat:@"Range {%zd, %zd} out of bounds; string's length: %zd !!!",\
            aRange.location, aRange.length, self.length];\
            YSAssert(desc);\
        })

#define YS_NURSE_ARRAY_RANGE_ASSERT(aRange)\
        ({\
            NSString *desc = [NSString stringWithFormat:@"Range {%zd, %zd} out of bounds; array's count: %zd !!!",\
            aRange.location, aRange.length, self.count];\
            YSAssert(desc);\
        })

#define YS_NURSE_STRING_INDEX_ASSERT(idx)\
        ({\
            NSString *desc = [NSString stringWithFormat:@"Index(%zd) out of string's length(%zd) !!!",\
            idx, self.length];\
            YSAssert(desc);\
        })

#define YS_NURSE_ARRAY_INDEX_ASSERT(idx)\
        ({\
            NSString *desc = [NSString stringWithFormat:@"Index(%zd) out of array's count(%zd) !!!",\
            idx, self.count];\
            YSAssert(desc);\
        })


#define YS_NURSE_PARAM_NIL_ASSERT YSAssert(@"One or more `nil` arguments which can not be nil !!!")

#pragma clang diagnostic pop

#endif /* YSNurseMacro_h */
