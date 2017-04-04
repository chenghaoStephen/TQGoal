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
#import "TQMyMatchViewController.h"
#import "TQLiveViewController.h"
#import "TQEvaluateMemberViewController.h"
#import "TQEvaluateRefereeViewController.h"
#import "TQSignUpViewController.h"

@interface TQHomeMatchCell()

@property (nonatomic, strong) TQCreateTeamView *createView;
@property (nonatomic, strong) TQMatchStatusView *matchView;

@property (strong, nonatomic) UIButton *actionButton;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *action1Button;
@property (strong, nonatomic) UIButton *action2Button;

@end

@implementation TQHomeMatchCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.createView];
        [self addSubview:self.matchView];
        [self addSubview:self.actionButton];
        [self addSubview:self.cancelButton];
        [self addSubview:self.action1Button];
        [self addSubview:self.action2Button];
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
            [_actionButton setTitle:@"等待应战" forState:UIControlStateNormal];
            _actionButton.enabled = NO;
            _actionButton.hidden = NO;
            _action1Button.hidden = YES;
            _action2Button.hidden = YES;
            break;
        case MatchStatusConfirm:
            _actionButton.hidden = YES;
            _action1Button.hidden = NO;
            _action2Button.hidden = NO;
            break;
        case MatchStatusPay:
            [_actionButton setBackgroundColor:kSubjectBackColor];
            [_actionButton setTitle:@"即刻支付" forState:UIControlStateNormal];
            _actionButton.enabled = YES;
            _actionButton.hidden = NO;
            _action1Button.hidden = YES;
            _action2Button.hidden = YES;
            break;
        case MatchStatusWaiting:
            [_actionButton setBackgroundColor:kTitleTextColor];
            [_actionButton setTitle:@"等待约战开始" forState:UIControlStateNormal];
            _actionButton.enabled = NO;
            _actionButton.hidden = NO;
            _action1Button.hidden = YES;
            _action2Button.hidden = YES;
            break;
        case MatchStatusProcessing:
            [_actionButton setBackgroundColor:kRedBackColor];
            [_actionButton setTitle:@"赛况直播" forState:UIControlStateNormal];
            _actionButton.enabled = YES;
            _actionButton.hidden = NO;
            _action1Button.hidden = YES;
            _action2Button.hidden = YES;
            break;
        case MatchStatusEvaluateMember:
            [_actionButton setBackgroundColor:kSubjectBackColor];
            [_actionButton setTitle:@"评价球员" forState:UIControlStateNormal];
            _actionButton.enabled = YES;
            _actionButton.hidden = NO;
            _action1Button.hidden = YES;
            _action2Button.hidden = YES;
            break;
        case MatchStatusEvaluateOpponent:
            [_actionButton setBackgroundColor:kSubjectBackColor];
            [_actionButton setTitle:@"评价对手" forState:UIControlStateNormal];
            _actionButton.enabled = YES;
            _actionButton.hidden = NO;
            _action1Button.hidden = YES;
            _action2Button.hidden = YES;
            break;
        case MatchStatusViewSchedule:
            [_actionButton setBackgroundColor:kSubjectBackColor];
            [_actionButton setTitle:@"查看全部赛程" forState:UIControlStateNormal];
            _actionButton.enabled = YES;
            _actionButton.hidden = NO;
            _action1Button.hidden = YES;
            _action2Button.hidden = YES;
            break;
        case MatchStatusNotTeam:
            [_actionButton setBackgroundColor:kSubjectBackColor];
            [_actionButton setTitle:@"报名" forState:UIControlStateNormal];
            _actionButton.enabled = YES;
            _actionButton.hidden = NO;
            _action1Button.hidden = YES;
            _action2Button.hidden = YES;
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
        _createView.backgroundColor = [UIColor whiteColor];
        _createView.layer.masksToBounds = YES;
        _createView.layer.cornerRadius = 5.0;
    }
    return _createView;
}

- (TQMatchStatusView *)matchView
{
    if (!_matchView) {
        _matchView = [[TQMatchStatusView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 50, 190)];
        _matchView.backgroundColor = [UIColor whiteColor];
        _matchView.layer.masksToBounds = YES;
        _matchView.layer.cornerRadius = 5.0;
        _matchView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell)];
        [_matchView addGestureRecognizer:tapGesture];
        __weak typeof(self) weakSelf = self;
        _matchView.clickMoreBlk = ^(BOOL isMore){
            if (isMore) {
                weakSelf.cancelButton.hidden = NO;
                weakSelf.actionButton.hidden = YES;
                weakSelf.action1Button.hidden = YES;
                weakSelf.action2Button.hidden = YES;
            } else {
                weakSelf.cancelButton.hidden = YES;
                if ([weakSelf.matchData.status integerValue] == MatchStatusConfirm) {
                    weakSelf.actionButton.hidden = YES;
                    weakSelf.action1Button.hidden = NO;
                    weakSelf.action2Button.hidden = NO;
                } else {
                    weakSelf.actionButton.hidden = NO;
                    weakSelf.action1Button.hidden = YES;
                    weakSelf.action2Button.hidden = YES;
                }
                weakSelf.cancelButton.hidden = YES;
                
            }
        };
    }
    return _matchView;
}

- (void)tapCell
{
    if (_ClickBlock) {
        _ClickBlock();
    }
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

- (UIButton *)action1Button
{
    if (!_action1Button) {
        _action1Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_action1Button setFrame:CGRectMake((SCREEN_WIDTH - 280)/2, CGRectGetHeight(_matchView.frame) - 15, 100, 30)];
        [_action1Button setBackgroundColor:kNavTitleColor];
        [_action1Button setTitle:@"更换对手" forState:UIControlStateNormal];
        [_action1Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _action1Button.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_action1Button addTarget:self action:@selector(doChangeRival) forControlEvents:UIControlEventTouchUpInside];
        
        _action1Button.layer.masksToBounds = YES;
        _action1Button.layer.cornerRadius = CGRectGetHeight(_action1Button.frame)/2;
        _action1Button.hidden = YES;
    }
    return _action1Button;
}

- (UIButton *)action2Button
{
    if (!_action2Button) {
        _action2Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_action2Button setFrame:CGRectMake((SCREEN_WIDTH - 280)/2 + 130, CGRectGetHeight(_matchView.frame) - 15, 100, 30)];
        [_action2Button setBackgroundColor:kSubjectBackColor];
        [_action2Button setTitle:@"确认对手" forState:UIControlStateNormal];
        [_action2Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _action2Button.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_action2Button addTarget:self action:@selector(doConfirmRival) forControlEvents:UIControlEventTouchUpInside];
        
        _action2Button.layer.masksToBounds = YES;
        _action2Button.layer.cornerRadius = CGRectGetHeight(_action1Button.frame)/2;
        _action1Button.hidden = YES;
    }
    return _action2Button;
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


#pragma mark - events

- (void)doAction
{
    NSLog(@"do action.");
    //根据状态进行跳转
    switch ([_matchData.status integerValue]) {


        case MatchStatusPay:
        {
            //跳转到我的约战详情(支付)
            TQMatchDetailViewController *matchDetailVC = [[TQMatchDetailViewController alloc] init];
            matchDetailVC.matchModel = _matchData;
            [((TQBaseViewController *)self.viewController) pushViewController:matchDetailVC];
            break;
        }
            
        case MatchStatusProcessing:
        {
            //跳转到直播界面
            TQLiveViewController *liveVC = [[TQLiveViewController alloc] init];
            liveVC.matchData = _matchData;
            [((TQBaseViewController *)self.viewController) pushViewController:liveVC];
            break;
        }
            
        case MatchStatusEvaluateMember:
        {
            //跳转到评价球员界面
            TQEvaluateMemberViewController *evaluateMemVC = [[TQEvaluateMemberViewController alloc] init];
            [((TQBaseViewController *)self.viewController) pushViewController:evaluateMemVC];
            break;
        }
            
        case MatchStatusEvaluateOpponent:
        {
            //跳转到评价裁判界面
            TQEvaluateRefereeViewController *evaluateRefVC = [[TQEvaluateRefereeViewController alloc] init];
            [((TQBaseViewController *)self.viewController) pushViewController:evaluateRefVC];
            break;
        }
            
        case MatchStatusViewSchedule:
        {
            //跳转到我的约战列表
            TQMyMatchViewController *myMatchVC = [[TQMyMatchViewController alloc] init];
            [((TQBaseViewController *)self.viewController) pushViewController:myMatchVC];
            break;
        }
            
        case MatchStatusNotTeam:
        {
            //弹出报名菜单
            TQSignUpViewController *signUpVC = [[TQSignUpViewController alloc] initWithFrame:CGRectMake(0, 0, 250, 300)];
            signUpVC.view.backgroundColor = [UIColor whiteColor];
            signUpVC.view.layer.masksToBounds = YES;
            signUpVC.view.layer.cornerRadius = 5;
            CGFloat topY = MAX(SCREEN_HEIGHT - 538, 80);
            [self.viewController presentPopupViewController:signUpVC animationType:MJPopupViewAnimationFade topY:topY];
            break;
        }
            
        default:
            break;
    }

    
    
    
}

- (void)doChangeRival
{
    NSLog(@"change rival.");
}

- (void)doConfirmRival
{
    NSLog(@"confirm rival.");
}

- (void)cancelAction
{
    NSLog(@"cancel.");
}


@end
