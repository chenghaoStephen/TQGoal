//
//  TQMyMatchViewController.m
//  wegoal
//
//  Created by joker on 2017/3/16.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMyMatchViewController.h"
#import "TQMyMatchCell.h"
#import "TQMyMatchDetailViewController.h"
#import "TQLiveViewController.h"

#define kTQMyMatchCellIdentifier     @"TQMyMatchCell"
@interface TQMyMatchViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *mainData;     //我的约战数据
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TQMyMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的约战";
    self.view.backgroundColor = kMainBackColor;
    mainData = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self requestData];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, VIEW_HEIGHT - 1)
                                                  style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kMainBackColor;
        [_tableView registerNib:[UINib nibWithNibName:@"TQMyMatchCell" bundle:nil] forCellReuseIdentifier:kTQMyMatchCellIdentifier];
        
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
        tableHeaderView.backgroundColor = kMainBackColor;
        _tableView.tableHeaderView = tableHeaderView;
    }
    return _tableView;
}

#pragma mark - 数据请求

//获取主页信息
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = USER_NAME;
    params[@"Token"] = USER_TOKEN;
    [JOIndicatorView showInView:self.tableView];
    [[AFServer sharedInstance]GET:URL(kTQDomainURL, kHomeData) parameters:params finishBlock:^(id result) {
        [JOIndicatorView hiddenInView:weakSelf.tableView];
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //读取数据
                [mainData removeAllObjects];
                [mainData addObjectsFromArray:[TQMatchModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"mainData"]]];
                
                //更新主页信息
                [weakSelf.tableView reloadData];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [JOToast showWithText:result[@"msg"]];
            });
        }
        
    } failedBlock:^(NSError *error) {
        [JOIndicatorView hiddenInView:weakSelf.tableView];
        dispatch_async(dispatch_get_main_queue(), ^{
            [JOToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQMyMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMyMatchCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQMyMatchCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < mainData.count) {
        cell.matchData = mainData[indexPath.row];
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
    if (indexPath.row < mainData.count) {
        TQMatchModel *matchData = mainData[indexPath.row];
        if ([matchData.status integerValue] == MatchStatusViewSchedule) {
            //跳转到约战详情界面
            TQMyMatchDetailViewController *myMatchDetailVC = [[TQMyMatchDetailViewController alloc] init];
            [self.navigationController pushViewController:myMatchDetailVC animated:YES];
        } else {
            //跳转到直播界面
            TQLiveViewController *liveVC = [[TQLiveViewController alloc] init];
            liveVC.matchData = matchData;
            [self.navigationController pushViewController:liveVC animated:YES];
        }
    }
}


@end
