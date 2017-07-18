//
//  YSDictionaryTestViewController.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/1/6.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSDictionaryTestViewController.h"

@interface YSDictionaryTestViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YSDictionaryTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.tableView.frame style:UITableViewStyleGrouped];
    
    
    _dataArray = [NSMutableArray array];
    NSMutableArray *arrayData = [NSMutableArray arrayWithObjects:
                                 @"dictionaryWithObjects:forKeys:count:",
                                 @"initWithObjects:forKeys:",
                                 @"dictionaryWithObjects:forKeys:", nil];
    NSMutableArray *arrayMData = [NSMutableArray arrayWithObjects:
                                  @"setObject:forKey:",
                                  @"removeObjectForKey:", nil];
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
            NSString *keys[4];
            NSNumber *values[5];
            for (int i = 0; i < 4; i++) {
                char charValue = 'a' + i;
                keys[i] = [NSString stringWithFormat:@"%c", charValue];
            }
            for (int i = 0; i < 5; i++) {
                values[i] = [NSNumber numberWithInt:i];
            }
            
            // 1. different length
            NSDictionary *dict = [NSDictionary dictionaryWithObjects:values forKeys:keys count:5];
            
            // 2. objects or keys is nil, but count is not 0
            NSDictionary *dict1 = [NSDictionary dictionaryWithObjects:nil forKeys:nil count:5];

            NSLog(@"dict: %@", dict);
            NSLog(@"dict1: %@", dict1);
        }
        else if (indexPath.row == 1) {
            // 1. objects is nil
            NSDictionary *dict = [[NSDictionary alloc] initWithObjects:nilArray forKeys:@[@"name", @"gender", @"age"]];
            NSLog(@"dict: %@", dict);
            
            // 2. objects is empty
            NSDictionary *dict1 = [[NSDictionary alloc] initWithObjects:emptyArray forKeys:@[@"name", @"gender", @"age"]];
            NSLog(@"dict1: %@", dict1);
            
            // 3. keys is nil
            NSDictionary *dict2 = [[NSDictionary alloc] initWithObjects:@[@"Joseph", @0] forKeys:nilArray];
            NSLog(@"dict2: %@", dict2);
            
            // 4. keys is nil
            NSDictionary *dict3 = [[NSDictionary alloc] initWithObjects:@[@"Joseph", @0] forKeys:emptyArray];
            NSLog(@"dict3: %@", dict3);
            
            // 5. objects'count is different of keys's
            NSDictionary *dict4 = [[NSDictionary alloc] initWithObjects:@[@"Joseph"] forKeys:@[@"name", @"gender", @"age"]];
            NSLog(@"dict4: %@", dict4);
            
            NSDictionary *dict5 = [[NSDictionary alloc] initWithObjects:@[@"Joseph", @0, @"iPhone"] forKeys:@[@"name"]];
            NSLog(@"dict5: %@", dict5);
        }
        else if (indexPath.row == 2) {
            // 1. objects is nil
            NSDictionary *dict = [NSDictionary dictionaryWithObjects:nilArray forKeys:@[@"name", @"gender", @"age"]];
            NSLog(@"dict: %@", dict);
            
            // 2. objects is empty
            NSDictionary *dict1 = [NSDictionary dictionaryWithObjects:emptyArray forKeys:@[@"name", @"gender", @"age"]];
            NSLog(@"dict1: %@", dict1);

            // 3. keys is nil
            NSDictionary *dict2 = [NSDictionary dictionaryWithObjects:@[@"Joseph", @0] forKeys:nilArray];
            NSLog(@"dict2: %@", dict2);

            // 4. keys is nil
            NSDictionary *dict3 = [NSDictionary dictionaryWithObjects:@[@"Joseph", @0] forKeys:emptyArray];
            NSLog(@"dict3: %@", dict3);

            // 5. objects'count is different of keys's
            NSDictionary *dict4 = [NSDictionary dictionaryWithObjects:@[@"Joseph"] forKeys:@[@"name", @"gender", @"age"]];
            NSLog(@"dict4: %@", dict4);

            NSDictionary *dict5 = [NSDictionary dictionaryWithObjects:@[@"Joseph", @0, @"iPhone"] forKeys:@[@"name"]];
            NSLog(@"dict5: %@", dict5);
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
            // 1. nil object test
            [dictM setObject:nilStr forKey:@"name"];
            
            // 2. nil key test
            [dictM setObject:@"Joseph" forKey:nilStr];
        }
        else if (indexPath.row == 1) {
            NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
            // 1. nil key test
            [dictM removeObjectForKey:nilStr];
        }
    }
}

#pragma clang diagnostic pop


@end
