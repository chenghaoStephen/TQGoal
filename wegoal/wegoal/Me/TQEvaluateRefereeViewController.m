//
//  TQEvaluateRefereeViewController.m
//  wegoal
//
//  Created by joker on 2017/3/16.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQEvaluateRefereeViewController.h"
#import "TQEvaluateRefereeCell.h"
#import "TQEvaluateTeamCell.h"

#define kTQEvaluateRefereeCellIdentifier     @"TQEvaluateRefereeCell"
#define kTQEvaluateTeamCellIdentifier        @"TQEvaluateTeamCell"
@interface TQEvaluateRefereeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation TQEvaluateRefereeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评价";
    self.view.backgroundColor = kMainBackColor;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitButton];
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
        [_tableView registerNib:[UINib nibWithNibName:@"TQEvaluateRefereeCell" bundle:nil] forCellReuseIdentifier:kTQEvaluateRefereeCellIdentifier];
        [_tableView registerNib:[UINib nibWithNibName:@"TQEvaluateTeamCell" bundle:nil] forCellReuseIdentifier:kTQEvaluateTeamCellIdentifier];
    }
    return _tableView;
}

- (UIButton *)submitButton
{
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.frame = CGRectMake(0, VIEW_HEIGHT - 44, SCREEN_WIDTH, 44);
        _submitButton.backgroundColor = kSubjectBackColor;
        [_submitButton setTitle:@"提交评价" forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}


#pragma mark - events

- (void)submitAction
{
    NSLog(@"submit.");
}



#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TQEvaluateRefereeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQEvaluateRefereeCellIdentifier];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TQEvaluateRefereeCell" owner:nil options:nil].firstObject;
        }
        cell.canEdit = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        TQEvaluateTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQEvaluateTeamCellIdentifier];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TQEvaluateTeamCell" owner:nil options:nil].firstObject;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 42)];
    headerView.backgroundColor = kMainBackColor;
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 4, SCREEN_WIDTH, 37)];
    titleView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:titleView];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH, 37)];
    titleLabel.textColor = kNavTitleColor;
    titleLabel.font = [UIFont systemFontOfSize:12.f];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    if (section == 0) {
        titleLabel.text = @"评价裁判";
    } else {
        titleLabel.text = @"评价对手";
    }
    [titleView addSubview:titleLabel];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end




