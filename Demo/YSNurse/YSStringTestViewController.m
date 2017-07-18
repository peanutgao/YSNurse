//
//  YSStringTestViewController.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/1/6.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSStringTestViewController.h"

@interface YSStringTestViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YSStringTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.tableView.frame style:UITableViewStyleGrouped];
    
    
    _dataArray = [NSMutableArray array];
    NSMutableArray *arrayData = [NSMutableArray arrayWithObjects:
                                 @"stringByReplacingCharactersInRange:withString:",
                                 @"stringByReplacingOccurrencesOfString:withString:options:range:",
                                 @"stringByPaddingToLength:withString:startingAtIndex:",
                                 @"rangeOfComposedCharacterSequenceAtIndex:",
                                 @"rangeOfComposedCharacterSequencesForRange:",
                                 @"getCharacters:range:",
                                 @"substringWithRange:",
                                 @"substringToIndex:",
                                 @"substringFromIndex:", nil];
    NSMutableArray *arrayMData = [NSMutableArray arrayWithObjects:
                                  @"replaceOccurrencesOfString:withString:options:range:",
                                  @"setString:",
                                  @"appendString:",
                                  @"replaceCharactersInRange:withString:",
                                  @"insertString:atIndex:",
                                  @"deleteCharactersInRange:", nil];
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
    NSString *emptyStr   = @"";
    NSString *rpString   = @"Nurse";
    NSString *result     = nil;
    NSIndexSet *nilSet   = nil;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString *str = @"HelloWorld";
            
            // 1. empty string test
            [emptyStr stringByReplacingCharactersInRange:NSMakeRange(-1, 1) withString:rpString];
            
            // 2.
            [str stringByReplacingCharactersInRange:NSMakeRange(-1, 15) withString:rpString];
            
            // 3. replaced by nil string
            [str stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:nilStr];
        }
        else if (indexPath.row == 1) {
            NSString *str = @"HelloWorld";

            // 1. empty string test, target string is nil
            NSString *result1 = [emptyStr stringByReplacingOccurrencesOfString:nilStr
                                                                    withString:rpString
                                                                       options:NSCaseInsensitiveSearch
                                                                         range:NSMakeRange(0, 0)];
            NSLog(@"result1 : %@", result1);

            
            // 2. empty string test, replacement is nil
            NSString *result2 = [emptyStr stringByReplacingOccurrencesOfString:emptyStr
                                                                    withString:nilStr
                                                                       options:NSCaseInsensitiveSearch
                                                                         range:NSMakeRange(0, 0)];
            NSLog(@"result2 : %@", result2);

            
            // 3. empty string test, error range
            NSString *result3 = [emptyStr stringByReplacingOccurrencesOfString:emptyStr
                                                                    withString:rpString
                                                                       options:NSCaseInsensitiveSearch
                                                                         range:NSMakeRange(-1, 10)];
            NSLog(@"result3 : %@", result3);

            
            // 4. target string is nil
            NSString *result4 = [str stringByReplacingOccurrencesOfString:nilStr
                                                               withString:rpString
                                                                  options:NSCaseInsensitiveSearch
                                                                    range:NSMakeRange(0, 10)];
            NSLog(@"result4 : %@", result4);

    
            // 5. replacement is nil
            NSString *result5 = [str stringByReplacingOccurrencesOfString:@"World"
                                                               withString:nilStr
                                                                  options:NSCaseInsensitiveSearch
                                                                    range:NSMakeRange(0, 10)];
            NSLog(@"result5 : %@", result5);

            // 6. error range
            NSString *result6 = [str stringByReplacingOccurrencesOfString:@"World"
                                                               withString:rpString
                                                                  options:NSCaseInsensitiveSearch
                                                                    range:NSMakeRange(-1, 15)];
            NSLog(@"result6 : %@", result6);

            NSString *result7 = [str stringByReplacingOccurrencesOfString:@"World"
                                                               withString:rpString
                                                                  options:NSCaseInsensitiveSearch
                                                                    range:NSMakeRange(10, 10)];
            NSLog(@"result7 : %@", result7);

        }
        else if (indexPath.row == 2) {
            NSString *str = @"HelloWorld";
            // 1. empty string test, padding string is nil
            NSString *result1 = [emptyStr stringByPaddingToLength:8 withString:nilStr startingAtIndex:0];
            NSLog(@"result1 : %@", result1);

            // 2. empty string test, padding string is empty, out of padding string's bound;
            NSString *result2 = [emptyStr stringByPaddingToLength:8 withString:emptyStr startingAtIndex:5];
            NSLog(@"result2 : %@", result2);

            // 3. padding string is nil
            NSString *result3 = [str stringByPaddingToLength:8 withString:nilStr startingAtIndex:0];
            NSLog(@"result3 : %@", result3);

            // 4. empty string test, padding string is empty, out of padding string's bound;
            NSString *result4 = [str stringByPaddingToLength:8 withString:emptyStr startingAtIndex:5];
            NSLog(@"result4 : %@", result4);

            // 5. empty string test, padding string is empty, out of padding string's bound;
            NSString *result5 = [str stringByPaddingToLength:8 withString:rpString startingAtIndex:8];
            NSLog(@"result5 : %@", result5);

        }
        else if (indexPath.row == 3) {
            NSString *str = @"HelloWorld";
            // 1. error index
            NSRange range1 = [str rangeOfComposedCharacterSequenceAtIndex:-1];
            NSLog(@"range1: %@", NSStringFromRange(range1));
            
            // 2. out of string's bound
            NSRange range2 = [str rangeOfComposedCharacterSequenceAtIndex:15];
            NSLog(@"range2: %@", NSStringFromRange(range2));
        }
        else if (indexPath.row == 4) {
            NSString *str = @"HelloWorld";
            // 1. empty string test, error range
            NSRange range1 = [emptyStr rangeOfComposedCharacterSequencesForRange:NSMakeRange(-1, 10)];
            NSLog(@"range1: %@", NSStringFromRange(range1));
            
            // 2. empty string test, out of string's bound
            NSRange range2 = [emptyStr rangeOfComposedCharacterSequencesForRange:NSMakeRange(1, 15)];
            NSLog(@"range2: %@", NSStringFromRange(range2));
            
            // 1. empty string test, error range
            NSRange range3 = [str rangeOfComposedCharacterSequencesForRange:NSMakeRange(-1, 10)];
            NSLog(@"range3: %@", NSStringFromRange(range3));
            
            // 2. empty string test, out of string's bound
            NSRange range4 = [str rangeOfComposedCharacterSequencesForRange:NSMakeRange(1, 15)];
            NSLog(@"range4: %@", NSStringFromRange(range4));
            
            
            NSRange range5 = [@"A" rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 2)];
            NSLog(@"range5: %@", NSStringFromRange(range4));
            
        }
        else if (indexPath.row == 5) {
            NSString *str = @"HelloWorld";
            int cnt = 13;
            unichar chr[cnt];
            
            // cnt out of string's bound
            [str getCharacters:chr range:[str rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, cnt)]];
            
            result = [[NSString alloc] initWithCharacters:chr length:cnt];
            
            NSInteger normalCnt = str.length;
            unichar normalChr[normalCnt];
            [str getCharacters:normalChr range:[str rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, normalCnt)]];
            NSString *normalResult = [[NSString alloc] initWithCharacters:normalChr length:normalCnt];
            
            // result is different with normal result because of cnt is wrong
            NSLog(@"\nnormalResult: %@ \nresult:       %@", normalResult, result);
        }
        else if (indexPath.row == 6) {
            NSString *str = @"HelloWorld";
            
            // 1. empty test, error range
            NSString *result1 = [emptyStr substringWithRange:NSMakeRange(-1, 5)];
            NSLog(@"result1 : %@", result1);
            
            // 2. range out of string's bound
            NSString *result2 = [str substringWithRange:NSMakeRange(0, 15)];
            NSLog(@"result2 : %@", result2);
            
            // 3. loc out of string's bound
            NSString *result3 = [str substringWithRange:NSMakeRange(10, 15)];
            NSLog(@"result3 : %@", result3);

        }
        else if (indexPath.row == 7) {
            NSString *str = @"HelloWorld";
            
            // 1. empty test
            NSString *result1 = [emptyStr substringToIndex:10];
            NSLog(@"result1 : %@", result1);

            // 2. index out of string's bound
            NSString *result2 = [str substringToIndex:10];
            NSLog(@"result2 : %@", result2);
        }
        else if (indexPath.row == 8) {
            NSString *str = @"HelloWorld";
            
            // 1. empty test
            NSString *result1 = [emptyStr substringFromIndex:1];
            NSLog(@"result1 : %@", result1);
            
            // 2. index out of string's bound
            NSString *result2 = [str substringFromIndex:15];
            NSLog(@"result2 : %@", result2);
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSMutableString *emptyStrM = [NSMutableString string];
            NSMutableString *strM = [NSMutableString stringWithString:@"HelloWorld"];
        
            // 1. empty string test, target string is nil
            NSUInteger result1 = [emptyStrM replaceOccurrencesOfString:nilStr
                                                            withString:rpString
                                                               options:NSCaseInsensitiveSearch
                                                                 range:NSMakeRange(0, 0)];
            NSLog(@"result1 : %zd", result1);
            
            
            // 2. empty string test, replacement is nil
            NSUInteger result2 = [emptyStrM replaceOccurrencesOfString:emptyStr
                                                            withString:nilStr
                                                               options:NSCaseInsensitiveSearch
                                                                 range:NSMakeRange(0, 0)];
            NSLog(@"result2 : %zd", result2);
            
            
            // 3. empty string test, error range
            NSUInteger result3 = [emptyStrM replaceOccurrencesOfString:emptyStr
                                                            withString:rpString
                                                               options:NSCaseInsensitiveSearch
                                                                 range:NSMakeRange(-1, 10)];
            NSLog(@"result3 : %zd", result3);
            
            
            // 4. target string is nil
            NSUInteger result4 = [strM replaceOccurrencesOfString:nilStr
                                                       withString:rpString
                                                          options:NSCaseInsensitiveSearch
                                                            range:NSMakeRange(0, 10)];
            NSLog(@"result4 : %zd", result4);
            
            
            // 5. replacement is nil
            NSUInteger result5 = [strM replaceOccurrencesOfString:@"World"
                                                       withString:nilStr
                                                          options:NSCaseInsensitiveSearch
                                                            range:NSMakeRange(0, 10)];
            NSLog(@"result5 : %zd", result5);
            
            // 6. error range
            NSUInteger result6 = [strM replaceOccurrencesOfString:@"World"
                                                       withString:rpString
                                                          options:NSCaseInsensitiveSearch
                                                            range:NSMakeRange(-1, 15)];
            NSLog(@"result6 : %zd", result6);
            
            NSUInteger result7 = [strM replaceOccurrencesOfString:@"World"
                                                       withString:rpString
                                                          options:NSCaseInsensitiveSearch
                                                            range:NSMakeRange(10, 10)];
            NSLog(@"result7 : %zd", result7);

        }
        else if (indexPath.row == 1) {
            NSMutableString *strM = [NSMutableString stringWithString:@"HelloWorld"];
            // nil param
            [strM setString:nilStr];
        }
        else if (indexPath.row == 2) {
            NSMutableString *strM = [NSMutableString stringWithString:@"HelloWorld"];
            // nil param
            [strM appendString:nilStr];
        }
        else if (indexPath.row == 3) {
            /// system also call the function of replaceCharactersInRange:withString, just use @try-@catch to avoid crash
            NSMutableString *strM = [NSMutableString stringWithString:@"HelloWorld"];
            // 1. nil param
            [strM replaceCharactersInRange:NSMakeRange(0, 0) withString:nilStr];
            NSLog(@"strM: %@", strM);
            
            // 2. range out of string's length
            [strM replaceCharactersInRange:NSMakeRange(-1, 15) withString:rpString];
            NSLog(@"strM: %@", strM);
            
            [strM replaceCharactersInRange:NSMakeRange(5, 15) withString:rpString];
            NSLog(@"strM: %@", strM);
            

        }
        else if (indexPath.row == 4) {
            NSMutableString *emptyStrM = [NSMutableString stringWithString:@""];
            NSMutableString *strM = [NSMutableString stringWithString:@"HelloWorld"];
            
            // 1. empty test, nil param
            [emptyStrM insertString:nilStr atIndex:0];
            NSLog(@"emptyStrM: %@", emptyStrM);
            
            // 2. empty test, index out of string's length
            [emptyStrM insertString:rpString atIndex:5];
            NSLog(@"emptyStrM: %@", emptyStrM);

            // 3. nil param
            [strM insertString:nilStr atIndex:0];
            NSLog(@"strM: %@", strM);
            
            // 4. index out of string's length
            [emptyStrM insertString:rpString atIndex:15];
            NSLog(@"strM: %@", strM);
            
        }
        else if (indexPath.row == 5) {
            NSMutableString *emptyStrM = [NSMutableString stringWithString:@""];
            NSMutableString *strM = [NSMutableString stringWithString:@"HelloWorld"];
            
            // 1. empty test, error range
            [emptyStrM deleteCharactersInRange:NSMakeRange(-1, 5)];
            NSLog(@"emptyStrM: %@", emptyStrM);
            
            // 2. empty test, range out of string's length
            [emptyStrM deleteCharactersInRange:NSMakeRange(0, 5)];
            NSLog(@"emptyStrM: %@", emptyStrM);
            
            // 3. error range
            [strM deleteCharactersInRange:NSMakeRange(-1, 5)];
            NSLog(@"strM: %@", strM);
            
            // 4. range out of string's length
            [strM deleteCharactersInRange:NSMakeRange(5, 15)];
            NSLog(@"strM: %@", strM);
            
            [emptyStrM deleteCharactersInRange:NSMakeRange(10, 5)];
            NSLog(@"strM: %@", strM);
            
        }
    }
}

#pragma clang diagnostic pop


@end
