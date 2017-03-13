

//
//  TQLaunchServiceViewController.m
//  wegoal
//
//  Created by joker on 2017/3/13.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQLaunchServiceViewController.h"
#import "TQMatchServiceCell.h"
#import "TQLaunchConfirmViewController.h"

#define kTQMatchServiceCellIdentifier     @"TQMatchServiceCell"
@interface TQLaunchServiceViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *amountsArray;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *nextStep;

@end

@implementation TQLaunchServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"约战服务";
    self.view.backgroundColor = kMainBackColor;
    _amountsArray = [NSMutableArray array];
    //初始化选中，数量
    for (NSInteger i = 0; i < 10; i++) {
        [_amountsArray addObject:[NSMutableDictionary dictionaryWithDictionary:@{@"selected":@(NO),
                                                                                 @"amount":@(0)}]
         ];
    }
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.nextStep];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, VIEW_HEIGHT - 47) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kMainBackColor;
        [_tableView registerNib:[UINib nibWithNibName:@"TQMatchServiceCell" bundle:nil] forCellReuseIdentifier:kTQMatchServiceCellIdentifier];
    }
    return _tableView;
}

- (UIButton *)nextStep
{
    if (!_nextStep) {
        _nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextStep.frame = CGRectMake(0, VIEW_HEIGHT - 44, SCREEN_WIDTH, 44);
        _nextStep.backgroundColor = kSubjectBackColor;
        [_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
        _nextStep.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextStep addTarget:self action:@selector(nextStepAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStep;
}


#pragma mark - events

- (void)nextStepAction
{
    TQLaunchConfirmViewController *launchConfirmVC = [[TQLaunchConfirmViewController alloc] init];
    [self.navigationController pushViewController:launchConfirmVC animated:YES];
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQMatchServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMatchServiceCellIdentifier];
    if (!cell) {
        NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"TQMatchServiceCell" owner:nil options:nil].firstObject;
        cell = xibs.firstObject;
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < _amountsArray.count) {
        NSMutableDictionary *dic = _amountsArray[indexPath.row];
        [cell setSelected:[dic[@"selected"] boolValue] andAmount:[dic[@"amount"] unsignedIntegerValue]];
    } else {
        [cell setSelected:NO andAmount:0];
    }
    cell.canSelected = YES;
    __weak typeof(self) weakSelf = self;
    cell.selectBlk = ^(BOOL isSelected){
        NSMutableDictionary *dic = weakSelf.amountsArray[indexPath.row];
        dic[@"selected"] = @(isSelected);
    };
    cell.amountBlk = ^(NSUInteger newAmount){
        NSMutableDictionary *dic = weakSelf.amountsArray[indexPath.row];
        dic[@"amount"] = @(newAmount);
    };
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}



@end
