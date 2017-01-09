//
//  YSAttributeStringTestViewController.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/1/6.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSAttributeStringTestViewController.h"

@interface YSAttributeStringTestViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YSAttributeStringTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.tableView.frame style:UITableViewStyleGrouped];
    
    
    _dataArray = [NSMutableArray array];
    NSMutableArray *arrayData = [NSMutableArray arrayWithObjects:
                                 @"initWithString:",
                                 @"attributedSubstringFromRange:",
                                 @"initWithString:attributes:", nil];
    NSMutableArray *arrayMData = [NSMutableArray arrayWithObjects:
                                  @"deleteCharactersInRange:",
                                  @"insertAttributedString:atIndex:",
                                  @"replaceCharactersInRange:withString:",
                                  @"initWithString:",
                                  @"initWithString:attributes:", nil];
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
    NSString *str     = @"Nurse";
    NSAttributedString *nilAttrStr = nil;
    NSAttributedString *result = nil;

    NSIndexSet *nilSet   = nil;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            // param is nil
            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:nilStr];
            NSLog(@"attrStr: %@", attrStr);
            
        }
        else if (indexPath.row == 1) {
            NSAttributedString *emptyAttrStr = [[NSAttributedString alloc] init];
            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"HelloWorld"];
            
            // 1. empty test, error range
            result = [emptyAttrStr attributedSubstringFromRange:NSMakeRange(-1, 5)];
            NSLog(@"result: %@", result);
            
            // 2. empty test, range out of attribute string's length
            result = [emptyAttrStr attributedSubstringFromRange:NSMakeRange(5, 10)];
            NSLog(@"result: %@", result);
            
            // 3. error range
            result = [attrStr attributedSubstringFromRange:NSMakeRange(-1, 5)];
            NSLog(@"result: %@", result);
            
            // 4. range out of attribute string's length
            result = [attrStr attributedSubstringFromRange:NSMakeRange(5, 10)];
            NSLog(@"result: %@", result);
        }
        else if (indexPath.row == 2) {
            // param is nil
            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:nilStr attributes:nil];
            NSLog(@"attrStr: %@", attrStr);
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSMutableAttributedString *emptyAttrStrM = [[NSMutableAttributedString alloc] initWithString:@""];
            NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:@"HelloWorld"];
            
            // 1. empty test, error range
            [emptyAttrStrM deleteCharactersInRange:NSMakeRange(-1, 10)];
            NSLog(@"emptyAttrStrM: %@", emptyAttrStrM);
            
            // 2. empty test, range out of attribute string's length
            [emptyAttrStrM deleteCharactersInRange:NSMakeRange(5, 10)];
            NSLog(@"emptyAttrStrM: %@", emptyAttrStrM);
            
            // 3. error range
            [attrStrM deleteCharactersInRange:NSMakeRange(-1, 2)];
            NSLog(@"attrStrM: %@", attrStrM);
            
            // 4. range out of attribute string's length
            [attrStrM deleteCharactersInRange:NSMakeRange(5, 10)];
            NSLog(@"attrStrM: %@", attrStrM);
        }
        else if (indexPath.row == 1) {
            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:str];
            NSMutableAttributedString *emptyAttrStrM = [[NSMutableAttributedString alloc] initWithString:@""];
            NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:@"HelloWorld"];
            
            // 1. empty test, param is nil
            [emptyAttrStrM insertAttributedString:nilAttrStr atIndex:0];
            NSLog(@"emptyAttrStrM: %@", emptyAttrStrM);

            // 2. empty test, error index
            [emptyAttrStrM insertAttributedString:attrStr atIndex:-1];
            NSLog(@"emptyAttrStrM: %@", emptyAttrStrM);

            // 3. empty test, index out of mutable attributed string's length
            [emptyAttrStrM insertAttributedString:attrStr atIndex:5];
            NSLog(@"emptyAttrStrM: %@", emptyAttrStrM);
            
            // 4. param is nil
            [attrStrM insertAttributedString:nilAttrStr atIndex:0];
            NSLog(@"attrStrM: %@", attrStrM);
            
            // 5. error index
            [attrStrM insertAttributedString:attrStr atIndex:-1];
            NSLog(@"attrStrM: %@", attrStrM);
            
            // 6. index out of mutable attributed string's length
            [attrStrM insertAttributedString:attrStr atIndex:5];
            NSLog(@"attrStrM: %@", attrStrM);
        }
        else if (indexPath.row == 2) {
            NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:str];
            NSMutableAttributedString *emptyAttrStrM = [[NSMutableAttributedString alloc] initWithString:@""];
            NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:@"HelloWorld"];
            
            // 1. empty test, error index
            [emptyAttrStrM replaceCharactersInRange:NSMakeRange(-1, 5) withString:str];
            NSLog(@"emptyAttrStrM: %@", emptyAttrStrM);
            
            // 2. param is nil
            [attrStrM replaceCharactersInRange:NSMakeRange(0, 5) withString:nilStr];
            NSLog(@"attrStrM: %@", attrStrM);
            
            // 3. error range
            [attrStrM replaceCharactersInRange:NSMakeRange(-1, 5) withString:str];
            NSLog(@"attrStrM: %@", attrStrM);
            
            // 4. range out of mutable attributed string's length
            [attrStrM replaceCharactersInRange:NSMakeRange(5, 15) withString:str];
            NSLog(@"attrStrM: %@", attrStrM);
        }
        else if (indexPath.row == 3) {
            // param is nil
            NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:nilStr];
            NSLog(@"attrStrM: %@", attrStrM);
        }
        else if (indexPath.row == 4) {
            // param is nil
            NSMutableAttributedString *attrStrM = [[NSMutableAttributedString alloc] initWithString:nilStr attributes:nil];
            NSLog(@"attrStrM: %@", attrStrM);
        }
    }
}

#pragma clang diagnostic pop

@end
