//
//  TQOrderRefereeViewController.m
//  wegoal
//
//  Created by joker on 2017/3/16.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQOrderRefereeViewController.h"
#import "TQTeamInformationView.h"
#import "TQMatchInformationCell.h"
#import "TQMatchRefereeCell.h"
#import "XHDatePickerView.h"
#import "ZSYPopoverListView.h"
#import "TQPlaceListViewController.h"
#import "TQMatchDetailBottomView.h"
#import "TQPayTypeSelectView.h"

#define kTQMatchInformationCellIdentifier   @"TQMatchInformationCell"
#define kTQMatchRefereeCellIdentifier       @"TQMatchRefereeCell"
#define kTQPayTypeSelectCellIdentifier      @"TQPayTypeSelectCell"
#define kPayTypeSelectViewTag               91001
@interface TQOrderRefereeViewController ()<UITableViewDataSource, UITableViewDelegate, ZSYPopoverListDatasource, ZSYPopoverListDelegate>

@property (nonatomic, strong) TQTeamModel *teamData;
@property (nonatomic, strong) TQServiceModel *refereeData;

@property (strong, nonatomic) TQTeamInformationView *topView;
@property (strong, nonatomic) UITableView *detailTableView;
@property (strong, nonatomic) TQMatchDetailBottomView *bottomView;

@property (assign, nonatomic) BOOL isRefereePackup;        //裁判收起
@property (strong, nonatomic) NSDate *matchTime;           //时间
@property (strong, nonatomic) NSString *matchSystem;       //赛制
@property (strong, nonatomic) TQPlaceModel *matchPlace;    //场地
@property (assign, nonatomic) PayType type;                //支付方式

@end

@implementation TQOrderRefereeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"预约裁判";
    _isRefereePackup = NO;
    _matchTime = [NSDate date];
    _matchSystem = kRaceSystemArray[0];
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
        [_detailTableView registerNib:[UINib nibWithNibName:@"TQMatchRefereeCell" bundle:nil] forCellReuseIdentifier:kTQMatchRefereeCellIdentifier];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 0 && indexPath.row < 3) {
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
            case 2:
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
    } else if (indexPath.row == 3) {
        TQMatchRefereeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMatchRefereeCellIdentifier];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TQMatchRefereeCell" owner:nil options:nil].firstObject;
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        cell.isPackup = _isRefereePackup;
        cell.canSelected = NO;
        if (_refereeData) {
            cell.refereeData = _refereeData;
        } else {
            [cell clearInformation];
        }
        cell.block = ^(BOOL isPackup){
            weakSelf.isRefereePackup = isPackup;
            [weakSelf.detailTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
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
    if (indexPath.row >= 0 && indexPath.row < 3) {
        return 37.f;
    } else if (indexPath.row == 3) {
        if (_isRefereePackup) {
            return 40.f;
        } else {
            return 120.f;
        }
    } else {
        return 115;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof(self) weakSelf = self;
    if (indexPath.row >= 0 && indexPath.row < 3) {
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
            case 2://赛制
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
    TQMatchInformationCell *cell = [_detailTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    cell.infoContentLabel.text = _matchSystem;
    [tableView dismiss];
    
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
