//
//  TQOrderServicesViewController.m
//  wegoal
//
//  Created by joker on 2017/3/16.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQOrderServicesViewController.h"
#import "TQTeamInformationView.h"
#import "TQMatchInformationCell.h"
#import "TQMatchServiceCell.h"
#import "XHDatePickerView.h"
#import "TQPlaceListViewController.h"
#import "TQMatchDetailBottomView.h"
#import "TQPayTypeSelectView.h"

#define kTQMatchInformationCellIdentifier   @"TQMatchInformationCell"
#define kTQMatchServiceCellIdentifier       @"TQMatchServiceCell"
#define kTQPayTypeSelectCellIdentifier      @"TQPayTypeSelectCell"
#define kPayTypeSelectViewTag               91001
@interface TQOrderServicesViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIImageView *packupImageView;
}

@property (nonatomic, strong) TQTeamModel *teamData;
@property (nonatomic, strong) NSMutableArray *servicesArray;

@property (strong, nonatomic) TQTeamInformationView *topView;
@property (strong, nonatomic) UITableView *detailTableView;
@property (strong, nonatomic) TQMatchDetailBottomView *bottomView;

@property (assign, nonatomic) BOOL isServicePackup;
@property (strong, nonatomic) NSDate *matchTime;           //时间
@property (strong, nonatomic) TQPlaceModel *matchPlace;    //场地
@property (assign, nonatomic) PayType type;                //支付方式

@end

@implementation TQOrderServicesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"预约服务";
    _matchTime = [NSDate date];
    _servicesArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 10; i++) {
        TQServiceModel *serviceData = [TQServiceModel new];
        [_servicesArray addObject:serviceData];
    }
    self.view.backgroundColor = kMainBackColor;
    [self.view addSubview:self.detailTableView];
    [self.view addSubview:self.bottomView];
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
        [_detailTableView registerNib:[UINib nibWithNibName:@"TQMatchServiceCell" bundle:nil] forCellReuseIdentifier:kTQMatchServiceCellIdentifier];
        _detailTableView.tableHeaderView = self.topView;
    }
    return _detailTableView;
}

- (TQMatchDetailBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[TQMatchDetailBottomView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT - 44, SCREEN_WIDTH, 44)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}


#pragma mark - events

- (void)requestData
{
    
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else if (section == 1){
        if (_isServicePackup) {
            return 0;
        } else {
            return _servicesArray.count;
        }
    } else {
        return 1;
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
                cell.infoContentLabel.text = [NSDate datestrFromDate:_matchTime withDateFormat:kDateFormatter2];
                break;
            case 1:
                cell.infoImageView.image = [UIImage imageNamed:@"match_ground"];
                cell.infoTitleLabel.text = @"约战场地";
                cell.infoContentLabel.text = @"---";
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
    } else if (indexPath.section == 1) {
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
    } else {
        UITableViewCell *typeCell = [tableView dequeueReusableCellWithIdentifier:kTQPayTypeSelectCellIdentifier];
        if (!typeCell) {
            typeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTQPayTypeSelectCellIdentifier];
        }
        if (![typeCell viewWithTag:kPayTypeSelectViewTag] || ![[typeCell viewWithTag:kPayTypeSelectViewTag] isKindOfClass:[TQPayTypeSelectView class]]) {
            TQPayTypeSelectView *payTypeSelectView = [[TQPayTypeSelectView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, 110)];
            __weak typeof(self) weakSelf = self;
            payTypeSelectView.payTypeBlock = ^(PayType type) {
                weakSelf.type = type;
            };
            payTypeSelectView.tag = kPayTypeSelectViewTag;
            typeCell.contentView.backgroundColor = kMainBackColor;
            [typeCell.contentView addSubview:payTypeSelectView];
            typeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return typeCell;
    }
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 37.f;
    } else if (indexPath.section == 1) {
        return 80.f;
    } else {
        return 115.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 44.f;
    } else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 0) {
        TQMatchInformationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        switch (indexPath.row) {
            case 0://约战时间
            {
                XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate) {
                    weakSelf.matchTime = startDate;
                    cell.infoContentLabel.text = [NSDate datestrFromDate:weakSelf.matchTime withDateFormat:kDateFormatter2];
                }];
                datepicker.datePickerStyle = DateStyleShowYearMonthDayHourMinute;
                datepicker.themeColor = kSubjectBackColor;
                datepicker.minLimitDate = [NSDate date];
                [datepicker show];
                break;
            }
            case 1://约战场地
            {
                TQPlaceListViewController *placeListVC = [[TQPlaceListViewController alloc] init];
                placeListVC.selectPlaceBlk = ^(TQPlaceModel *placeData){
                    cell.infoContentLabel.text = placeData.name;
                    weakSelf.matchPlace = placeData;
                };
                [self.navigationController pushViewController:placeListVC animated:YES];
                break;
            }
            default:
                
                break;
        }
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44.f)];
    headerView.backgroundColor = kMainBackColor;
    
    UIView *subHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 4, SCREEN_WIDTH, 39.f)];
    subHeaderView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:subHeaderView];
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(12, 10, 50, 15)];
    titleLbl.textColor = kNavTitleColor;
    titleLbl.font = [UIFont systemFontOfSize:12.f];
    titleLbl.text = @"约服务";
    packupImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 22, 15, 10, 6)];
    if (_isServicePackup) {
        packupImageView.image = [UIImage imageNamed:@"drop_gray"];
    } else {
        packupImageView.image = [UIImage imageNamed:@"packup_gray"];
    }
    [subHeaderView addSubview:titleLbl];
    [subHeaderView addSubview:packupImageView];
    //添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(packupServiceView)];
    [subHeaderView addGestureRecognizer:tapGesture];
    
    return headerView;
}

- (void)packupServiceView
{
    _isServicePackup = !_isServicePackup;
    //    [_detailTableView reloadData];
    [_detailTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
}



@end
