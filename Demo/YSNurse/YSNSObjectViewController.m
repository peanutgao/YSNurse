//
//  YSNSObjectViewController.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/1/9.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSNSObjectViewController.h"

@interface YSStudent : NSObject

@property (nonatomic, copy) NSString *name;

@end

@implementation YSStudent

@end


@interface YSNSObjectViewController ()

@property (nonatomic, strong) YSStudent *student;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation YSNSObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _descLabel.text = @"  setValue:forKeyPath: \n  and\n  setValue:forKey: \n  just use @try-@catch to avoid exception";
    
    _student = [[YSStudent alloc] init];
}

- (IBAction)__setValueForKeyPathBtnAction {
    NSString *value = nil;
    NSString *key = nil;
    if (arc4random_uniform(3)/2 == 1) {
        value = @"Joseph";
    } else {
        key = @"name";
    }
    [_student setValue:value forKey:key];
}

- (IBAction)__setValueForKeyBtnAction {
    NSString *value = nil;
    NSString *key = nil;
    if (arc4random_uniform(3)/2 == 1) {
        value = @"Joseph";
    } else {
        key = @"name";
    }
    [_student setValue:value forKeyPath:key];
}


@end
