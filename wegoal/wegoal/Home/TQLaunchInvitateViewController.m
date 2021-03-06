//
//  TQLaunchInvitateViewController.m
//  wegoal
//
//  Created by joker on 2017/3/15.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQLaunchInvitateViewController.h"
#import "TQTeamMemberCell.h"
#import "TQMemberModel.h"

#define kTeamMemberCellIdentifier     @"TQTeamMemberCell"
@interface TQLaunchInvitateViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *membersArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TQLaunchInvitateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请队友";
    
    _membersArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self requestData];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerNib:[UINib nibWithNibName:@"TQTeamMemberCell" bundle:nil] forCellReuseIdentifier:kTeamMemberCellIdentifier];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        headerView.backgroundColor = kMainBackColor;
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}

- (void)goBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
    [[AFServer sharedInstance]GET:URL(kTQDomainURL, kInviteTeammates) parameters:params finishBlock:^(id result) {
        [JOIndicatorView hiddenInView:weakSelf.tableView];
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //读取数据
                [weakSelf.membersArray removeAllObjects];
                [weakSelf.membersArray addObjectsFromArray:[TQMemberModel mj_objectArrayWithKeyValuesArray:result[@"data"]]];
                
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
    return _membersArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQTeamMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:kTeamMemberCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQTeamMemberCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isInvitate = YES;
    if (indexPath.row < _membersArray.count) {
        cell.memberData = _membersArray[indexPath.row];
    } else {
        [cell clearInformation];
    }
    __weak typeof(self) weakSelf = self;
    cell.invitateBlock = ^{
        [weakSelf invitateMember:weakSelf.membersArray[indexPath.row]];
    };
    return cell;
}

- (void)invitateMember:(TQMemberModel *)data
{
    NSLog(@"invite member:%@", data.memberName);
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 37.f;
}




@end
