//
//  TQMyTasksViewController.m
//  wegoal
//
//  Created by joker on 2017/3/17.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMyTasksViewController.h"
#import "TQMyTaskCell.h"

#define kTQMyTaskCellIdentifier     @"TQMyTaskCell"
@interface TQMyTasksViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation TQMyTasksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"挑战任务";
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
        [_tableview registerNib:[UINib nibWithNibName:@"TQMyTaskCell" bundle:nil] forCellReuseIdentifier:kTQMyTaskCellIdentifier];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 4)];
        headerView.backgroundColor = kMainBackColor;
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQMyTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMyTaskCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQMyTaskCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
