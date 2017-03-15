//
//  TQMemberManageViewController.m
//  wegoal
//
//  Created by joker on 2017/2/14.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMemberManageViewController.h"
#import "TQTeamMemberCell.h"
#import "TQAddMemberViewController.h"

typedef NS_ENUM(NSInteger, EditMode){
    EditModeNormal = 0,
    EditModeEditing,
};
#define kTeamMemberCellIdentifier     @"TQTeamMemberCell"

@interface TQMemberManageViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSInteger editMode;
    NSMutableArray *selectedArray;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation TQMemberManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    selectedArray = [NSMutableArray array];
    self.title = @"球队管理";
    editMode = EditModeNormal;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addButton];
    [self.view addSubview:self.deleteButton];
    
    [self updateViews];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, VIEW_HEIGHT - 46) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerNib:[UINib nibWithNibName:@"TQTeamMemberCell" bundle:nil] forCellReuseIdentifier:kTeamMemberCellIdentifier];
    }
    return _tableView;
}

- (UIButton *)addButton
{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setFrame:CGRectMake(0, VIEW_HEIGHT - 45, SCREEN_WIDTH, 45)];
        [_addButton setBackgroundColor:kSubjectBackColor];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_addButton setTitle:@"添加球员" forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addTeamMember) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setFrame:CGRectMake(0, VIEW_HEIGHT - 45, SCREEN_WIDTH, 45)];
        [_deleteButton setBackgroundColor:kRedBackColor];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteTeamMember) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (void)updateViews
{
    if (editMode == EditModeNormal) {
        UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        editBtn.frame = CGRectMake(0, 0, 44, 44);
        [editBtn addTarget:self action:@selector(startEdit) forControlEvents:UIControlEventTouchUpInside];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editBtn setTitleColor:kNavTitleColor forState:UIControlStateNormal];
        editBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        UIBarButtonItem *editBarBtn = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
        self.navigationItem.rightBarButtonItem = editBarBtn;
        
        _addButton.hidden = NO;
        _deleteButton.hidden = YES;
    } else {
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 0, 44, 44);
        [cancelBtn addTarget:self action:@selector(endEdit) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:kNavTitleColor forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        UIBarButtonItem *cancelBarBtn = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
        self.navigationItem.rightBarButtonItem = cancelBarBtn;

        _addButton.hidden = YES;
        _deleteButton.hidden = NO;
        _deleteButton.enabled = NO;
    }
}


#pragma mark - events

- (void)startEdit
{
    //进入编辑状态
    editMode = EditModeEditing;
    [self updateViews];
    [_tableView reloadData];
}

- (void)endEdit
{
    editMode = EditModeNormal;
    [selectedArray removeAllObjects];
    [self updateViews];
    [_tableView reloadData];
}

- (void)addTeamMember
{
    TQAddMemberViewController *addMemberVC = [[TQAddMemberViewController alloc] init];
    [self.navigationController pushViewController:addMemberVC animated:YES];
}

- (void)deleteTeamMember
{
    
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
    TQTeamMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:kTeamMemberCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQTeamMemberCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (editMode == EditModeNormal) {
        cell.selectImageView.hidden = YES;
        cell.viewLeftConstraint.constant = -19;
        cell.mainView.backgroundColor = [UIColor whiteColor];
        cell.selectImageView.image = [UIImage imageNamed:@"select_default"];
    } else {
        cell.selectImageView.hidden = NO;
        cell.viewLeftConstraint.constant = 0;
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
    if (editMode == EditModeNormal) return;
    TQTeamMemberCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    if ([selectedArray containsObject:indexPath]) {
        [selectedArray removeObject:indexPath];
        cell.mainView.backgroundColor = [UIColor whiteColor];
        cell.selectImageView.image = [UIImage imageNamed:@"select_default"];
    } else {
        [selectedArray addObject:indexPath];
        cell.mainView.backgroundColor = kMainBackColor;
        cell.selectImageView.image = [UIImage imageNamed:@"select_confirm"];
    }
}


@end
