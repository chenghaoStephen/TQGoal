//
//  TQScheduleViewController.m
//  wegoal
//
//  Created by joker on 2016/11/27.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQScheduleViewController.h"
#import "JOMatchMenuView.h"
#import "TQScheduleHeaderView.h"
#import "TQMatchCell.h"
#import "TQTeamDetailViewController.h"
#import "TQLiveViewController.h"

#define kMatchCellIdentifier @"TQMatchCell"
@interface TQScheduleViewController ()<UINavigationControllerDelegate, JOMatchMenuViewDelegate, TQScheduleHeaderViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *matchDatas;
    NSString *weekStr;
    NSString *systemStr;
    NSString *typeStr;
    NSString *statusStr;
}

@property (nonatomic, strong) JOMatchMenuView *menuView;
@property (nonatomic, strong) TQScheduleHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TQScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    matchDatas = [NSMutableArray array];
    weekStr = @"*";
    systemStr = @"*";
    typeStr = @"*";
    statusStr = @"*";
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    
    self.navigationController.delegate = self;
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarBtnShow];
}

- (JOMatchMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[JOMatchMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 65)];
        _menuView.backgroundColor = kScheduleBackColor;
        _menuView.delegate = self;
        _menuView.isDrop = NO;
        _menuView.matchType = @"first";
    }
    return _menuView;
}

- (TQScheduleHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[TQScheduleHeaderView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_menuView.frame), SCREEN_WIDTH, 35)];
        _headerView.backgroundColor = kScheduleBackColor;
        _headerView.delegate = self;
        _headerView.unselectedColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        _headerView.selectedColor = [UIColor whiteColor];
        _headerView.segments = @[@"约战",@"赛事"];
    }
    return _headerView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), SCREEN_WIDTH, VIEW_WITHOUT_TABBAR_HEIGHT + 64 - CGRectGetMaxY(_headerView.frame))
                                                  style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kMainBackColor;
        [_tableView registerNib:[UINib nibWithNibName:@"TQMatchCell" bundle:nil] forCellReuseIdentifier:kMatchCellIdentifier];
        
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 3)];
        tableHeaderView.backgroundColor = kMainBackColor;
        _tableView.tableHeaderView = tableHeaderView;
    }
    return _tableView;
}



#pragma mark - 数据请求

//获取约战信息
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = USER_NAME;
    params[@"Token"] = USER_TOKEN;
    params[@"gameWeek"] = weekStr;
    params[@"gameRules"] = systemStr;
    params[@"certification"] = typeStr;
    [JOIndicatorView showInView:self.tableView];
    [[AFServer sharedInstance]GET:URL(kTQDomainURL, kEnrollWaitList) parameters:params finishBlock:^(id result) {
        [JOIndicatorView hiddenInView:weakSelf.tableView];
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //读取数据
                [matchDatas removeAllObjects];
                [matchDatas addObjectsFromArray:[TQMatchModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"mainData"]]];
                //更新信息
                [weakSelf.tableView reloadData];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [JOToast showWithText:result[@"msg"]];
            });
        }
        
    } failedBlock:^(NSError *error) {
        [JOIndicatorView hiddenInView:weakSelf.tableView];
        dispatch_async(dispatch_get_main_queue(), ^{
            [JOToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
}


#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[TQScheduleViewController class]] ||
        [viewController isKindOfClass:[TQLiveViewController class]]     ||
        [viewController isKindOfClass:[TQTeamDetailViewController class]]) {
        [navigationController setNavigationBarHidden:YES];
    } else {
        [navigationController setNavigationBarHidden:NO];
    }
}


#pragma mark - JOMatchMenuViewDelegate

- (void)JOMatchMenuView:(JOMatchMenuView *)matchMenuView getDataWithWeeks:(NSString *)weeks systems:(NSString *)systems types:(NSString *)types
{
    //刷新约战数据
    NSLog(@"%@", weeks);
    NSLog(@"%@", systems);
    NSLog(@"%@", types);
    weekStr = weeks;
    systemStr = systems;
    typeStr = types;
    [self requestData];
}

- (void)JOMatchMenuView:(JOMatchMenuView *)matchMenuView getDataWithStatus:(NSString *)status
{
    //刷新赛事数据
    NSLog(@"%@", status);
    statusStr = status;
    
    //暂时没有数据
    [matchDatas removeAllObjects];
    [self.tableView reloadData];
}

- (void)JOMatchMenuView:(JOMatchMenuView *)matchMenuView updateViewHeight:(CGFloat)height
{
    [UIView animateWithDuration:.3f animations:^{
        [_menuView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        [_headerView setFrame:CGRectMake(0, CGRectGetMaxY(_menuView.frame), SCREEN_WIDTH, 35)];
        [_tableView setFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), SCREEN_WIDTH, VIEW_WITHOUT_TABBAR_HEIGHT + 64 - CGRectGetMaxY(_headerView.frame))];
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - TQScheduleHeaderViewDelegate

- (void)TQScheduleHeaderView:(TQScheduleHeaderView *)headerView selectSegment:(NSInteger)index
{
    _menuView.matchType = (index == 0)?@"first":@"second";
    //更新数据
    if (index == 0) {
        [self requestData];
    } else {
        //暂时没有数据
        [matchDatas removeAllObjects];
        [self.tableView reloadData];
    }
    
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return matchDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:kMatchCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQMatchCell" owner:nil options:nil].firstObject;
    }
    cell.isShowLine = YES;
    if (indexPath.row < matchDatas.count) {
        TQMatchModel *matchData = matchDatas[indexPath.row];
        cell.matchData = matchData;
        cell.isMine = NO;
    } else {
        [cell clearInformation];
    }
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 128.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转到直播界面
    if (indexPath.row < matchDatas.count) {
        TQMatchModel *matchData = matchDatas[indexPath.row];
        TQLiveViewController *liveVC = [[TQLiveViewController alloc] init];
        liveVC.matchData = matchData;
        [self pushViewController:liveVC];
    }
    
}

@end




