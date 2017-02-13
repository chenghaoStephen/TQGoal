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

#define kTQMatchCellIdentifier @"TQMatchCell"
@interface TQScheduleViewController ()<UINavigationControllerDelegate, JOMatchMenuViewDelegate, TQScheduleHeaderViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) JOMatchMenuView *menuView;
@property (nonatomic, strong) TQScheduleHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableview;

@end

@implementation TQScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableview];
    
    self.navigationController.delegate = self;
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

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), SCREEN_WIDTH, VIEW_WITHOUT_TABBAR_HEIGHT + 64 - CGRectGetMaxY(_headerView.frame))
                                                  style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.backgroundColor = kMainBackColor;
        [_tableview registerNib:[UINib nibWithNibName:@"TQMatchCell" bundle:nil] forCellReuseIdentifier:kTQMatchCellIdentifier];
        
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 3)];
        tableHeaderView.backgroundColor = kMainBackColor;
        _tableview.tableHeaderView = tableHeaderView;
    }
    return _tableview;
}


#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[TQScheduleViewController class]] ||
        [viewController isKindOfClass:[TQTeamDetailViewController class]]) {
        [navigationController setNavigationBarHidden:YES];
    }
}


#pragma mark - JOMatchMenuViewDelegate

- (void)JOMatchMenuView:(JOMatchMenuView *)matchMenuView getDataWithWeeks:(NSArray *)weeks systems:(NSArray *)systems types:(NSArray *)types
{
    //刷新约战数据
    
}

- (void)JOMatchMenuView:(JOMatchMenuView *)matchMenuView getDataWithStatus:(NSArray *)status
{
    //刷新赛事数据
    
}

- (void)JOMatchMenuView:(JOMatchMenuView *)matchMenuView updateViewHeight:(CGFloat)height
{
    [UIView animateWithDuration:.3f animations:^{
        [_menuView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        [_headerView setFrame:CGRectMake(0, CGRectGetMaxY(_menuView.frame), SCREEN_WIDTH, 35)];
        [_tableview setFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), SCREEN_WIDTH, VIEW_WITHOUT_TABBAR_HEIGHT + 64 - CGRectGetMaxY(_headerView.frame))];
    } completion:^(BOOL finished) {
        
    }];
}


#pragma mark - TQScheduleHeaderViewDelegate

- (void)TQScheduleHeaderView:(TQScheduleHeaderView *)headerView selectSegment:(NSInteger)index
{
    _menuView.matchType = (index == 0)?@"first":@"second";
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
    TQMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMatchCellIdentifier];
    if (!cell) {
        NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"TQMatchCell" owner:nil options:nil].firstObject;
        cell = xibs.firstObject;
    }
    cell.isShowLine = YES;
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 128.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQTeamDetailViewController *teamDetailVC = [[TQTeamDetailViewController alloc] init];
    teamDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:teamDetailVC animated:YES];
}

@end




