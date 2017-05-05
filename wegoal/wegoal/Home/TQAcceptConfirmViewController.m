//
//  TQAcceptConfirmViewController.m
//  wegoal
//
//  Created by joker on 2017/4/22.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQAcceptConfirmViewController.h"
#import "TQMatchDetailTopView.h"
#import "TQMatchInformationCell.h"
#import "TQAcceptRefereeCell.h"
#import "TQMatchServiceCell.h"
#import "TQLaunchInvitateViewController.h"

#define kTQMatchInformationCellIdentifier   @"TQMatchInformationCell"
#define kTQAcceptRefereeCellIdentifier      @"TQAcceptRefereeCell"
#define kTQMatchServiceCellIdentifier       @"TQMatchServiceCell"
@interface TQAcceptConfirmViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) TQMatchDetailTopView *topView;
@property (strong, nonatomic) UITableView *detailTableView;
@property (strong, nonatomic) UIButton *nextStep;

@end

@implementation TQAcceptConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认应战";
    self.view.backgroundColor = kMainBackColor;
    
    [self.view addSubview:self.detailTableView];
    [self.view addSubview:self.nextStep];
    _topView.matchData = _matchData;
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self.view addSubview:self.detailTableView];
//        [self.view addSubview:self.nextStep];
//    }
//    return self;
//}
//
//- (void)reloadData
//{
//    [_detailTableView reloadData];
//    _topView.matchData = _matchData;
//}

- (TQMatchDetailTopView *)topView
{
    if (!_topView) {
        _topView = [[NSBundle mainBundle] loadNibNamed:@"TQMatchDetailTopView" owner:nil options:nil].firstObject;
        _topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.matchData = _matchData;
    }
    return _topView;
}

- (UITableView *)detailTableView
{
    if (!_detailTableView) {
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT - 44) style:UITableViewStylePlain];
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTableView.dataSource = self;
        _detailTableView.delegate = self;
        _detailTableView.backgroundColor = kMainBackColor;
        [_detailTableView registerNib:[UINib nibWithNibName:@"TQMatchInformationCell" bundle:nil] forCellReuseIdentifier:kTQMatchInformationCellIdentifier];
        [_detailTableView registerNib:[UINib nibWithNibName:@"TQAcceptRefereeCell" bundle:nil] forCellReuseIdentifier:kTQAcceptRefereeCellIdentifier];
        [_detailTableView registerNib:[UINib nibWithNibName:@"TQMatchServiceCell" bundle:nil] forCellReuseIdentifier:kTQMatchServiceCellIdentifier];
        _detailTableView.tableHeaderView = self.topView;
    }
    return _detailTableView;
}

- (UIButton *)nextStep
{
    if (!_nextStep) {
        _nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextStep.frame = CGRectMake(0, VIEW_HEIGHT - 44, SCREEN_WIDTH, 44);
        _nextStep.backgroundColor = kRedBackColor;
        [_nextStep setTitle:@"确认应战" forState:UIControlStateNormal];
        _nextStep.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextStep addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStep;
}

#pragma mark - events

- (void)confirmAction
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //    params[@"Id"] = _teamData.teamId;
    params[@"userName"] = USER_NAME;
    if (_refereeData.isSelected) {
        params[@"refereeServiceId"] = _refereeData.serviceId;
    }
    if (_servicesArray.count > 0) {
        params[@"otherServiceIdAndCount"] = [self getServiceStr];
    }
    
//    [JOIndicatorView showInView:self.detailTableView];
//    [[AFServer sharedInstance]POST:URL(kTQDomainURL, kSetEnroll) parameters:params filePath:nil finishBlock:^(id result) {
//        [JOIndicatorView hiddenInView:weakSelf.detailTableView];
//        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                //跳转到邀请好友界面
//                TQLaunchInvitateViewController *launchInviteVC = [[TQLaunchInvitateViewController alloc] init];
//                [weakSelf.navigationController pushViewController:launchInviteVC animated:YES];
//            });
//            
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [JOToast showWithText:result[@"msg"]];
//            });
//        }
//        
//    } failedBlock:^(NSError *error) {
//        [JOIndicatorView hiddenInView:weakSelf.detailTableView];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [JOToast showWithText:@"网络连接失败，请稍后再试！"];
//        });
//    }];
    
}

- (NSString *)getServiceStr
{
    NSMutableArray *array = [NSMutableArray array];
    for (TQServiceModel *serviceData in _servicesArray) {
        [array addObject:@{@"id":serviceData.serviceId, @"num":@(serviceData.amount)}];
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}



#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else {
        return _servicesArray.count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TQMatchInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMatchInformationCellIdentifier];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TQMatchInformationCell" owner:nil options:nil].firstObject;
        }
        cell.noticeView.hidden = YES;
        switch (indexPath.row) {
            case 0:
                cell.infoImageView.image = [UIImage imageNamed:@"match_time"];
                cell.infoTitleLabel.text = @"约战时间";
                cell.infoContentLabel.text = [NSDate datestrFromDate:[NSDate dateFromString:_matchData.gameDate format:kDateFormatter1] withDateFormat:kDateFormatter2];
                break;
            case 1:
                cell.infoImageView.image = [UIImage imageNamed:@"match_ground"];
                cell.infoTitleLabel.text = @"约战场地";
                cell.infoContentLabel.text = _matchData.gamePlace;
                break;
            case 2:
                cell.infoImageView.image = [UIImage imageNamed:@"ground_pay"];
                cell.infoTitleLabel.text = @"场地费用";
                cell.infoContentLabel.text = _matchData.placeFee;
                cell.noticeView.hidden = NO;
                break;
            case 3:
                cell.infoImageView.image = [UIImage imageNamed:@"race_system"];
                cell.infoTitleLabel.text = @"赛制";
                cell.infoContentLabel.text = _matchData.gameRules;
                break;
                
            default:
                cell.infoImageView.image = nil;
                cell.infoTitleLabel.text = @"---";
                cell.infoContentLabel.text = @"---";
                break;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        if (indexPath.row == 0) {
            TQAcceptRefereeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQAcceptRefereeCellIdentifier];
            if (!cell) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"TQAcceptRefereeCell" owner:nil options:nil].firstObject;
            }
            [cell setRefereeData:_refereeData];
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
            cell.canSelected = NO;
            if (indexPath.row - 1 < _servicesArray.count) {
                cell.serviceData = _servicesArray[indexPath.row - 1];
            } else {
                [cell clearInformation];
            }
            return cell;
            
        }
        
    }
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 37.f;
    } else {
        return 80.f;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return 40.f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headerView.backgroundColor = kMainBackColor;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, 36)];
    titleView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, SCREEN_WIDTH - 16, 36)];
    titleLabel.textColor = kNavTitleColor;
    titleLabel.font = [UIFont systemFontOfSize:12.f];
    titleLabel.text = @"应战服务";
    [titleView addSubview:titleLabel];
    [headerView addSubview:titleView];
    
    return headerView;
}


@end







