//
//  YSNurse+Array.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/7/16.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSNurse+Array.h"
#import "YSNurseSwizz.h"
#import "YSNurseMacro.h"


#pragma mark - Category Of Array

@implementation NSArray (Nurse)

- (NSArray *)ys_subarrayWithRange:(NSRange)range {
    YS_NURSE_CHECK_RANGE(self.count, range, return @[]);
    
    return [self ys_subarrayWithRange:range];
}


- (NSArray *)ys_objectsAtIndexes:(NSIndexSet *)indexes {
    YS_NURSE_CHECK_PARAM_IS_NIL(indexes, NO, return nil);
    
    NSUInteger currentIdx = [indexes firstIndex];
    NSUInteger count = [indexes count];
    
    YS_NURSE_CHECK_INDEX_SET((self.count == 0 && currentIdx != 0), indexes, return nil);
    
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        @autoreleasepool {
            YS_NURSE_CHECK_INDEX_SET((currentIdx >= self.count), indexes, return result.copy);

            [result addObject:[self objectAtIndex:currentIdx]];
            currentIdx = [indexes indexGreaterThanIndex:currentIdx];
        }
    }
    
    return result.copy;
}


- (NSArray *)ys_arrayByAddingObject:(NSArray *)anArray {
    YS_NURSE_CHECK_PARAM_IS_NIL(anArray, NO, return nil);
    
    return [self ys_arrayByAddingObject:anArray];
}


- (id)ys_objectAtIndex:(NSUInteger)index {
    YS_NURSE_CHECK_INDEX((index > self.count - 1), index, return nil);
    
    return [self ys_objectAtIndex:index];
}


// TODO: It will cause EXC_BAD_ACCESS Error if cnt is bigger than objects' length.
+ (instancetype)ys_arrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    @try {
        return [self ys_arrayWithObjects:objects count:cnt];
    } @catch (NSException *exception) {
        NSLog(@"%@", [exception callStackSymbols]);
        
        id _Nonnull __unsafe_unretained safeObjects[cnt];
        
        NSInteger safeCnt = 0;
        for (NSUInteger i = 0; i < cnt; i++) {
            @autoreleasepool {
                id  _Nonnull __unsafe_unretained obj = objects[i];
                if (!obj) {
                    YSAssert(@"A value of dictionary is nil !!!");
                    continue;
                }
                
                safeObjects[safeCnt] = obj;
                safeCnt++;
            }
        }
        
        return [self ys_arrayWithObjects:safeObjects count:safeCnt];
    }
}

@end



#pragma mark - Category Of Mutable Array

@implementation NSMutableArray (Nurse)

- (void)ys_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<id> *)objects {
    YS_NURSE_CHECK_PARAM_IS_NIL(indexes, NO, return);
    YS_NURSE_CHECK_PARAM_CLASS(objects, [NSArray class], return);
    
    NSUInteger currentIdx = [indexes firstIndex];
    NSUInteger i, count = [indexes count];
    
    if (count != objects.count) {
        YSAssert(@"The count of locations in indexes must equal the count of objects.");
        return;
    }
    
    for (i = 0; i < count; i++) {
        @autoreleasepool {
            YS_NURSE_CHECK_INDEX_SET((currentIdx >= self.count), indexes, return);
            
            id obj = [objects objectAtIndex:currentIdx];
            [self replaceObjectAtIndex:currentIdx withObject:obj];
            currentIdx = [indexes indexGreaterThanIndex:currentIdx];
        }
    }
}


- (void)ys_removeObjectsAtIndexes:(NSIndexSet *)indexes {
    YS_NURSE_CHECK_PARAM_IS_NIL(indexes, NO, return);
    
    if (indexes.count == 0) {
        [self ys_removeObjectsAtIndexes:indexes];
        return;
    }
    
    NSUInteger currentIdx = [indexes firstIndex];
    NSUInteger i, count = [indexes count];
    
    NSUInteger tempIdx = -1;
    for (i = 0; i < count; i++) {
        @autoreleasepool {
            YS_NURSE_CHECK_INDEX_SET((currentIdx >= self.count), indexes, return);
            
            tempIdx++;
            [self removeObjectAtIndex:(currentIdx - tempIdx)];
            currentIdx = [indexes indexGreaterThanIndex:currentIdx];
        }
    }
}


- (void)ys_insertObjects:(NSArray<id> *)objects atIndexes:(NSIndexSet *)indexes {
    YS_NURSE_CHECK_PARAM_IS_NIL(indexes, NO, return);
    YS_NURSE_CHECK_PARAM_CLASS(objects, [NSArray class], return);
    
    NSUInteger currentIdx = [indexes firstIndex];
    NSUInteger i, count = [indexes count];
    
    if (count != objects.count) {
        YSAssert(@"The count of locations in indexes must equal the count of objects !!!");
        return;
    }

    for (i = 0; i < count; i++) {
        @autoreleasepool {
            YS_NURSE_CHECK_INDEX_SET((currentIdx > self.count), indexes, return);
            
            [self insertObject:[objects objectAtIndex:i] atIndex:currentIdx];
            currentIdx = [indexes indexGreaterThanIndex:currentIdx];
        }
    }
}


- (void)ys_replaceObjectsInRange:(NSRange)range
            withObjectsFromArray:(NSArray<id> *)otherArray
                           range:(NSRange)otherRange {
    YS_NURSE_CHECK_RANGE(self.count, range, return);
    YS_NURSE_CHECK_RANGE(otherArray.count, otherRange, return);
    
    [self ys_replaceObjectsInRange:range
              withObjectsFromArray:otherArray
                             range:otherRange];
}


- (void)ys_removeObjectsInRange:(NSRange)range {
    YS_NURSE_CHECK_RANGE(self.count, range, return);

    [self ys_removeObjectsInRange:range];
}


- (void)ys_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    YS_NURSE_CHECK_RANGE(self.count, range, return);
    
    [self ys_removeObjectIdenticalTo:anObject inRange:range];
}


- (void)ys_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    YS_NURSE_CHECK_INDEX((idx1 >= self.count), idx1, return);
    YS_NURSE_CHECK_INDEX((idx2 >= self.count), idx2, return);
    
    [self ys_exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}


- (void)ys_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    YS_NURSE_CHECK_PARAM_IS_NIL(anObject, YES, return);
    YS_NURSE_CHECK_INDEX((index >= self.count), index, return);

    [self ys_replaceObjectAtIndex:index withObject:anObject];
}


- (void)ys_removeObjectAtIndex:(NSUInteger)index {
    YS_NURSE_CHECK_INDEX((index >= self.count), index, return);

    [self ys_removeObjectAtIndex:index];
}


- (void)ys_insertObject:(id)anObject atIndex:(NSInteger)index {
    YS_NURSE_CHECK_PARAM_IS_NIL(anObject, YES, return);    
    YS_NURSE_CHECK_INDEX((index < 0), index, return);
    YS_NURSE_CHECK_INDEX((index > self.count), index, index = self.count);   // if index is larger than self.count, add object at the last of array

    [self ys_insertObject:anObject atIndex:index];
}


- (void)ys_addObject:(id)anObject {
    YS_NURSE_CHECK_PARAM_IS_NIL(anObject, YES, return);
    
    [self ys_addObject:anObject];
}

@end



#pragma mark - Category Of YSNurse

@implementation YSNurse (Array)

+ (void)ys_arrayMethodSwizz {
    [self __arrayMethodSwizz];
    [self __mutableArrayMethodSwizz];
}


+ (void)__arrayMethodSwizz {
    Class clazz = objc_getClass("__NSArrayI");
    
    instanceMethodSwizz(clazz, @selector(subarrayWithRange:), @selector(ys_subarrayWithRange:));
    instanceMethodSwizz(clazz, @selector(objectsAtIndexes:), @selector(ys_objectsAtIndexes:));
    // instanceMethodSwizz(objc_getClass("__NSArray0"), @selector(objectAtIndex:), @selector(ys_objectAtIndex:));
    instanceMethodSwizz(clazz, @selector(objectAtIndex:), @selector(ys_objectAtIndex:));
    instanceMethodSwizz(clazz, @selector(arrayByAddingObject:), @selector(ys_arrayByAddingObject:));
    
    classMethodSwizz(clazz, @selector(arrayWithObjects:count:), @selector(ys_arrayWithObjects:count:));
}


+ (void)__mutableArrayMethodSwizz {
    Class clazz = objc_getClass("__NSArrayM");
    
    
    instanceMethodSwizz(clazz,
                        @selector(replaceObjectsAtIndexes:withObjects:),
                        @selector(ys_replaceObjectsAtIndexes:withObjects:));
    instanceMethodSwizz(clazz, @selector(removeObjectsAtIndexes:), @selector(ys_removeObjectsAtIndexes:));
    instanceMethodSwizz(clazz, @selector(insertObjects:atIndexes:), @selector(ys_insertObjects:atIndexes:));
    instanceMethodSwizz(clazz,
                        @selector(replaceObjectsInRange:withObjectsFromArray:range:),
                        @selector(ys_replaceObjectsInRange:withObjectsFromArray:range:));
    instanceMethodSwizz(clazz, @selector(removeObjectsInRange:), @selector(ys_removeObjectsInRange:));
    instanceMethodSwizz(clazz,
                        @selector(removeObjectIdenticalTo:inRange:),
                        @selector(ys_removeObjectIdenticalTo:inRange:));
    instanceMethodSwizz(clazz,
                        @selector(exchangeObjectAtIndex:withObjectAtIndex:),
                        @selector(ys_exchangeObjectAtIndex:withObjectAtIndex:));
   
    instanceMethodSwizz(clazz,
                        @selector(replaceObjectAtIndex:withObject:),
                        @selector(ys_replaceObjectAtIndex:withObject:));
    instanceMethodSwizz(clazz, @selector(removeObjectAtIndex:), @selector(ys_removeObjectAtIndex:));
    instanceMethodSwizz(clazz, @selector(insertObject:atIndex:), @selector(ys_insertObject:atIndex:));
    instanceMethodSwizz(clazz, @selector(addObject:), @selector(ys_addObject:));
}

@end
