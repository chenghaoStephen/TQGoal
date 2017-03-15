//
//  TQHomeMatchCell.m
//  wegoal
//
//  Created by joker on 2016/12/20.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQHomeMatchCell.h"
#import "TQCreateTeamView.h"
#import "TQMatchStatusView.h"
#import "TQMatchDetailViewController.h"

@interface TQHomeMatchCell()

@property (nonatomic, strong) TQCreateTeamView *createView;
@property (nonatomic, strong) TQMatchStatusView *matchView;

@property (strong, nonatomic) UIButton *actionButton;
@property (strong, nonatomic) UIButton *cancelButton;

@end

@implementation TQHomeMatchCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.createView];
        [self addSubview:self.matchView];
        [self addSubview:self.actionButton];
        [self addSubview:self.cancelButton];
        self.createView.hidden = YES;
    }
    return self;
}

- (void)setMatchData:(TQMatchModel *)matchData
{
    _matchData = matchData;
    switch ([matchData.status integerValue]) {
        case MatchStatusSearching:
            [_actionButton setBackgroundColor:kTitleTextColor];
            [_actionButton setTitle:@"等待中" forState:UIControlStateNormal];
            _actionButton.enabled = NO;
            break;
        case MatchStatusConfirm:
            [_actionButton setBackgroundColor:kSubjectBackColor];
            [_actionButton setTitle:@"确认对手" forState:UIControlStateNormal];
            _actionButton.enabled = YES;
            break;
        case MatchStatusPay:
            [_actionButton setBackgroundColor:kSubjectBackColor];
            [_actionButton setTitle:@"即刻支付" forState:UIControlStateNormal];
            _actionButton.enabled = YES;
            break;
        case MatchStatusWaiting:
            [_actionButton setBackgroundColor:kTitleTextColor];
            [_actionButton setTitle:@"等待中" forState:UIControlStateNormal];
            _actionButton.enabled = NO;
            break;
        case MatchStatusProcessing:
            [_actionButton setBackgroundColor:kRedBackColor];
            [_actionButton setTitle:@"赛况直播" forState:UIControlStateNormal];
            _actionButton.enabled = YES;
            break;
        case MatchStatusEnd:
            [_actionButton setBackgroundColor:kSubjectBackColor];
            [_actionButton setTitle:@"查看全部赛程" forState:UIControlStateNormal];
            _actionButton.enabled = YES;
            break;
            
        default:
            break;
    }
    
    _createView.hidden = YES;
    _matchView.hidden = NO;
    _matchView.matchData = matchData;
}

- (TQCreateTeamView *)createView
{
    if (!_createView) {
        _createView = [[TQCreateTeamView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 50, 190)];
        _createView.backgroundColor = [UIColor clearColor];
    }
    return _createView;
}

- (TQMatchStatusView *)matchView
{
    if (!_matchView) {
        _matchView = [[TQMatchStatusView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 50, 190)];
        _matchView.backgroundColor = [UIColor clearColor];
        __weak typeof(self) weakSelf = self;
        _matchView.clickMoreBlk = ^(BOOL isMore){
            if (isMore) {
                weakSelf.cancelButton.hidden = NO;
                weakSelf.actionButton.hidden = YES;
            } else {
                weakSelf.cancelButton.hidden = YES;
                weakSelf.actionButton.hidden = NO;
            }
        };
    }
    return _matchView;
}

- (UIButton *)actionButton
{
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionButton setFrame:CGRectMake((SCREEN_WIDTH - 200)/2, CGRectGetHeight(_matchView.frame) - 15, 150, 30)];
        [_actionButton setBackgroundColor:kSubjectBackColor];
        [_actionButton setTitle:@"即刻支付" forState:UIControlStateNormal];
        [_actionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _actionButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_actionButton addTarget:self action:@selector(doAction) forControlEvents:UIControlEventTouchUpInside];
        
        _actionButton.layer.masksToBounds = YES;
        _actionButton.layer.cornerRadius = CGRectGetHeight(_actionButton.frame)/2;
    }
    return _actionButton;
}

- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setFrame:CGRectMake((SCREEN_WIDTH - 200)/2, CGRectGetHeight(_matchView.frame) - 15, 150, 30)];
        [_cancelButton setBackgroundColor:kNavTitleColor];
        [_cancelButton setTitle:@"取消约战" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        
        _cancelButton.layer.masksToBounds = YES;
        _cancelButton.layer.cornerRadius = CGRectGetHeight(_cancelButton.frame)/2;
        _cancelButton.hidden = YES;
    }
    return _cancelButton;
}

- (void)doAction
{
    NSLog(@"do action.");
    TQMatchDetailViewController *matchDetailVC = [[TQMatchDetailViewController alloc] init];
    matchDetailVC.matchModel = _matchData;
    [((TQBaseViewController *)self.viewController) pushViewController:matchDetailVC];
}

- (void)cancelAction
{
    NSLog(@"cancel.");
}


@end
