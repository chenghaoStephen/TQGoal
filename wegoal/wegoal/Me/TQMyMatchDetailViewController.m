//
//  TQMyMatchDetailViewController.m
//  wegoal
//
//  Created by joker on 2017/3/17.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMyMatchDetailViewController.h"
#import "TQPlayBackTableView.h"
#import "TQEvaluateMemberTableView.h"
#import "TQEvaluateRefereeTableView.h"
#import "TQEvaluateCompetitorTableView.h"
#import "TQScheduleHeaderView.h"
#import "TQMatchCell.h"

@interface TQMyMatchDetailViewController ()<TQScheduleHeaderViewDelegate>
{
    NSInteger selectIndex;
}

@property (nonatomic, strong) TQMatchCell *matchView;
@property (nonatomic, strong) TQScheduleHeaderView *headerView;
@property (nonatomic, strong) TQPlayBackTableView *playBackTableView;
@property (nonatomic, strong) TQEvaluateMemberTableView *evaluateMemberTableView;
@property (nonatomic, strong) TQEvaluateRefereeTableView *evaluateRefereeTableView;
@property (nonatomic, strong) TQEvaluateCompetitorTableView *evaluateCompetitorTableView;

@end

@implementation TQMyMatchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"约战详情";
    self.view.backgroundColor = kMainBackColor;
    
    [self.view addSubview:self.matchView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.playBackTableView];
    [self.view addSubview:self.evaluateMemberTableView];
    [self.view addSubview:self.evaluateRefereeTableView];
    [self.view addSubview:self.evaluateCompetitorTableView];
    selectIndex = 0;
    [self updateSubViews];
}

- (UIBarButtonItem*)buildRightNavigationItem{
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(shareAction)];
    return rightBarBtn;
}

- (TQMatchCell *)matchView
{
    if (!_matchView) {
        _matchView = [[NSBundle mainBundle] loadNibNamed:@"TQMatchCell" owner:self options:nil].firstObject;
        _matchView.frame = CGRectMake(0, 4, SCREEN_WIDTH, 122);
        _matchView.backgroundColor = [UIColor whiteColor];
    }
    return _matchView;
}

- (TQScheduleHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[TQScheduleHeaderView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_matchView.frame) + 4, SCREEN_WIDTH, 35)];
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.delegate = self;
        _headerView.unselectedColor = kTitleTextColor;
        _headerView.selectedColor = kSubjectBackColor;
        _headerView.segments = @[@"战况回放", @"球员评价", @"裁判评价", @"对手评价"];
    }
    return _headerView;
}

-  (TQPlayBackTableView *)playBackTableView
{
    if (!_playBackTableView) {
        _playBackTableView = [[TQPlayBackTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame) + 1, SCREEN_WIDTH, VIEW_HEIGHT - CGRectGetMaxY(_headerView.frame) - 1) style:UITableViewStylePlain];
        _playBackTableView.backgroundColor = [UIColor whiteColor];
    }
    return _playBackTableView;
}

- (TQEvaluateMemberTableView *)evaluateMemberTableView
{
    if (!_evaluateMemberTableView) {
        _evaluateMemberTableView = [[TQEvaluateMemberTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame) + 1, SCREEN_WIDTH, VIEW_HEIGHT - CGRectGetMaxY(_headerView.frame) - 1) style:UITableViewStylePlain];
        _evaluateMemberTableView.backgroundColor = [UIColor whiteColor];
    }
    return _evaluateMemberTableView;
}

- (TQEvaluateRefereeTableView *)evaluateRefereeTableView
{
    if (!_evaluateRefereeTableView) {
        _evaluateRefereeTableView = [[TQEvaluateRefereeTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame) + 1, SCREEN_WIDTH, VIEW_HEIGHT - CGRectGetMaxY(_headerView.frame) - 1) style:UITableViewStylePlain];
        _evaluateRefereeTableView.backgroundColor = [UIColor whiteColor];
    }
    return _evaluateRefereeTableView;
}

- (TQEvaluateCompetitorTableView *)evaluateCompetitorTableView
{
    if (!_evaluateCompetitorTableView) {
        _evaluateCompetitorTableView = [[TQEvaluateCompetitorTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame) + 1, SCREEN_WIDTH, VIEW_HEIGHT - CGRectGetMaxY(_headerView.frame) - 1) style:UITableViewStylePlain];
        _evaluateCompetitorTableView.backgroundColor = [UIColor whiteColor];
    }
    return _evaluateCompetitorTableView;
}


#pragma mark - events

- (void)shareAction
{
    NSLog(@"do share.");
}

- (void)updateSubViews
{
    switch (selectIndex) {
        case 0:
            _playBackTableView.hidden = NO;
            _evaluateMemberTableView.hidden = YES;
            _evaluateRefereeTableView.hidden = YES;
            _evaluateCompetitorTableView.hidden = YES;
            break;
            
        case 1:
            _playBackTableView.hidden = YES;
            _evaluateMemberTableView.hidden = NO;
            _evaluateRefereeTableView.hidden = YES;
            _evaluateCompetitorTableView.hidden = YES;
            break;
            
        case 2:
            _playBackTableView.hidden = YES;
            _evaluateMemberTableView.hidden = YES;
            _evaluateRefereeTableView.hidden = NO;
            _evaluateCompetitorTableView.hidden = YES;
            break;
            
        case 3:
            _playBackTableView.hidden = YES;
            _evaluateMemberTableView.hidden = YES;
            _evaluateRefereeTableView.hidden = YES;
            _evaluateCompetitorTableView.hidden = NO;
            break;
            
        default:
            break;
    }
}

#pragma mark - TQScheduleHeaderViewDelegate

- (void)TQScheduleHeaderView:(TQScheduleHeaderView *)headerView selectSegment:(NSInteger)index
{
    selectIndex = index;
    [self updateSubViews];
}



@end
