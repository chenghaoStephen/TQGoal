//
//  TQLadderViewController.m
//  wegoal
//
//  Created by joker on 2016/11/27.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQLadderViewController.h"
//#import "TQTeamTopView.h"
#import "TQTeamInformationView.h"
#import "TQLadderTeamCell.h"
#import "TQLadderHeaderView.h"
#import "TQTeamDetailViewController.h"

#define kTQLadderTeamCellIdentifier   @"TQLadderTeamCell"
@interface TQLadderViewController ()<UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TQTeamInformationView *topView;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UITableView *tableview;

@end

@implementation TQLadderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.searchButton];
    [self.view addSubview:self.tableview];
    
    self.navigationController.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarBtnShow];
    _topView.frame = CGRectMake(0, 0, 375, 206 * SCALE375);
}

- (TQTeamInformationView *)topView
{
    if (!_topView) {
//        _topView = [[NSBundle mainBundle] loadNibNamed:@"TQTeamTopView" owner:nil options:nil].firstObject;
        _topView = [[TQTeamInformationView alloc] initWithFrame:CGRectMake(0, 0, 375, 206 * SCALE375)];
        _topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"information_back"]];
//        _topView.backgroundColor = [UIColor clearColor];
        _topView.viewMode = TeamTopViewModeLadder;
    }
    return _topView;
}

- (UIButton *)searchButton
{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.frame = CGRectMake(SCREEN_WIDTH - 38, 25, 30, 30);
        [_searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [_searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchButton;
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), SCREEN_WIDTH, VIEW_WITHOUT_TABBAR_HEIGHT + 64 - CGRectGetMaxY(_topView.frame))
                                                  style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.backgroundColor = kMainBackColor;
        [_tableview registerNib:[UINib nibWithNibName:@"TQLadderTeamCell" bundle:nil] forCellReuseIdentifier:kTQLadderTeamCellIdentifier];
    }
    return _tableview;
}


#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[TQLadderViewController class]] ||
        [viewController isKindOfClass:[TQTeamDetailViewController class]]) {
        [navigationController setNavigationBarHidden:YES];
    } else {
        [navigationController setNavigationBarHidden:NO];
    }
}


#pragma mark - events

- (void)searchAction:(UIButton *)btn
{
    
}


#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQLadderTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQLadderTeamCellIdentifier];
    if (!cell) {
        NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"TQLadderTeamCell" owner:nil options:nil].firstObject;
        cell = xibs.firstObject;
    }
    cell.ladderNo = indexPath.row + 1;
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TQLadderHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"TQLadderHeaderView" owner:nil options:nil].firstObject;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20);
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    TQTeamDetailViewController *teamDetailVC = [[TQTeamDetailViewController alloc] init];
    teamDetailVC.hidesBottomBarWhenPushed = YES;
    [self setTabbarBtnHide];
    [self.navigationController pushViewController:teamDetailVC animated:YES];
}


@end



