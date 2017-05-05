//
//  TQInvitatePopViewController.m
//  wegoal
//
//  Created by joker on 2017/5/5.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQInvitatePopViewController.h"
#define kInviteButtonBaseTag     94001
@interface TQInvitatePopViewController ()
{
    CGSize viewSize;
    CGFloat interval;
}

@property (nonatomic, strong) UIView *inviteView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *signView;
@property (nonatomic, strong) UIButton *wechatButton;             //微信
@property (nonatomic, strong) UIButton *timeLineButton;           //朋友圈
@property (nonatomic, strong) UIButton *qqButton;                 //qq
@property (nonatomic, strong) UIButton *teamButton;               //队友
@property (nonatomic, strong) UIButton *closeButton;              //关闭按钮

@end

@implementation TQInvitatePopViewController

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        viewSize = frame.size;
        self.view.frame = frame;
        self.view.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:self.inviteView];
        [self.view addSubview:self.closeButton];
    }
    return self;
}

- (UIView *)inviteView
{
    if (!_inviteView) {
        _inviteView = [[UIView alloc] initWithFrame:CGRectMake((viewSize.width - 250)/2, (viewSize.height - 180)/2, 250, 180)];
        _inviteView.backgroundColor = [UIColor whiteColor];
        _inviteView.layer.masksToBounds = YES;
        _inviteView.layer.cornerRadius = 5.f;
        interval = (_inviteView.width - 36*2 - 26*4)/3;
        
        [_inviteView addSubview:self.titleLabel];
        [_inviteView addSubview:self.signView];
        [_inviteView addSubview:self.wechatButton];
        [_inviteView addSubview:self.timeLineButton];
        [_inviteView addSubview:self.qqButton];
        [_inviteView addSubview:self.teamButton];
    }
    return _inviteView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 24, _inviteView.width - 16, 12)];
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        _titleLabel.textColor = kTitleTextColor;
        _titleLabel.text = @"邀请队友加入比赛";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)signView
{
    if (!_signView) {
        _signView = [[UIView alloc] initWithFrame:CGRectMake((_inviteView.width - 18)/2, CGRectGetMaxY(_titleLabel.frame) + 12, 18, 4)];
        _signView.backgroundColor = kTitleTextColor;
    }
    return _signView;
}

- (UIButton *)wechatButton
{
    if (!_wechatButton) {
        _wechatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wechatButton setImage:[UIImage imageNamed:@"wechat_share"] forState:UIControlStateNormal];
        [_wechatButton setFrame:CGRectMake(36.f, _signView.bottom + 40, 26, 26)];
        _wechatButton.tag = kInviteButtonBaseTag + InviteTypeWechat;
        [_wechatButton addTarget:self action:@selector(doInvite:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechatButton;
}

- (UIButton *)timeLineButton
{
    if (!_timeLineButton) {
        _timeLineButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeLineButton setImage:[UIImage imageNamed:@"wechat_timeline"] forState:UIControlStateNormal];
        [_timeLineButton setFrame:CGRectMake(_wechatButton.right + interval, _signView.bottom + 40, 26, 26)];
        _timeLineButton.tag = kInviteButtonBaseTag + InviteTypeTimeLine;
        [_timeLineButton addTarget:self action:@selector(doInvite:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeLineButton;
}

- (UIButton *)qqButton
{
    if (!_qqButton) {
        _qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqButton setImage:[UIImage imageNamed:@"qq_share"] forState:UIControlStateNormal];
        [_qqButton setFrame:CGRectMake(_timeLineButton.right + interval, _signView.bottom + 40, 26, 26)];
        _qqButton.tag = kInviteButtonBaseTag + InviteTypeQQ;
        [_qqButton addTarget:self action:@selector(doInvite:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqButton;
}

- (UIButton *)teamButton
{
    if (!_teamButton) {
        _teamButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_teamButton setImage:[UIImage imageNamed:@"wechat_share"] forState:UIControlStateNormal];
        [_teamButton setFrame:CGRectMake(_qqButton.right + interval, _signView.bottom + 40, 26, 26)];
        _teamButton.tag = kInviteButtonBaseTag + InviteTypeTeam;
        [_teamButton addTarget:self action:@selector(doInvite:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _teamButton;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"dialog_close"] forState:UIControlStateNormal];
        [_closeButton setFrame:CGRectMake(_inviteView.right, _inviteView.top - 20, 20, 20)];
        _closeButton.tag = kInviteButtonBaseTag + InviteTypeCancel;
        [_closeButton addTarget:self action:@selector(doInvite:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}


#pragma mark - event

- (void)doInvite:(UIButton *)btn
{
    if (_inviteBlock) {
        _inviteBlock(btn.tag - kInviteButtonBaseTag);
    }
}


@end






