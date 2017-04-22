//
//  TQSystemMsgViewController.m
//  wegoal
//
//  Created by joker on 2017/4/22.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQSystemMsgViewController.h"
#import "TQSystemMessageCell.h"

#define kSystemMessageCellIdentifier     @"TQSystemMessageCell"
@interface TQSystemMsgViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TQSystemMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"系统消息";
    self.view.backgroundColor = kMainBackColor;
    [self.view addSubview:self.tableView];
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT)
                                                  style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kMainBackColor;
        [_tableView registerNib:[UINib nibWithNibName:@"TQSystemMessageCell" bundle:nil] forCellReuseIdentifier:kSystemMessageCellIdentifier];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 4)];
        headerView.backgroundColor = kMainBackColor;
        _tableView.tableHeaderView = headerView;
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQSystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kSystemMessageCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQSystemMessageCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}




@end



