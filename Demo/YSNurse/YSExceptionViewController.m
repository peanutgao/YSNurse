//
//  YSExceptionViewController.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/1/9.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSExceptionViewController.h"

@interface YSExceptionViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation YSExceptionViewController

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // btn Test
    [_btn addTarget:self action:@selector(btnTest:) forControlEvents:UIControlEventTouchUpInside];
    
    // tap Gesture test
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(tapGestureTest:)];
    [_imgView addGestureRecognizer:tap];
    
}

#pragma clang diagnostic pop

@end
