//
//  TQEvaluateRefereeTableView.m
//  wegoal
//
//  Created by joker on 2017/3/17.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQEvaluateRefereeTableView.h"
#import "TQEvaluateRefereeCell.h"

#define kTQEvaluateRefereeCellIdentifier     @"TQEvaluateRefereeCell"
@interface TQEvaluateRefereeTableView()<UITableViewDataSource, UITableViewDelegate>


@end

@implementation TQEvaluateRefereeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        
        [self registerNib:[UINib nibWithNibName:@"TQEvaluateRefereeCell" bundle:nil] forCellReuseIdentifier:kTQEvaluateRefereeCellIdentifier];
    }
    return self;
}


#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQEvaluateRefereeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQEvaluateRefereeCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQEvaluateRefereeCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.canEdit = NO;
    return cell;
    
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end