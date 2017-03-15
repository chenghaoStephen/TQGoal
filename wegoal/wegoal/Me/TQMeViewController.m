//
//  TQMeViewController.m
//  wegoal
//
//  Created by joker on 2016/11/27.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQMeViewController.h"
#import "TQMeViewCell.h"
#import "TQMeTopView.h"
#import "TQTeamDetailViewController.h"
#import "TQEditMeViewController.h"

#define kTQMeViewCell     @"TQMeViewCell"
@interface TQMeViewController ()<UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) TQMeTopView *meTopView;

@end

@implementation TQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    [self setSubViews];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarBtnShow];
}

- (void)setSubViews
{
    _meTopView = [[NSBundle mainBundle] loadNibNamed:@"TQMeTopView" owner:nil options:nil].firstObject;
    [_meTopView setFrame:_topView.bounds];
    [_topView addSubview:_meTopView];
    
    [_tableview registerNib:[UINib nibWithNibName:@"TQMeViewCell" bundle:nil] forCellReuseIdentifier:kTQMeViewCell];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.scrollEnabled = NO;
    _tableview.backgroundColor = kMainBackColor;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isKindOfClass:[TQMeViewController class]] ||
        [viewController isKindOfClass:[TQTeamDetailViewController class]]) {
        [navigationController setNavigationBarHidden:YES];
    } else {
        [navigationController setNavigationBarHidden:NO];
    }
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1){
        return 3;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQMeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMeViewCell];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQMeViewCell" owner:nil options:nil].firstObject;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.signName = @"myteam";
        cell.titleName = @"我的球队";
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.signName = @"edit_team";
        cell.titleName = @"编辑个人资料";
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        cell.signName = @"myschedule";
        cell.titleName = @"我的约战";
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        cell.signName = @"myorder";
        cell.titleName = @"我的订单";
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        cell.signName = @"gold";
        cell.titleName = @"我的保证金";
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        cell.signName = @"task";
        cell.titleName = @"任务总览";
    } else if (indexPath.section == 2 && indexPath.row == 1) {
        cell.signName = @"setting";
        cell.titleName = @"设置";
    } else {
        cell.signName = @"";
        cell.titleName = @"";
    }
    
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 3)];
    headerView.backgroundColor = kMainBackColor;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    if (indexPath.section == 0 && indexPath.row == 0) {
        //我的球队
        TQTeamDetailViewController *teamDetailVC = [[TQTeamDetailViewController alloc] init];
        teamDetailVC.isMyTeam = YES;
        [self pushViewController:teamDetailVC];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        //编辑个人资料
        TQEditMeViewController *editMeVC = [[TQEditMeViewController alloc] init];
        [self pushViewController:editMeVC];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        //我的约战
        
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        //我的订单
        
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        //我的保证金
        
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        //任务总览
        
    } else if (indexPath.section == 2 && indexPath.row == 1) {
        //设置
        
    }
}


@end
