//
//  TQEvaluateMemberViewController.m
//  wegoal
//
//  Created by joker on 2017/3/16.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQEvaluateMemberViewController.h"
#import "TQEvaluateMemberCell.h"
#import "TQMatchCell.h"
#import "TQEvaluateNoticeView.h"
#import "TQEvaluateMemberHeaderView.h"
#import "TQEvaluateMemberBottomView.h"
#import "TQEvaluateRefereeViewController.h"

#define kTQEvaluateMemberCellIdentifier     @"TQEvaluateMemberCell"
@interface TQEvaluateMemberViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TQMatchCell *matchView;
@property (nonatomic, strong) TQEvaluateNoticeView *noticeView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TQEvaluateMemberBottomView *bottomView;

@property (nonatomic, strong) NSMutableArray *membersArray;

@end

@implementation TQEvaluateMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评价球员";
    self.view.backgroundColor = kMainBackColor;
    _membersArray = [NSMutableArray array];
    [self setTestData];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
}

- (void)setTestData
{
    for (NSInteger i = 0; i < 15; i++) {
        TQMemberModel *memberData = [TQMemberModel new];
        [_membersArray addObject:memberData];
    }
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT - 44)
                                                  style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kMainBackColor;
        [_tableView registerNib:[UINib nibWithNibName:@"TQEvaluateMemberCell" bundle:nil] forCellReuseIdentifier:kTQEvaluateMemberCellIdentifier];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
        headerView.backgroundColor = kMainBackColor;
        [headerView addSubview:self.matchView];
        [headerView addSubview:self.noticeView];
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}

- (TQMatchCell *)matchView
{
    if (!_matchView) {
        _matchView = [[NSBundle mainBundle] loadNibNamed:@"TQMatchCell" owner:self options:nil].firstObject;
        _matchView.frame = CGRectMake(0, 3, SCREEN_WIDTH, 127);
        _matchView.backgroundColor = [UIColor whiteColor];
    }
    return _matchView;
}

- (TQEvaluateNoticeView *)noticeView
{
    if (!_noticeView) {
        _noticeView = [[TQEvaluateNoticeView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_matchView.frame) + 3, SCREEN_WIDTH, 35)];
        _noticeView.backgroundColor = [UIColor whiteColor];
    }
    return _noticeView;
}

- (TQEvaluateMemberBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[TQEvaluateMemberBottomView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT - 44, SCREEN_WIDTH, 44)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        _bottomView.nextStepBlk = ^{
            TQEvaluateRefereeViewController *evaluateRefereeVC = [[TQEvaluateRefereeViewController alloc] init];
            [weakSelf.navigationController pushViewController:evaluateRefereeVC animated:YES];
        };
    }
    return _bottomView;
}


#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _membersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQEvaluateMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQEvaluateMemberCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQEvaluateMemberCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < _membersArray.count) {
        TQMemberModel *memberData = _membersArray[indexPath.row];
        cell.memberData = memberData;
        [cell setSelected:memberData.isMvp andAmount:memberData.point];
    } else {
        [cell clearInformation];
        [cell setSelected:NO andAmount:0];
    }
    cell.canEdit = YES;
    __weak typeof(self) weakSelf = self;
    cell.selectBlk = ^(BOOL isSelected){
        //清空mvp
        if (isSelected) {
            for (TQMemberModel *memberTmp in weakSelf.membersArray) {
                memberTmp.isMvp = NO;
            }
        }
        
        TQMemberModel *memberData = weakSelf.membersArray[indexPath.row];
        memberData.isMvp = isSelected;
        [weakSelf.tableView reloadData];
    };
    cell.amountBlk = ^(NSUInteger newAmount){
        TQMemberModel *memberData = weakSelf.membersArray[indexPath.row];
        memberData.point = newAmount;
    };
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
    TQEvaluateMemberHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"TQEvaluateMemberHeaderView" owner:nil options:nil].firstObject;
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 22);
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
