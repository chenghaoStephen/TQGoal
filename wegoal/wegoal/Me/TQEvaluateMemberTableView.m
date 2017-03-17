//
//  TQEvaluateMemberTableView.m
//  wegoal
//
//  Created by joker on 2017/3/17.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQEvaluateMemberTableView.h"
#import "TQEvaluateMemberCell.h"
#import "TQEvaluateMemberHeaderView.h"

#define kTQEvaluateMemberCellIdentifier     @"TQEvaluateMemberCell"
@interface TQEvaluateMemberTableView()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation TQEvaluateMemberTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        [self registerNib:[UINib nibWithNibName:@"TQEvaluateMemberCell" bundle:nil] forCellReuseIdentifier:kTQEvaluateMemberCellIdentifier];
        
        [self setTestData];
    }
    return self;
}

- (void)setTestData
{
    NSMutableArray *arrayTmp = [NSMutableArray array];
    for (NSInteger i = 0; i < 15; i++) {
        TQMemberModel *memberData = [TQMemberModel new];
        [arrayTmp addObject:memberData];
        if (i == 1) {
            memberData.isMvp = YES;
        }
    }
    _membersArray = arrayTmp;
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
    cell.canEdit = NO;
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
