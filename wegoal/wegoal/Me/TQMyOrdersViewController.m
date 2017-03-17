//
//  TQMyOrdersViewController.m
//  wegoal
//
//  Created by joker on 2017/3/17.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMyOrdersViewController.h"
#import "TQMyOrderCell.h"

#define kTQMyOrderCellIdentifier     @"TQMyOrderCell"
@interface TQMyOrdersViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation TQMyOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的订单";
    self.view.backgroundColor = kMainBackColor;
    [self.view addSubview:self.tableview];
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
        [_tableview registerNib:[UINib nibWithNibName:@"TQMyOrderCell" bundle:nil] forCellReuseIdentifier:kTQMyOrderCellIdentifier];
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
        return 3;
    } else {
        return 8;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMyOrderCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQMyOrderCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 27.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 27)];
    headerView.backgroundColor = kMainBackColor;
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 27)];
    lbl.textColor = kNavTitleColor;
    lbl.font = [UIFont systemFontOfSize:10.f];
    if (section == 0) {
        lbl.text = @"本月";
    } else {
        lbl.text = @"2月";
    }
    [headerView addSubview:lbl];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
