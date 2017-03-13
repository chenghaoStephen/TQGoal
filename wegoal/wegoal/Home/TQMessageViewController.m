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
{
    NSMutableArray *messageArray;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TQMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息列表";
    self.view.backgroundColor = kMainBackColor;
    messageArray = [NSMutableArray array];
    [self makeTestData];
    [self.view addSubview:self.tableView];
}

- (void)makeTestData
{
    TQMessageModel *message1 = [TQMessageModel new];
    message1.type = @"0";
    message1.latestMessage = @"您有一笔保证金消费记录。";
    message1.time = @"06:29";
    
    TQMessageModel *message2 = [TQMessageModel new];
    message2.type = @"1";
    message2.latestMessage = @"您有一个比赛在本周日下午14:00进行，请注意时间并做好保暖措施。";
    message2.time = @"昨天";
    
    TQMessageModel *message3 = [TQMessageModel new];
    message3.type = @"2";
    message3.latestMessage = @"约战已经成功，请点击详细查看。";
    message3.time = @"昨天";
    
    [messageArray addObjectsFromArray:@[message1, message2, message3]];
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
    return messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMessageCellIdentifier];
    if (!cell) {
        NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"TQMessageCell" owner:nil options:nil].firstObject;
        cell = xibs.firstObject;
    }
    if (indexPath.row < messageArray.count) {
        cell.messageData = messageArray[indexPath.row];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
