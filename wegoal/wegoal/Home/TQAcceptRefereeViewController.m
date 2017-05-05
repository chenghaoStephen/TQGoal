//
//  TQAcceptRefereeViewController.m
//  wegoal
//
//  Created by joker on 2017/4/22.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQAcceptRefereeViewController.h"
#import "TQMatchDetailTopView.h"
#import "TQMatchInformationCell.h"
#import "TQAcceptRefereeCell.h"
#import "TQAcceptServiceViewController.h"

#define kTQMatchInformationCellIdentifier   @"TQMatchInformationCell"
#define kTQAcceptRefereeCellIdentifier       @"TQAcceptRefereeCell"
@interface TQAcceptRefereeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) TQMatchDetailTopView *topView;
@property (strong, nonatomic) UITableView *detailTableView;
@property (strong, nonatomic) UIButton *nextStep;

@property (nonatomic, strong) TQServiceModel *refereeData;
@property (nonatomic, strong) NSMutableArray *servicesArray;

@end

@implementation TQAcceptRefereeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"组队应战";
    _servicesArray = [NSMutableArray array];
    self.view.backgroundColor = kMainBackColor;
    [self.view addSubview:self.detailTableView];
    [self.view addSubview:self.nextStep];
    [self requestData];
}

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

//暂时使用发起约战的数据
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = USER_NAME;
    params[@"Token"] = USER_TOKEN;
    [JOIndicatorView showInView:self.detailTableView];
    [[AFServer sharedInstance]GET:URL(kTQDomainURL, kEnrollLaunched) parameters:params finishBlock:^(id result) {
        [JOIndicatorView hiddenInView:weakSelf.detailTableView];
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //读取数据
                _refereeData = [TQServiceModel mj_objectWithKeyValues:result[@"data"][@"mainData"]];
                [_servicesArray removeAllObjects];
                [_servicesArray addObjectsFromArray:[TQServiceModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"footerData"]]];
                
                //更新主页信息
                [weakSelf.detailTableView reloadData];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [JOToast showWithText:result[@"msg"]];
            });
        }
        
    } failedBlock:^(NSError *error) {
        [JOIndicatorView hiddenInView:weakSelf.detailTableView];
        dispatch_async(dispatch_get_main_queue(), ^{
            [JOToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
}


#pragma mark - events

- (void)nextStepAction
{
    TQAcceptServiceViewController *acceptServiceVC = [[TQAcceptServiceViewController alloc] init];
    acceptServiceVC.matchData = _matchData;
    acceptServiceVC.refereeData = _refereeData;
    acceptServiceVC.servicesArray = _servicesArray;
    [self.navigationController pushViewController:acceptServiceVC animated:YES];
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
        TQAcceptRefereeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQAcceptRefereeCellIdentifier];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TQAcceptRefereeCell" owner:nil options:nil].firstObject;
        }
        [cell setRefereeData:_refereeData];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
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
        return 56.f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 56)];
    headerView.backgroundColor = kMainBackColor;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, 52)];
    titleView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 14, SCREEN_WIDTH - 16, 24)];
    titleLabel.textColor = kSubjectBackColor;
    titleLabel.font = [UIFont systemFontOfSize:10.f];
    titleLabel.numberOfLines = 0;
    titleLabel.text = @"裁判服务为平台认证赛标志，在平台产生球队数据约战方已选当前服务，应战方必须支付此费用";
    [titleView addSubview:titleLabel];
    [headerView addSubview:titleView];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
