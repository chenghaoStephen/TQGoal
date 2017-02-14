//
//  TQMemberDetailViewController.m
//  wegoal
//
//  Created by joker on 2017/2/13.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMemberDetailViewController.h"
#import "TQMatchCell.h"
#import "TQMemberDetailCell.h"


#define kMatchCellIdentifier          @"TQMatchCell"
#define kMemberDetailCellIdentifier   @"TQMemberDetailCell"
@interface TQMemberDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation TQMemberDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"---的生涯";
    
    [self.view addSubview:self.tableview];
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.backgroundColor = kMainBackColor;
        
        [_tableview registerNib:[UINib nibWithNibName:@"TQMatchCell" bundle:nil] forCellReuseIdentifier:kMatchCellIdentifier];
        [_tableview registerNib:[UINib nibWithNibName:@"TQMemberDetailCell" bundle:nil] forCellReuseIdentifier:kMemberDetailCellIdentifier];
    }
    return _tableview;
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TQMemberDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kMemberDetailCellIdentifier];
        if (!cell) {
            NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"TQMemberDetailCell" owner:nil options:nil].firstObject;
            cell = xibs.firstObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    if (indexPath.section == 0) {
        return 452.f;
    } else {
        return 128.f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 28.f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 28)];
        headerView.backgroundColor = [UIColor clearColor];
        
        UIView *historyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
        historyView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:historyView];
        UIImageView *topSignView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7.5, 5, 10)];
        topSignView.backgroundColor = kSubjectBackColor;
        [historyView addSubview:topSignView];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 10, 25)];
        titleLabel.textColor = kNavTitleColor;
        titleLabel.font = [UIFont systemFontOfSize:10.f];
        titleLabel.text = @"历史比赛";
        [historyView addSubview:titleLabel];
        
        return headerView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
