//
//  NSMutableArray+Nurse.m
//  YSNurse
//
//  Created by Joseph Gao on 2016/12/16.
//  Copyright © 2016年 Joseph. All rights reserved.
//

#import "NSMutableArray+Nurse.h"
#import "YSNurse.h"
#import "YSNurseSwizz.h"


@implementation NSMutableArray (Nurse)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class clazz = objc_getClass("__NSArrayM");

        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(replaceObjectsAtIndexes:withObjects:)
                    withSwizzMethod:@selector(ys_replaceObjectsAtIndexes:withObjects:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(removeObjectsAtIndexes:)
                    withSwizzMethod:@selector(ys_removeObjectsAtIndexes:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(insertObjects:atIndexes:)
                    withSwizzMethod:@selector(ys_insertObjects:atIndexes:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(replaceObjectsInRange:withObjectsFromArray:range:)
                    withSwizzMethod:@selector(ys_replaceObjectsInRange:withObjectsFromArray:range:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(removeObjectsInRange:)
                    withSwizzMethod:@selector(ys_removeObjectsInRange:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(removeObjectIdenticalTo:inRange:)
                    withSwizzMethod:@selector(ys_removeObjectIdenticalTo:inRange:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(exchangeObjectAtIndex:withObjectAtIndex:)
                    withSwizzMethod:@selector(ys_exchangeObjectAtIndex:withObjectAtIndex:)];
        
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(replaceObjectAtIndex:withObject:)
                    withSwizzMethod:@selector(ys_replaceObjectAtIndex:withObject:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(removeObjectAtIndex:)
                    withSwizzMethod:@selector(ys_removeObjectAtIndex:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(insertObject:atIndex:)
                    withSwizzMethod:@selector(ys_insertObject:atIndex:)];
        [YSNurseSwizz exchangeClass:clazz
               systemInstanceMethod:@selector(addObject:)
                    withSwizzMethod:@selector(ys_addObject:)];
    });
}


/****************	Mutable Array NSExtendedMutableArray	****************/

/// replaceObjectsAtIndexes:withObjects:
- (void)ys_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<id> *)objects {
    if (indexes == nil || [indexes isEqual:[NSNull null]]) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }
    
    NSUInteger currentIndex = [indexes firstIndex];
    NSUInteger i, count = [indexes count];
    if (self.count == 0) {
        if (objects.count != 0 || count != 0) {
            YS_NURSE_ARRAY_INDEX_ASSERT(currentIndex);
        }
        return;
    }
    else {
        if (count != objects.count) {
            NSString *desc = [NSString stringWithFormat:@"count of array (%zd) differs from count of index set", objects.count];
            YSAssert(desc);
        }
        if (currentIndex >= self.count) {
            YS_NURSE_ARRAY_INDEX_ASSERT(currentIndex);
            return;
        }
        
        for (i = 0; i < count; i++) {
            @autoreleasepool {
                if (currentIndex >= self.count || currentIndex >= objects.count) {
                    NSString *desc = [NSString stringWithFormat:@"index (%zd) is out of array's bounds", currentIndex];
                    YSAssert(desc);
                    return;
                }
                id obj = [objects objectAtIndex:currentIndex];
                [self replaceObjectAtIndex:currentIndex withObject:obj];
                currentIndex = [indexes indexGreaterThanIndex:currentIndex];
            }
        }
    }
   
}


/// removeObjectsAtIndexes:
- (void)ys_removeObjectsAtIndexes:(NSIndexSet *)indexes {
    if (indexes == nil || [indexes isEqual:[NSNull null]]) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }
    if (indexes.count == 0) {
        [self ys_removeObjectsAtIndexes:indexes];
        return;
    }
    

    NSInteger currentIndex = [indexes firstIndex];
    NSInteger count = [indexes count];
    NSInteger i = [indexes count];
    
    if (self.count == 0) {
        if (count != 0) {
            YS_NURSE_ARRAY_INDEX_ASSERT(currentIndex);
        }
        return;
    }
    else if (currentIndex >= self.count) {
        YS_NURSE_ARRAY_INDEX_ASSERT(currentIndex);
        return;
    }
    
    NSInteger originCount = self.count;
    NSInteger tempIdx = -1;
    for (i = 0; i < count; i++) {
        @autoreleasepool {
            if (currentIndex >= originCount) {
                NSString *desc = [NSString stringWithFormat:@"index (%zd) is out of array's bounds", currentIndex];
                YSAssert(desc);
                return;
            }
            
            tempIdx++;
            [self removeObjectAtIndex:(currentIndex - tempIdx)];
            currentIndex = [indexes indexGreaterThanIndex:currentIndex];
        }
    }
}


/// insertObjects:atIndexes:
- (void)ys_insertObjects:(NSArray<id> *)objects atIndexes:(NSIndexSet *)indexes {
    if (indexes == nil || [indexes isEqual:[NSNull null]]) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }

    NSUInteger currentIndex = [indexes firstIndex];
    NSUInteger i, count = [indexes count];
    if (count != objects.count) {
        YSAssert(@"objects's count is NOT equal to Range's length !!!");
    }
    
    if (self.count == 0) {
        if (currentIndex > 0) {
            YS_NURSE_ARRAY_INDEX_ASSERT(currentIndex);
            currentIndex = 0;
        }
    }
    else if (currentIndex > self.count) {
        YS_NURSE_ARRAY_INDEX_ASSERT(currentIndex);
        currentIndex = self.count;
    }

    for (i = 0; i < count; i++) {
        @autoreleasepool {
            if (currentIndex > self.count) currentIndex = self.count;
            [self insertObject:[objects objectAtIndex:i] atIndex:currentIndex];
            currentIndex = [indexes indexGreaterThanIndex:currentIndex];
        }
    }
}


/// replaceObjectsInRange:withObjectsFromArray:range:
- (void)ys_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray range:(NSRange)otherRange {
    NSUInteger loc = range.location;
    NSUInteger len = range.length;
    if (self.count == 0) {
        if (loc != 0 || len != 0) {
            YS_NURSE_ARRAY_RANGE_ASSERT(range);
            loc = 0;
            len = 0;
        }
    }
    else {
        if (loc >= self.count) {
            YS_NURSE_ARRAY_RANGE_ASSERT(range);
            return;
        }
        if (loc + len > self.count) {
            YS_NURSE_ARRAY_RANGE_ASSERT(range);
            len = self.count - loc;
        }
    }
    
    
    NSUInteger oloc = otherRange.location;
    NSUInteger olen = otherRange.length;
    if (otherArray.count == 0) {
        if (oloc != 0 || olen != 0) {
            YS_NURSE_ARRAY_RANGE_ASSERT(otherRange);
            oloc = 0;
            olen = 0;
        }
        return;
    }
    else {
        if (oloc >= otherArray.count) {
            NSString *desc = [NSString stringWithFormat:@"Range {%zd, %zd} out of otherRange; otherArray.count: %zd",
                              loc, len, otherArray.count];
            YSAssert(desc);
            return;
        }
        if (oloc + olen > otherArray.count) {
            NSString *desc = [NSString stringWithFormat:@"Range {%zd, %zd} out of otherRange; otherArray.count: %zd",
                              loc, len, otherArray.count];
            YSAssert(desc);
            olen = otherArray.count - oloc;
        }
    }
    
    [self ys_replaceObjectsInRange:NSMakeRange(loc, len)
              withObjectsFromArray:otherArray
                             range:NSMakeRange(oloc, olen)];
}


/// removeObjectsInRange:
- (void)ys_removeObjectsInRange:(NSRange)range {
    NSUInteger loc = range.location;
    NSUInteger len = range.length;
    if (self.count == 0) {
        if (loc != 0 || len != 0) {
            YS_NURSE_ARRAY_RANGE_ASSERT(range);
            loc = 0;
            len = 0;
        }
    }
    else {
        if (loc >= self.count) {
            YS_NURSE_ARRAY_RANGE_ASSERT(range);
            return;
        }
        else if (loc + len > self.count) {
            YS_NURSE_ARRAY_RANGE_ASSERT(range);
            len = self.count - loc;
        }
    }
    [self ys_removeObjectsInRange:NSMakeRange(loc, len)];
}


/// removeObjectIdenticalTo:inRange:
- (void)ys_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    NSUInteger loc = range.location;
    NSUInteger len = range.length;
    if (self.count == 0) {
        if (loc != 0 || len != 0) {
            YS_NURSE_ARRAY_RANGE_ASSERT(range);
            loc = 0;
            len = 0;
        }
    }
    else {
        if (loc >= self.count) {
            YS_NURSE_ARRAY_RANGE_ASSERT(range);
            return;
        }
        if (loc + len > self.count) {
            YS_NURSE_ARRAY_RANGE_ASSERT(range);
            len = self.count - loc;
        }
    }

    [self ys_removeObjectIdenticalTo:anObject inRange:NSMakeRange(loc, len)];
}


/// exchangeObjectAtIndex:withObjectAtIndex:
- (void)ys_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    if (idx1 >= self.count || idx2 >= self.count) {
        YS_NURSE_ARRAY_INDEX_ASSERT(index);
        return;
    }
    [self ys_exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}


/****************	Mutable Array		****************/

/// replaceObjectAtIndex:withObject:
- (void)ys_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (anObject == nil) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }
    if (index >= self.count) {
        YS_NURSE_ARRAY_INDEX_ASSERT(index);
        return;
    }
    [self ys_replaceObjectAtIndex:index withObject:anObject];
}


/// removeObjectAtIndex:
- (void)ys_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        YS_NURSE_ARRAY_INDEX_ASSERT(index);
        return;
    }
    [self ys_removeObjectAtIndex:index];
}


/// insertObject:atIndex:
- (void)ys_insertObject:(id)anObject atIndex:(NSInteger)index {
    if (anObject == nil) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }
    if (index < 0) {
        YS_NURSE_ARRAY_INDEX_ASSERT(index);
        return;
    }
    // if index is larger than self.count, add object at the last of array
    else if (index > self.count) {
        YS_NURSE_ARRAY_INDEX_ASSERT(index);
        index = self.count;
    }
    
    [self ys_insertObject:anObject atIndex:index];
}


/// addObject:
- (void)ys_addObject:(id)anObject {
    if (anObject == nil) {
        YS_NURSE_PARAM_NIL_ASSERT;
        return;
    }
    [self ys_addObject:anObject];
}


@end
