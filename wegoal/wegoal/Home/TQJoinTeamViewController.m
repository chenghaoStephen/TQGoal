//
//  TQJoinTeamViewController.m
//  wegoal
//
//  Created by joker on 2017/4/20.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQJoinTeamViewController.h"
#import "TQTeamApplyCell.h"

#define kTeamApplyCellIdentifier     @"TQTeamApplyCell"
@interface TQJoinTeamViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *teamsArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TQJoinTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"加入球队";
    self.view.backgroundColor = kMainBackColor;
    _teamsArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self requestData];
}

- (UIBarButtonItem*)buildRightNavigationItem{
    UIBarButtonItem *searchBarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_gray"]
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(searchAction)];
    return searchBarBtn;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = kMainBackColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerNib:[UINib nibWithNibName:@"TQTeamApplyCell" bundle:nil] forCellReuseIdentifier:kTeamApplyCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 4)];
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}


#pragma mark - 数据请求

//获取球队列表
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"Token"] = USER_TOKEN;
    [ZDMIndicatorView showInView:self.view];
    [[AFServer sharedInstance]GET:URL(kTQDomainURL, kGetTeamList) parameters:params finishBlock:^(id result) {
        [ZDMIndicatorView hiddenInView:weakSelf.view];
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //读取数据
                [_teamsArray removeAllObjects];
                [_teamsArray addObjectsFromArray:[TQTeamModel mj_objectArrayWithKeyValuesArray:result[@"data"]]];
                
                //更新主页信息
                [weakSelf.tableView reloadData];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZDMToast showWithText:result[@"msg"]];
            });
        }
        
    } failedBlock:^(NSError *error) {
        [ZDMIndicatorView hiddenInView:weakSelf.view];
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZDMToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
}


#pragma mark - events

- (void)searchAction
{
    NSLog(@"search team.");
}


#pragma mark - UITabelView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _teamsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQTeamApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:kTeamApplyCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQTeamApplyCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < _teamsArray.count) {
        cell.teamData = _teamsArray[indexPath.row];
    } else {
        cell.teamData = nil;
    }
    __weak typeof(self) weakSelf = self;
    cell.applyBlock = ^{
        if (indexPath.row < weakSelf.teamsArray.count) {
            [weakSelf applyTeam:weakSelf.teamsArray[indexPath.row]];
        }
    };

    return cell;
}

- (void)applyTeam:(TQTeamModel *)teamData
{
    TQMemberModel *userData = [UserDataManager getUserData];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = userData.userName;
    params[@"teamId"] = teamData.teamId;
    [ZDMIndicatorView showInView:self.view];
    [[AFServer sharedInstance]POST:URL(kTQDomainURL, kUserJoinTeam) parameters:params filePath:nil finishBlock:^(id result) {
        [ZDMIndicatorView hiddenInView:weakSelf.view];
        
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //申请成功
                [ZDMToast showWithText:@"申请成功"];
                //返回上一页
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZDMToast showWithText:result[@"msg"]];
            });
        }
        
        
    } failedBlock:^(NSError *error) {
        [ZDMIndicatorView hiddenInView:weakSelf.view];
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZDMToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}


@end
