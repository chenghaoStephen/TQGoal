//
//  TQEditMeViewController.m
//  wegoal
//
//  Created by joker on 2017/2/20.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQEditMeViewController.h"
#import "TQEditMeCell.h"

#define kEditMeCellIdentifier   @"TQEditMeCell"
@interface TQEditMeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation TQEditMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑个人资料";
    self.view.backgroundColor = kMainBackColor;
    [self.view addSubview:self.tableview];
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
        _tableview.backgroundColor = kMainBackColor;
        _tableview.dataSource = self;
        _tableview.delegate = self;
        [_tableview registerNib:[UINib nibWithNibName:@"TQEditMeCell" bundle:nil] forCellReuseIdentifier:kEditMeCellIdentifier];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
        _tableview.tableHeaderView = headerView;
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQEditMeCell *cell = [tableView dequeueReusableCellWithIdentifier:kEditMeCellIdentifier];
    if (!cell) {
        NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"TQEditMeCell" owner:nil options:nil].firstObject;
        cell = xibs.firstObject;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"头像";
        cell.imageView.hidden = NO;
        cell.valueLabel.hidden = YES;
    } else {
        cell.imageView.hidden = YES;
        cell.valueLabel.hidden = NO;
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"昵称";
            cell.valueLabel.text = @"--";
        } else if (indexPath.row == 2) {
            cell.titleLabel.text = @"球队";
            cell.valueLabel.text = @"--";
        } else if (indexPath.row == 3) {
            cell.titleLabel.text = @"位置";
            cell.valueLabel.text = @"--";
        } else if (indexPath.row == 4) {
            cell.titleLabel.text = @"年龄";
            cell.valueLabel.text = @"--";
        } else if (indexPath.row == 5) {
            cell.titleLabel.text = @"身高";
            cell.valueLabel.text = @"--";
        } else if (indexPath.row == 6) {
            cell.titleLabel.text = @"体重";
            cell.valueLabel.text = @"--";
        }
    }
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80.f;
    } else {
        return 36.f;
    }
}


@end
