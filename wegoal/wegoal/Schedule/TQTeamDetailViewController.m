//
//  TQTeamDetailViewController.m
//  wegoal
//
//  Created by joker on 2017/2/13.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQTeamDetailViewController.h"
#import "TQTeamTopView.h"
#import "TQScheduleHeaderView.h"
#import "TQMatchCell.h"
#import "TQTeamMemberCell.h"

#define kMatchCellIdentifier          @"TQMatchCell"
#define kTeamMemberCellIdentifier     @"TQTeamMemberCell"
#define kMembersTableViewTag          31001
#define kHistoryTableViewTag          31002
@interface TQTeamDetailViewController ()<UITableViewDataSource, UITableViewDelegate, TQScheduleHeaderViewDelegate>

@property (nonatomic, strong) TQTeamTopView *topView;
@property (nonatomic, strong) TQScheduleHeaderView *headerView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *joinButton;
@property (nonatomic, strong) UITableView *membersTableView;
@property (nonatomic, strong) UITableView *historyTableView;

@end

@implementation TQTeamDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.joinButton];
    [self.view addSubview:self.membersTableView];
    [self.view addSubview:self.historyTableView];
    _membersTableView.hidden = NO;
    _historyTableView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _topView.frame = CGRectMake(0, 0, 375, 206 * SCALE375);
}

- (TQTeamTopView *)topView
{
    if (!_topView) {
        _topView = [[NSBundle mainBundle] loadNibNamed:@"TQTeamTopView" owner:nil options:nil].firstObject;
        _topView.frame = CGRectMake(0, 0, 375, 206 * SCALE375);
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.viewMode = TeamTopViewModeTeam;
    }
    return _topView;
}

- (TQScheduleHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[TQScheduleHeaderView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), SCREEN_WIDTH, 35)];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.delegate = self;
        _headerView.unselectedColor = kTitleTextColor;
        _headerView.selectedColor = kSubjectBackColor;
        _headerView.segments = @[@"阵容",@"比赛历时"];
    }
    return _headerView;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setFrame:CGRectMake(8, 20, 44, 44)];
        [_backButton setImage:[UIImage imageNamed:@"schedule_back"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)joinButton
{
    if (!_joinButton) {
        _joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_joinButton setFrame:CGRectMake(SCREEN_WIDTH - 58, 20, 50, 44)];
        [_joinButton setTitle:@"申请加入" forState:UIControlStateNormal];
        [_joinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _joinButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_joinButton addTarget:self action:@selector(joinAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _joinButton;
}

- (UITableView *)membersTableView
{
    if (!_membersTableView) {
        _membersTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), SCREEN_WIDTH, VIEW_HEIGHT + 64 - CGRectGetMaxY(_headerView.frame)) style:UITableViewStylePlain];
        _membersTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _membersTableView.dataSource = self;
        _membersTableView.delegate = self;
        _membersTableView.backgroundColor = kMainBackColor;
        _membersTableView.tag = kMembersTableViewTag;
        [_membersTableView registerNib:[UINib nibWithNibName:@"TQTeamMemberCell" bundle:nil] forCellReuseIdentifier:kTeamMemberCellIdentifier];
        
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, .5)];
        tableHeaderView.backgroundColor = kMainBackColor;
        _membersTableView.tableHeaderView = tableHeaderView;
    }
    return _membersTableView;
}

- (UITableView *)historyTableView
{
    if (!_historyTableView) {
        _historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), SCREEN_WIDTH, VIEW_HEIGHT + 64 - CGRectGetMaxY(_headerView.frame)) style:UITableViewStylePlain];
        _historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _historyTableView.dataSource = self;
        _historyTableView.delegate = self;
        _historyTableView.backgroundColor = kMainBackColor;
        _historyTableView.tag = kHistoryTableViewTag;
        [_historyTableView registerNib:[UINib nibWithNibName:@"TQMatchCell" bundle:nil] forCellReuseIdentifier:kMatchCellIdentifier];
        
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, .5)];
        tableHeaderView.backgroundColor = kMainBackColor;
        _historyTableView.tableHeaderView = tableHeaderView;
    }
    return _historyTableView;
}

#pragma mark - events

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)joinAction
{
    
}


#pragma mark - TQScheduleHeaderViewDelegate

- (void)TQScheduleHeaderView:(TQScheduleHeaderView *)headerView selectSegment:(NSInteger)index
{
    if (index == 0) {
        _membersTableView.hidden = NO;
        _historyTableView.hidden = YES;
    } else {
        _membersTableView.hidden = YES;
        _historyTableView.hidden = NO;
    }
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == kMembersTableViewTag) {
        return 20;
    } else {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == kMembersTableViewTag) {
        TQTeamMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:kTeamMemberCellIdentifier];
        if (!cell) {
            NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"TQTeamMemberCell" owner:nil options:nil].firstObject;
            cell = xibs.firstObject;
        }
        return cell;
    } else {
        TQMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:kMatchCellIdentifier];
        if (!cell) {
            NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"TQMatchCell" owner:nil options:nil].firstObject;
            cell = xibs.firstObject;
        }
        cell.isShowLine = YES;
        return cell;
    }
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == kMembersTableViewTag) {
        return 37.f;
    } else {
        return 128.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == kMembersTableViewTag) {
        
    }
}


@end
