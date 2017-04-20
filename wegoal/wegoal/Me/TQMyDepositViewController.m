//
//  TQMyDepositViewController.m
//  wegoal
//
//  Created by joker on 2017/4/20.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMyDepositViewController.h"
#import "TQDepositTransCell.h"

#define kDepositTransCellIdentifier     @"TQDepositTransCell"
@interface TQMyDepositViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *depositAmountLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TQMyDepositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kMainBackColor;
}



#pragma mark - events

- (IBAction)rechargeAction:(id)sender {
    
}

- (IBAction)drawbackAction:(id)sender {
    
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
    TQDepositTransCell *cell = [tableView dequeueReusableCellWithIdentifier:kDepositTransCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQDepositTransCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 28)];
    headerView.backgroundColor = kMainBackColor;
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 28)];
    titleLbl.font = [UIFont systemFontOfSize:10.f];
    titleLbl.textColor = kNavTitleColor;
    titleLbl.backgroundColor = [UIColor clearColor];
    titleLbl.text = @"本月";
    [headerView addSubview:titleLbl];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}




@end






