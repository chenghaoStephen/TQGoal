//
//  TQMatchDetailViewController.m
//  wegoal
//
//  Created by joker on 2017/3/15.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMatchDetailViewController.h"
#import "TQMatchDetailTopView.h"
#import "TQMatchDetailBottomView.h"
#import "TQMatchInformationCell.h"
#import "TQMatchRefereeCell.h"
#import "TQMatchServiceCell.h"

#define kTQMatchInformationCellIdentifier   @"TQMatchInformationCell"
#define kTQMatchRefereeCellIdentifier       @"TQMatchRefereeCell"
#define kTQMatchServiceCellIdentifier       @"TQMatchServiceCell"
@interface TQMatchDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UIImageView *packupImageView;
    
    TQMatchModel *matchData;
    TQServiceModel *refereeData;
    NSMutableArray *servicesArray;
}

@property (strong, nonatomic) TQMatchDetailTopView *topView;
@property (strong, nonatomic) UITableView *detailTableView;
@property (strong, nonatomic) TQMatchDetailBottomView *bottomView;

@property (assign, nonatomic) BOOL isRefereePackup;
@property (assign, nonatomic) BOOL isServicePackup;

@end

@implementation TQMatchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的约战详情";
    self.view.backgroundColor = kMainBackColor;
    _isRefereePackup = NO;
    _isServicePackup = NO;
    servicesArray = [NSMutableArray array];
    [self.view addSubview:self.detailTableView];
    [self.view addSubview:self.bottomView];
    
    [self requestData];
}

- (TQMatchDetailTopView *)topView
{
    if (!_topView) {
        _topView = [[NSBundle mainBundle] loadNibNamed:@"TQMatchDetailTopView" owner:nil options:nil].firstObject;
        _topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 130);
        _topView.backgroundColor = [UIColor whiteColor];
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

#pragma mark - 数据请求

//获取主页信息
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = USER_NAME;
    params[@"Token"] = USER_TOKEN;
    params[@"enrollId"] = _matchModel.enrollId;
    [ZDMIndicatorView showInView:self.detailTableView];
    [[AFServer sharedInstance]GET:URL(kTQDomainURL, kEnrollDetail) parameters:params finishBlock:^(id result) {
        [ZDMIndicatorView hiddenInView:weakSelf.detailTableView];
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //读取数据
                matchData = [TQMatchModel mj_objectWithKeyValues:result[@"data"][@"headerData"]];
                refereeData = [TQServiceModel mj_objectWithKeyValues:result[@"data"][@"mainData"]];
                [servicesArray removeAllObjects];
                [servicesArray addObjectsFromArray:[TQServiceModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"footerData"]]];
                
                //更新主页信息
                [weakSelf updateHomeSubViews];
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

- (void)updateHomeSubViews
{
    if (matchData) {
        _topView.matchData = matchData;
    }
    [self.detailTableView reloadData];
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (servicesArray && servicesArray.count > 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (refereeData) {
            return 5;
        } else {
            return 4;
        }
    } else {
        if (_isServicePackup) {
            return 0;
        } else {
            return servicesArray.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row >= 0 && indexPath.row < 4) {
            TQMatchInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMatchInformationCellIdentifier];
            if (!cell) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"TQMatchInformationCell" owner:nil options:nil].firstObject;
            }
            cell.noticeView.hidden = YES;
            switch (indexPath.row) {
                case 0:
                    cell.infoImageView.image = [UIImage imageNamed:@"match_time"];
                    cell.infoTitleLabel.text = @"约战时间";
                    cell.infoContentLabel.text = [NSDate datestrFromDate:[NSDate dateFromString:matchData.gameDate format:kDateFormatter1] withDateFormat:kDateFormatter2];
                    break;
                case 1:
                    cell.infoImageView.image = [UIImage imageNamed:@"match_ground"];
                    cell.infoTitleLabel.text = @"约战场地";
                    cell.infoContentLabel.text = matchData.gamePlace;
                    break;
                case 2:
                    cell.infoImageView.image = [UIImage imageNamed:@"ground_pay"];
                    cell.infoTitleLabel.text = @"场地费用";
                    cell.infoContentLabel.text = [NSString stringWithFormat:@"￥%@", matchData.placeFee?:@""];
                    cell.noticeView.hidden = NO;
                    break;
                case 3:
                    cell.infoImageView.image = [UIImage imageNamed:@"race_system"];
                    cell.infoTitleLabel.text = @"赛制";
                    cell.infoContentLabel.text = matchData.gameRules;
                    break;
                    
                default:
                    cell.infoImageView.image = nil;
                    cell.infoTitleLabel.text = @"---";
                    cell.infoContentLabel.text = @"---";
                    break;
            }
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            TQMatchRefereeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMatchRefereeCellIdentifier];
            if (!cell) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"TQMatchRefereeCell" owner:nil options:nil].firstObject;
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            __weak typeof(self) weakSelf = self;
            cell.isPackup = _isRefereePackup;
            cell.canSelected = NO;
            if (refereeData) {
                cell.refereeData = refereeData;
            } else {
                [cell clearInformation];
            }
            cell.block = ^(BOOL isPackup){
                weakSelf.isRefereePackup = isPackup;
                [weakSelf.detailTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            };
            return cell;
        }
    } else {
        TQMatchServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMatchServiceCellIdentifier];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TQMatchServiceCell" owner:nil options:nil].firstObject;
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.canSelected = NO;
        if (indexPath.row < servicesArray.count) {
            cell.serviceData = servicesArray[indexPath.row];
        } else {
            [cell clearInformation];
        }
        return cell;
    }
    
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row >= 0 && indexPath.row < 4) {
            return 37.f;
        } else {
            if (_isRefereePackup) {
                return 40.f;
            } else {
                return 120.f;
            }
        }
    } else {
        return 80.f;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return 44.f;
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
