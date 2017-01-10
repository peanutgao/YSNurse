//
//  YSMainMenuViewController.m
//  YSNurse
//
//  Created by Joseph Gao on 2017/1/6.
//  Copyright © 2017年 Joseph. All rights reserved.
//

#import "YSMainMenuViewController.h"
#import "YSNurse.h"

@interface MainVCModel : NSObject

@property (nonatomic, copy) NSString *vcName;
@property (nonatomic, copy) NSString *desc;

+ (instancetype)vcModelWithVCName:(NSString *)vcName desc:(NSString *)desc;

@end


@implementation MainVCModel

+ (instancetype)vcModelWithVCName:(NSString *)vcName desc:(NSString *)desc {
    MainVCModel *model = [[self alloc] init];
    model.vcName = vcName;
    model.desc = desc;
    return model;
}

@end

@interface YSMainMenuViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation YSMainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavItem];
    [self combineDataArrayWithSuccesHandle:NULL];
}


#pragma mark - Action

- (void)switchAction:(UISwitch *)swc {
    [YSNurse shareInstance].debugEnable = swc.isOn;
}


#pragma mark - Combine Data

- (void)combineDataArrayWithSuccesHandle:(void(^)(void))successHandler {
    [self.dataArray addObject:[MainVCModel vcModelWithVCName:@"YSArrayTestViewController"
                                                        desc:@"Array Test"]];
    [self.dataArray addObject:[MainVCModel vcModelWithVCName:@"YSDictionaryTestViewController"
                                                        desc:@"Dictionary Test"]];
    [self.dataArray addObject:[MainVCModel vcModelWithVCName:@"YSStringTestViewController"
                                                        desc:@"String Test"]];
    [self.dataArray addObject:[MainVCModel vcModelWithVCName:@"YSAttributeStringTestViewController"
                                                        desc:@"AttributeString Test"]];
    [self.dataArray addObject:[MainVCModel vcModelWithVCName:@"YSNSObjectViewController"
                                                        desc:@"KVC Test"]];
    [self.dataArray addObject:[MainVCModel vcModelWithVCName:@"YSExceptionViewController"
                                                        desc:@"Unrecognized selector sent to instance Test"]];
    if (successHandler) {
        successHandler();
    }
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

static NSString *const kReuseID = @"kReuseID";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kReuseID];
    }
    MainVCModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.desc;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainVCModel *model = self.dataArray[indexPath.row];
    Class clazz = NSClassFromString(model.vcName);
    UIViewController *vc = [[clazz alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.navigationItem.title = model.desc;
    [self.navigationController pushViewController:[[clazz alloc] init] animated:YES];
}


#pragma mark - Lazy Loading 

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark - Setup UI

- (void)setupNavItem {
    UISwitch *swc = [[UISwitch alloc] init];
    swc.on = NO;
    [YSNurse shareInstance].debugEnable = !swc.on;
    [swc addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:swc];
}
@end
