//
//  YSArrayTestViewController.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/1/6.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSArrayTestViewController.h"

@interface YSArrayTestViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YSArrayTestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.tableView.frame style:UITableViewStyleGrouped];

    
    _dataArray = [NSMutableArray array];
    NSMutableArray *arrayData = [NSMutableArray arrayWithObjects:
                                  @"subarrayWithRange:",
                                  @"objectsAtIndexes:",
                                  @"objectAtIndex:",
                                  @"arrayByAddingObject:",
                                  @"arrayWithObjects:count:", nil];
    NSMutableArray *arrayMData = [NSMutableArray arrayWithObjects:
                                  @"replaceObjectsAtIndexes:withObjects:",
                                  @"removeObjectsAtIndexes:",
                                  @"insertObjects:atIndexes:",
                                  @"replaceObjectsInRange:withObjectsFromArray:range:",
                                  @"removeObjectsInRange:",
                                  @"removeObjectIdenticalTo:inRange:",
                                  @"exchangeObjectAtIndex:withObjectAtIndex:",
                                  @"replaceObjectAtIndex:withObject:",
                                  @"removeObjectAtIndex:",
                                  @"insertObject:atIndex:",
                                  @"addObject:", nil];
    [_dataArray addObjectsFromArray:@[arrayData, arrayMData]];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray[section] count];
}

static NSString *const kReuseID = @"kReuseID";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReuseID];
    }
    cell.textLabel.text = [_dataArray[indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *nilStr     = nil;
    NSArray *result      = nil;
    NSArray *nilArray    = nil;
    NSArray *emptyArray  = @[];
    NSIndexSet *nilSet   = nil;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSArray *array = @[@0, @1, @2, @3, @4];
            result = [array subarrayWithRange:NSMakeRange(-1, 8)];
            NSLog(@"result : %@", result);
        }
        else if (indexPath.row == 1) {
            NSArray *array = @[@0, @1, @2, @3, @4];
            NSMutableIndexSet *setM = [NSMutableIndexSet indexSetWithIndex:-1];
            [setM addIndex:0];
            [setM addIndex:5];
            result = [array objectsAtIndexes:setM];
            NSLog(@"result : %@", result);
        }
        else if (indexPath.row == 2) {
            NSArray *array = @[@0, @1, @2, @3, @4];
            id obj1 = [array objectAtIndex:-1];
            id obj2 = [array objectAtIndex:8];
            NSLog(@"result : %@", array);
            
        }
        else if (indexPath.row == 3) {
            NSArray *array = @[@0, @1, @2, @3, @4];
            result = [array arrayByAddingObject:nilStr];
            NSLog(@"result : %@", result);
        }
        else if (indexPath.row == 4) {
            NSString *strings[3];
            strings[0] = @"First";
            strings[1] = nilStr;
            strings[2] = @"Third";
            /// TODO: It will cause EXC_BAD_ACCESS Error if cnt is bigger than objects' length.
            result = [NSArray arrayWithObjects:strings count:2];
            NSLog(@"result : %@", result);
        }
    }
    else {
        if (indexPath.row == 0) {
            NSMutableArray *arrayM = [NSMutableArray array];
            NSIndexSet *set1 = [NSIndexSet indexSetWithIndex:8];    // out of bound
            NSArray *objects = @[@"A", @"B", @"C"];
            // 1. empty test
            [arrayM replaceObjectsAtIndexes:set1 withObjects:objects];
            
            // 2. indexes is nil or NUll
            [arrayM replaceObjectsAtIndexes:nilSet withObjects:objects];

            // 3. indexes'count is not equal to objects'
            [arrayM addObjectsFromArray:@[@"a", @"b", @"c", @"d", @"e"]];
            NSMutableIndexSet *setM = [NSMutableIndexSet indexSetWithIndex:0];
            [setM addIndex:4];
            [setM addIndex:8];
            [setM addIndex:5];
            [arrayM replaceObjectsAtIndexes:setM withObjects:objects];
        }
        else if (indexPath.row == 1) {
            NSMutableArray *arrayM = [NSMutableArray array];
            
            // 1. nil index set
            [arrayM removeObjectsAtIndexes:nilSet];

            // 2. empty test
            NSMutableIndexSet *set = [NSMutableIndexSet indexSetWithIndex:0];
            [set addIndex:8];
            [arrayM removeObjectsAtIndexes:set];

            // 3. out of array's bounds
            [arrayM addObjectsFromArray:@[@"a", @"b", @"c", @"d", @"e"]];
            [arrayM removeObjectsAtIndexes:set];
            NSLog(@"%@", arrayM);
        }
        else if (indexPath.row == 2) {
            NSMutableArray *arrayM = [NSMutableArray array];
            // 1. array is nil
            NSArray *pArray = @[@"a", @"b", @"c", @"d", @"e"];
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:8];
            [arrayM insertObjects:nilArray atIndexes:set];
            
            // 2. index set is nil or NULL
            [arrayM insertObjects:pArray atIndexes:nilSet];
            
            // 3. index out of array's bounds
            NSMutableIndexSet *setM = [NSMutableIndexSet indexSetWithIndex:0];
            [setM addIndexesInRange:NSMakeRange(1, 8)];
            [arrayM insertObjects:pArray atIndexes:setM];
            NSLog(@"%@", arrayM);
        }
        else if (indexPath.row == 3) {
            NSMutableArray *arrayM = [NSMutableArray array];
            NSArray *pArray = @[@"a", @"b", @"c", @"d", @"e"];
            // 1. empty test, error range
            [arrayM replaceObjectsInRange:NSMakeRange(-1, 2) withObjectsFromArray:pArray range:NSMakeRange(0, 3)];
            
            // 2. error range
            [arrayM addObjectsFromArray:@[@1, @2, @3]];
            [arrayM replaceObjectsInRange:NSMakeRange(-1, 2) withObjectsFromArray:pArray range:NSMakeRange(0, 3)];
            
            // 3. nil Objects array
            [arrayM replaceObjectsInRange:NSMakeRange(0, 2) withObjectsFromArray:nilArray range:NSMakeRange(0, nilArray.count)];
            
            // 4. empty objects array
            [arrayM replaceObjectsInRange:NSMakeRange(0, 2) withObjectsFromArray:emptyArray range:NSMakeRange(0, emptyArray.count)];
            
            // 5. error Objects array's range
            [arrayM replaceObjectsInRange:NSMakeRange(0, 2) withObjectsFromArray:pArray range:NSMakeRange(0, 8)];

            NSLog(@"%@", arrayM);

        }
        else if (indexPath.row == 4) {
            NSMutableArray *arrayM = [NSMutableArray array];
            // 1. error range
            [arrayM removeObjectsInRange:NSMakeRange(-1, 8)];
            
            // 2.
            [arrayM addObjectsFromArray:@[@"a", @"b", @"c", @"d", @"e"]];
            [arrayM removeObjectsInRange:NSMakeRange(-1, 8)];

            // 3. range out of array's bound
            [arrayM removeObjectsInRange:NSMakeRange(0, 8)];
            
            NSLog(@"%@", arrayM);
        }
        else if (indexPath.row == 5) {
            NSMutableArray *arrayM = [NSMutableArray array];
            // 1. empty test, error range
            [arrayM removeObjectIdenticalTo:nilStr inRange:NSMakeRange(-1, 1)];
            
            // 2. error range
            [arrayM addObjectsFromArray:@[@"a", @"b", @"c", @"d", @"e"]];
            [arrayM removeObjectIdenticalTo:nilStr inRange:NSMakeRange(-1, 8)];
            
            // 3.
            [arrayM removeObjectIdenticalTo:nilStr inRange:NSMakeRange(3, 8)];
            
            NSLog(@"%@", arrayM);
        }
        else if (indexPath.row == 6) {
            NSMutableArray *arrayM = [NSMutableArray array];
            
            // 1. empty test, error index
            [arrayM exchangeObjectAtIndex:0 withObjectAtIndex:1];
            
            // 2. empty test, index out of array's bound
            [arrayM exchangeObjectAtIndex:-1 withObjectAtIndex:1];
            
            [arrayM addObjectsFromArray:@[@"a", @"b", @"c", @"d", @"e"]];
            // 3. error index
            [arrayM exchangeObjectAtIndex:-1 withObjectAtIndex:8];
            
            // 4. empty test, index out of array's bound
            [arrayM exchangeObjectAtIndex:0 withObjectAtIndex:8];
            
            NSLog(@"%@", arrayM);
        }
        else if (indexPath.row == 7) {
            NSMutableArray *arrayM = [NSMutableArray array];
            
            // 1. empty test, error index
            [arrayM replaceObjectAtIndex:-1 withObject:@"A"];
            // 2. empty test, nil object
            [arrayM replaceObjectAtIndex:1 withObject:nilStr];
            
            
            [arrayM addObjectsFromArray:@[@"a", @"b", @"c", @"d", @"e"]];
            // 3. error index
            [arrayM replaceObjectAtIndex:-1 withObject:@"A"];
            
            // 4. empty test, index out of array's bound
            [arrayM replaceObjectAtIndex:1 withObject:nilStr];
            NSLog(@"%@", arrayM);
        }
        else if (indexPath.row == 8) {
            NSMutableArray *arrayM = [NSMutableArray array];

            // 1. empty test, error index
            [arrayM removeObjectAtIndex:-1];
            
            // 2. empty test, index out of array's bound
            [arrayM removeObjectAtIndex:8];
            
            [arrayM addObjectsFromArray:@[@"a", @"b", @"c", @"d", @"e"]];
            
            // 3. error index
            [arrayM removeObjectAtIndex:-1];
            
            // 4. index out of array's bound
            [arrayM removeObjectAtIndex:8];
            
            NSLog(@"%@", arrayM);
        }
        else if (indexPath.row == 9) {
            NSMutableArray *arrayM = [NSMutableArray array];
            
            // 1. empty test, error index
            [arrayM insertObject:@"A" atIndex:-1];
            
            // 2. empty test, index out of array's bound
            [arrayM insertObject:@"A" atIndex:1];
            
            // 3. nil object
            [arrayM insertObject:nilStr atIndex:0];
            
            
            [arrayM addObjectsFromArray:@[@"a", @"b", @"c", @"d", @"e"]];
            
            // 4. error index
            [arrayM insertObject:@"A" atIndex:-1];

            // 5. index out of array's bound
            [arrayM insertObject:@"A" atIndex:8];
            
            // 6. nil object
            [arrayM insertObject:nilStr atIndex:3];
            
            NSLog(@"%@", arrayM);
        }
        else if (indexPath.row == 10) {
            NSMutableArray *arrayM = [NSMutableArray array];
            
            // 1. empty test, nil object
            [arrayM addObject:nilStr];
            
            [arrayM addObjectsFromArray:@[@"a", @"b", @"c", @"d", @"e"]];
            
            // 2. nil object
            [arrayM addObject:nilStr];
            
            NSLog(@"%@", arrayM);
        }
    }
    
}
#pragma clang diagnostic pop


@end
