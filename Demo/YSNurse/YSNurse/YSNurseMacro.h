//
//  YSNurseMacro.h
//  YSNurse
//
//  Created by Joseph Gao on 2017/1/6.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#ifndef YSNurseMacro_h
#define YSNurseMacro_h


#define YSAssert(desc)\
        ({\
            NSString *errorDesc = [NSString stringWithFormat:@"Error Reason: %@", desc];\
            NSLog(@"\n====================>: \n %s: %@\n<====================\n\n\n",__func__, errorDesc);\
            NSAssert(NO, errorDesc);\
        })


#define YS_NURSE_CHECK_RANGE(totalLength, range, intoAction) \
        ({  \
            NSUInteger loc = range.location;    \
            NSUInteger len = range.length;  \
            if ((loc == totalLength && len > 0) ||  \
                (loc) > (totalLength) ||    \
                (loc) + (len) > (totalLength)) { \
                    NSString *desc = [NSString stringWithFormat:@"Range {%zd, %zd} out of bounds, Max Length is [%zd]!!!", loc, len, totalLength];    \
                    YSAssert(desc); \
                    intoAction;   \
            }   \
        })


#define YS_NURSE_INDEX_ASSERT(idx) \
        ({\
            NSString *desc = [NSString stringWithFormat:@"Index(%zd) out of bounds !!!", idx];\
            YSAssert(desc);\
        })


#define YS_NURSE_CHECK_INDEX(condition, idx, intoAction)\
        ({\
            if (condition) {    \
                YS_NURSE_INDEX_ASSERT(idx); \
                intoAction;    \
            }   \
        })


#define YS_NURSE_CHECK_PARAM_IS_NIL(aParam, isCanBeNull, intoAction) \
        ({  \
            if ((aParam == nil) || ((!isCanBeNull) && (NSNull *)aParam == [NSNull null])) {  \
                YSAssert(@"One or more `nil` arguments which can not be nil !!!");  \
                intoAction;    \
            }   \
        })



#define YS_NURSE_CHECK_PARAM_CLASS(aParam, class, intoAction) \
        ({  \
            if (![aParam isKindOfClass:class]) {    \
                NSString *desc = [NSString stringWithFormat:@"The (%@) is NOT a %@ !!!", aParam, NSStringFromClass(class)]; \
                YSAssert(desc);  \
                intoAction;    \
            }   \
        })


#define YS_NURSE_CHECK_INDEX_SET(condition, indexes, intoAction)\
        ({\
            if (condition) {    \
                NSString *desc = [NSString stringWithFormat:@"One or More index of Indexes(%p) are Greater than index of Container(%p)", indexes, self];   \
                YSAssert(desc); \
                intoAction; \
            }\
        })

#endif /* YSNurseMacro_h */

