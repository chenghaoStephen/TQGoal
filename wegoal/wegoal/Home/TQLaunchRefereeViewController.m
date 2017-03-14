//
//  TQLaunchRefereeViewController.m
//  wegoal
//
//  Created by joker on 2017/3/13.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQLaunchRefereeViewController.h"
#import "TQTeamInformationView.h"
#import "TQMatchInformationCell.h"
#import "TQMatchRefereeCell.h"
#import "TQLaunchServiceViewController.h"
#import "XHDatePickerView.h"
#import "ZSYPopoverListView.h"
#import "TQPlaceListViewController.h"

#define kRaceSystemArray   @[@"五人制",@"七、九人制",@"十一人制"]
#define kTQMatchInformationCellIdentifier   @"TQMatchInformationCell"
#define kTQMatchRefereeCellIdentifier       @"TQMatchRefereeCell"
@interface TQLaunchRefereeViewController ()<UITableViewDataSource, UITableViewDelegate, ZSYPopoverListDatasource, ZSYPopoverListDelegate>

@property (nonatomic, strong) TQTeamModel *teamData;
@property (nonatomic, strong) TQServiceModel *refereeData;
@property (nonatomic, strong) NSMutableArray *servicesArray;

@property (strong, nonatomic) TQTeamInformationView *topView;
@property (strong, nonatomic) UITableView *detailTableView;
@property (strong, nonatomic) UIButton *nextStep;

@property (assign, nonatomic) BOOL isRefereePackup;
@property (strong, nonatomic) NSString *matchTime;         //时间
@property (strong, nonatomic) NSString *matchSystem;       //赛制
@property (strong, nonatomic) TQPlaceModel *matchPlace;    //场地

@end

@implementation TQLaunchRefereeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发起约战";
    _isRefereePackup = NO;
    _servicesArray = [NSMutableArray array];
    _matchTime = [NSDate datestrFromDate:[NSDate date] withDateFormat:kDateFormatter2];
    _matchSystem = kRaceSystemArray[0];
    self.view.backgroundColor = kMainBackColor;
    [self.view addSubview:self.detailTableView];
    [self.view addSubview:self.nextStep];
    [self requestData];
}

- (TQTeamInformationView *)topView
{
    if (!_topView) {
        _topView = [[TQTeamInformationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        _topView.backgroundColor = [UIColor blackColor];
        _topView.viewMode = TeamTopViewModeTeam;
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
        [_detailTableView registerNib:[UINib nibWithNibName:@"TQMatchRefereeCell" bundle:nil] forCellReuseIdentifier:kTQMatchRefereeCellIdentifier];
        _detailTableView.tableHeaderView = self.topView;
    }
    return _detailTableView;
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


#pragma mark - 数据请求

//获取约战信息
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = USER_NAME;
    params[@"Token"] = USER_TOKEN;
    [ZDMIndicatorView showInView:self.detailTableView];
    [[AFServer sharedInstance]GET:URL(kTQDomainURL, kEnrollLaunched) parameters:params finishBlock:^(id result) {
        [ZDMIndicatorView hiddenInView:weakSelf.detailTableView];
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //读取数据
                _teamData = [TQTeamModel mj_objectWithKeyValues:result[@"data"][@"headerData"]];
                _refereeData = [TQServiceModel mj_objectWithKeyValues:result[@"data"][@"mainData"]];
                [_servicesArray removeAllObjects];
                [_servicesArray addObjectsFromArray:[TQServiceModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"footerData"]]];
                
                //更新主页信息
                [weakSelf updateTopView];
                [weakSelf.detailTableView reloadData];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZDMToast showWithText:result[@"msg"]];
            });
        }
        
    } failedBlock:^(NSError *error) {
        [ZDMIndicatorView hiddenInView:weakSelf.detailTableView];
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZDMToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
}


#pragma mark - events

- (void)updateTopView
{
    if (_teamData) {
        _topView.teamInfo = _teamData;
    }
    
}

- (void)nextStepAction
{
    if (!_matchPlace) {
        [ZDMToast showWithText:@"请选择场地"];
        return;
    }
    TQLaunchServiceViewController *launchServiceVC = [[TQLaunchServiceViewController alloc] init];
    launchServiceVC.teamData = _teamData;
    launchServiceVC.refereeData = _refereeData;
    launchServiceVC.servicesArray = _servicesArray;
    launchServiceVC.matchData = @{@"time":_matchTime,
                                  @"system":_matchSystem,
                                  @"place":_matchPlace};
    [self.navigationController pushViewController:launchServiceVC animated:YES];
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 0 && indexPath.row < 4) {
        TQMatchInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMatchInformationCellIdentifier];
        if (!cell) {
            NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"TQMatchInformationCell" owner:nil options:nil].firstObject;
            cell = xibs.firstObject;
        }
        cell.noticeView.hidden = YES;
        switch (indexPath.row) {
            case 0:
                cell.infoImageView.image = [UIImage imageNamed:@"match_time"];
                cell.infoTitleLabel.text = @"约战时间";
                cell.infoContentLabel.text = _matchTime;
                break;
            case 1:
                cell.infoImageView.image = [UIImage imageNamed:@"match_ground"];
                cell.infoTitleLabel.text = @"约战场地";
                cell.infoContentLabel.text = @"---";
                break;
            case 2:
                cell.infoImageView.image = [UIImage imageNamed:@"ground_pay"];
                cell.infoTitleLabel.text = @"场地费用";
                cell.infoContentLabel.text = @"---";
                break;
            case 3:
                cell.infoImageView.image = [UIImage imageNamed:@"race_system"];
                cell.infoTitleLabel.text = @"赛制";
                cell.infoContentLabel.text = _matchSystem;
                break;
                
            default:
                cell.infoImageView.image = nil;
                cell.infoTitleLabel.text = @"---";
                cell.infoContentLabel.text = @"---";
                break;
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        return cell;
    } else {
        TQMatchRefereeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMatchRefereeCellIdentifier];
        if (!cell) {
            NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"TQMatchRefereeCell" owner:nil options:nil].firstObject;
            cell = xibs.firstObject;
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        cell.isPackup = _isRefereePackup;
        cell.canSelected = YES;
        if (_refereeData) {
            cell.refereeData = _refereeData;
        } else {
            [cell clearInformation];
        }
        cell.block = ^(BOOL isPackup){
            weakSelf.isRefereePackup = isPackup;
            [weakSelf.detailTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        };
        cell.selectBlk = ^(BOOL isSelected){
            weakSelf.refereeData.isSelected = isSelected;
        };
        return cell;
    }
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 0 && indexPath.row < 4) {
        return 37.f;
    } else {
        if (_isRefereePackup) {
            return 40.f;
        } else {
            return 120.f;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof(self) weakSelf = self;
    if (indexPath.row >= 0 && indexPath.row < 4) {
        TQMatchInformationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        switch (indexPath.row) {
            case 0://约战时间
            {
                XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate) {
                    weakSelf.matchTime = [NSDate datestrFromDate:startDate withDateFormat:kDateFormatter2];
                    cell.infoContentLabel.text = weakSelf.matchTime;
                }];
                datepicker.datePickerStyle = DateStyleShowYearMonthDayHourMinute;
                datepicker.themeColor = kSubjectBackColor;
                datepicker.minLimitDate = [NSDate dateFromString:_matchTime format:kDateFormatter2];
                [datepicker show];
                break;
            }
            case 1://约战场地
            {
                TQPlaceListViewController *placeListVC = [[TQPlaceListViewController alloc] init];
                placeListVC.selectPlaceBlk = ^(TQPlaceModel *placeData){
                    cell.infoContentLabel.text = placeData.name;
                    TQMatchInformationCell *priceCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
                    priceCell.infoContentLabel.text = [NSString stringWithFormat:@"￥%@", placeData.price];
                    weakSelf.matchPlace = placeData;
                };
                [self.navigationController pushViewController:placeListVC animated:YES];
                break;
            }
            case 2://场地费用
                
                break;
            case 3://赛制
            {
                ZSYPopoverListView *listView = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0, 0, 120, 132)];
                listView.titleName.text = @"";
                listView.datasource = self;
                listView.delegate = self;
                listView.locationType = LocationTypeCenter;
                listView.hideTitle = YES;
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[kRaceSystemArray indexOfObject:_matchSystem] inSection:0];
                [listView show];
                [listView setTableViewSelectIndexPath:indexPath];
                break;
            }
            default:
                
                break;
        }
    }

}


#pragma mark - popListView datasource delegate

- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kRaceSystemArray.count;
}

- (UITableViewCell *)popoverListView:(ZSYPopoverListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusablePopoverCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.textColor = kNavTitleColor;
    cell.textLabel.font = [UIFont systemFontOfSize:12.f];
    if (indexPath.row < kRaceSystemArray.count) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [kRaceSystemArray objectAtIndex:indexPath.row]];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (CGFloat)popoverListView:(ZSYPopoverListView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _matchSystem = [kRaceSystemArray objectAtIndex:indexPath.row];
    TQMatchInformationCell *cell = [_detailTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell.infoContentLabel.text = _matchSystem;
    [tableView dismiss];
    
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
