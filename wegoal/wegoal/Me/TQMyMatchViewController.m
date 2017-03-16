//
//  TQMyMatchViewController.m
//  wegoal
//
//  Created by joker on 2017/3/16.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMyMatchViewController.h"
#import "TQMyMatchCell.h"

#define kTQMyMatchCellIdentifier     @"TQMyMatchCell"
@interface TQMyMatchViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *myMatchesArray;

@end

@implementation TQMyMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的约战";
    self.view.backgroundColor = kMainBackColor;
    _myMatchesArray = [NSMutableArray array];
    [self addTestData];
    [self.view addSubview:self.tableview];
}

- (void)addTestData
{
    TQMatchModel *match1 = [TQMatchModel new];
    match1.status = [NSString stringWithFormat:@"%ld", MatchStatusConfirm];
    TQMatchModel *match2 = [TQMatchModel new];
    match2.status = [NSString stringWithFormat:@"%ld", MatchStatusPay];
    TQMatchModel *match3 = [TQMatchModel new];
    match3.status = [NSString stringWithFormat:@"%ld", MatchStatusEnd];
    [_myMatchesArray addObjectsFromArray:@[match1, match2, match3]];
    
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT)
                                                  style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.backgroundColor = kMainBackColor;
        [_tableview registerNib:[UINib nibWithNibName:@"TQMyMatchCell" bundle:nil] forCellReuseIdentifier:kTQMyMatchCellIdentifier];
        
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 3)];
        tableHeaderView.backgroundColor = kMainBackColor;
        _tableview.tableHeaderView = tableHeaderView;
    }
    return _tableview;
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _myMatchesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQMyMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMyMatchCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQMyMatchCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < _myMatchesArray.count) {
        cell.matchData = _myMatchesArray[indexPath.row];
        cell.isMine = YES;
    } else {
        [cell clearInformation];
    }
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 168.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
