//
//  TQAddMemberViewController.m
//  wegoal
//
//  Created by joker on 2017/2/14.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQAddMemberViewController.h"
#import "TQTeamMemberCell.h"

#define kTeamMemberCellIdentifier     @"TQTeamMemberCell"
@interface TQAddMemberViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TQAddMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    
    self.view.backgroundColor = kMainBackColor;
    [self.view addSubview:self.textField];
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, 36)];
        _textField.backgroundColor = [UIColor whiteColor];
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 36)];
        leftView.backgroundColor = [UIColor clearColor];
        _textField.leftView = leftView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.textColor = [UIColor blackColor];
        _textField.font = [UIFont systemFontOfSize:12.f];
        _textField.placeholder = @"输入球员姓名";
        _textField.delegate = self;
    }
    return _textField;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_textField.frame) + 1, SCREEN_WIDTH, VIEW_HEIGHT - CGRectGetMaxY(_textField.frame) - 1) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kMainBackColor;
        [_tableView registerNib:[UINib nibWithNibName:@"TQTeamMemberCell" bundle:nil] forCellReuseIdentifier:kTeamMemberCellIdentifier];
    }
    return _tableView;
}

#pragma mark - events

- (void)addMember
{
    NSLog(@"add member.");
}


#pragma mark - UITextFieldDelegate



#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQTeamMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:kTeamMemberCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQTeamMemberCell" owner:nil options:nil].firstObject;
    }
    cell.isInvitate = NO;
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 37.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
