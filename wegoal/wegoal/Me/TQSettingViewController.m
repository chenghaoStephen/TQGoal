//
//  TQSettingViewController.m
//  wegoal
//
//  Created by joker on 2017/3/17.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQSettingViewController.h"
#import "TQSettingCell.h"

#define kTQSettingCellIdentifier     @"TQSettingCell"
@interface TQSettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIButton *logoutButton;

@end

@implementation TQSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.view.backgroundColor = kMainBackColor;
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.logoutButton];
}
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT - 44)
                                                  style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.backgroundColor = kMainBackColor;
        [_tableview registerNib:[UINib nibWithNibName:@"TQSettingCell" bundle:nil] forCellReuseIdentifier:kTQSettingCellIdentifier];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 4)];
        headerView.backgroundColor = kMainBackColor;
        _tableview.tableHeaderView = headerView;
    }
    return _tableview;
}

- (UIButton *)logoutButton
{
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutButton.frame = CGRectMake(0, VIEW_HEIGHT - 44, SCREEN_WIDTH, 44);
        _logoutButton.backgroundColor = kRedBackColor;
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        _logoutButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}


#pragma mark - events

- (void)logoutAction
{
    NSLog(@"logout.");
    //清空个人信息
    [UserDataManager clearUserData];
    //发出通知，退出成功
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccess
                                                        object:nil
                                                      userInfo:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQSettingCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQSettingCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"修改密码";
            cell.valueLabel.text = @"";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
            
        case 1:
            cell.titleLabel.text = @"关于我们";
            cell.valueLabel.text = @"";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
            
        case 2:
            cell.titleLabel.text = @"意见反馈";
            cell.valueLabel.text = @"";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
            
        case 3:
            cell.titleLabel.text = @"联系客服";
            cell.valueLabel.text = @"400-8886-6666";
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
            
        case 4:
            cell.titleLabel.text = @"版本信息";
            cell.valueLabel.text = [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
            
        default:
            break;
    }
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
