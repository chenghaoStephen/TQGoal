//
//  TQAcceptServiceViewController.m
//  wegoal
//
//  Created by joker on 2017/4/22.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQAcceptServiceViewController.h"
#import "TQMatchServiceCell.h"
#import "TQselectedServicesCell.h"
#import "TQAcceptConfirmViewController.h"

#define kTQMatchServiceCellIdentifier     @"TQMatchServiceCell"
#define kTQselectedServicesCellIdentifier     @"TQselectedServicesCell"
@interface TQAcceptServiceViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *nextStep;

@end

@implementation TQAcceptServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"应战服务";
    self.view.backgroundColor = kMainBackColor;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.nextStep];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT - 44) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kMainBackColor;
        [_tableView registerNib:[UINib nibWithNibName:@"TQMatchServiceCell" bundle:nil] forCellReuseIdentifier:kTQMatchServiceCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"TQselectedServicesCell" bundle:nil] forCellReuseIdentifier:kTQselectedServicesCellIdentifier];
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
    TQAcceptConfirmViewController *acceptConfirmVC = [[TQAcceptConfirmViewController alloc] init];
    acceptConfirmVC.refereeData = _refereeData;
    NSArray *servicesFinal = [self getFinalServicesFrom:_servicesArray];
    acceptConfirmVC.servicesArray = servicesFinal;
    acceptConfirmVC.matchData = _matchData;
    [acceptConfirmVC reloadData];
    [self.navigationController pushViewController:acceptConfirmVC animated:YES];
}

- (NSArray *)getFinalServicesFrom:(NSArray *)array
{
    NSMutableArray *finalArray = [NSMutableArray array];
    for (TQServiceModel *serviceData in array) {
        if (serviceData.isSelected && serviceData.amount > 0) {
            [finalArray addObject:serviceData];
        }
    }
    return finalArray;
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return _servicesArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TQselectedServicesCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQselectedServicesCellIdentifier];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TQselectedServicesCell" owner:nil options:nil].firstObject;
        }
        cell.servicesArray = @[@"球", @"保险", @"洗衣", @"绿色能量包"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        TQMatchServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMatchServiceCellIdentifier];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TQMatchServiceCell" owner:nil options:nil].firstObject;
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.canSelected = YES;
        if (indexPath.row < _servicesArray.count) {
            TQServiceModel *serviceData = _servicesArray[indexPath.row];
            [cell setSelected:serviceData.isSelected andAmount:serviceData.amount];
            cell.serviceData = _servicesArray[indexPath.row];
        } else {
            [cell setSelected:NO andAmount:0];
            [cell clearInformation];
        }
        __weak typeof(self) weakSelf = self;
        cell.selectBlk = ^(BOOL isSelected){
            TQServiceModel *serviceData = weakSelf.servicesArray[indexPath.row];
            serviceData.isSelected = isSelected;
        };
        cell.amountBlk = ^(NSUInteger newAmount){
            TQServiceModel *serviceData = weakSelf.servicesArray[indexPath.row];
            serviceData.amount = newAmount;
        };
        return cell;
    }

}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 36.f;
    } else {
        return 80.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headerView.backgroundColor = kMainBackColor;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, 36)];
    titleView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH - 16, 36)];
    titleLabel.textColor = kNavTitleColor;
    titleLabel.font = [UIFont systemFontOfSize:12.f];
    if (section == 0) {
        titleLabel.text = @"约战队已选其他服务";
    } else {
        titleLabel.text = @"其他服务";
    }
    [titleView addSubview:titleLabel];
    [headerView addSubview:titleView];
    
    return headerView;
}


@end








