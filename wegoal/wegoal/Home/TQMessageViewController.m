//
//  TQMessageViewController.m
//  wegoal
//
//  Created by joker on 2017/3/7.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMessageViewController.h"
#import "TQMessageCell.h"

#define kTQMessageCellIdentifier @"TQMessageCell"

@interface TQMessageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TQMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息列表";
    self.view.backgroundColor = kMainBackColor;
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, VIEW_HEIGHT - 1) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerNib:[UINib nibWithNibName:@"TQMessageCell" bundle:nil] forCellReuseIdentifier:kTQMessageCellIdentifier];
        
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, .6)];
//        headerView.backgroundColor =  kMainBackColor;
//        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMessageCellIdentifier];
    if (!cell) {
        NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"TQMessageCell" owner:nil options:nil].firstObject;
        cell = xibs.firstObject;
    }
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
