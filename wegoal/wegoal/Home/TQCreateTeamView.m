//
//  TQCreateTeamView.m
//  wegoal
//
//  Created by joker on 2016/12/26.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQCreateTeamView.h"
#import "TQJoinTeamViewController.h"
#import "TQCreateTeamViewController.h"
#import "TQLoginViewController.h"

@interface TQCreateTeamView()
{
    CGFloat viewWidth;
}

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *signView;
@property (strong, nonatomic) UIButton *joinButton;
@property (strong, nonatomic) UILabel *subLabel;
@property (strong, nonatomic) UIButton *createButton;

@end

@implementation TQCreateTeamView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        viewWidth = frame.size.width;
        [self addSubview:self.titleLabel];
        [self addSubview:self.signView];
        [self addSubview:self.joinButton];
        [self addSubview:self.subLabel];
        [self addSubview:self.createButton];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 7, viewWidth - 16, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        _titleLabel.textColor = kTitleTextColor;
        _titleLabel.text = @"您还没有加入任何球队，您可以";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)signView
{
    if (!_signView) {
        _signView = [[UIView alloc] initWithFrame:CGRectMake((viewWidth - 18)/2, CGRectGetMaxY(_titleLabel.frame) + 8, 18, 4)];
        _signView.backgroundColor = kTitleTextColor;
    }
    return _signView;
}

- (UIButton *)joinButton
{
    if (!_joinButton) {
        _joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_joinButton setFrame:CGRectMake((viewWidth - 185)/2, CGRectGetMaxY(_signView.frame) + 16, 185, 33)];
        _joinButton.backgroundColor = kSubjectBackColor;
        [_joinButton setTitle:@"加入球队" forState:UIControlStateNormal];
        [_joinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _joinButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_joinButton addTarget:self action:@selector(joinTeam) forControlEvents:UIControlEventTouchUpInside];
        
        _joinButton.layer.masksToBounds = YES;
        _joinButton.layer.cornerRadius = CGRectGetHeight(_joinButton.frame)/2;
    }
    return _joinButton;
}

- (UILabel *)subLabel
{
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(_joinButton.frame) + 8, viewWidth - 16, 20)];
        _subLabel.font = [UIFont systemFontOfSize:12.f];
        _subLabel.textColor = kSubTextColor;
        _subLabel.text = @"或者";
        _subLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _subLabel;
}

- (UIButton *)createButton
{
    if (!_createButton) {
        _createButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_createButton setFrame:CGRectMake((viewWidth - 185)/2, CGRectGetMaxY(_subLabel.frame) + 8, 185, 33)];
        _createButton.backgroundColor = [UIColor clearColor];
        [_createButton setTitle:@"创建球队" forState:UIControlStateNormal];
        [_createButton setTitleColor:kTitleTextColor forState:UIControlStateNormal];
        _createButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_createButton addTarget:self action:@selector(createTeam) forControlEvents:UIControlEventTouchUpInside];
        
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        borderLayer.bounds = _createButton.bounds;
        borderLayer.position = CGPointMake(CGRectGetMidX(_createButton.bounds), CGRectGetMidY(_createButton.bounds));
        borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:CGRectGetWidth(borderLayer.bounds)/2].CGPath;
        borderLayer.lineWidth = 1.5f;
        borderLayer.lineDashPattern = @[@4, @2];
        borderLayer.strokeColor = kTitleTextColor.CGColor;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        
        [_createButton.layer addSublayer:borderLayer];
    }
    return _createButton;
}

- (void)joinTeam
{
    if (!USER_TOKEN) {
        //跳转到登录界面
        [self jumpToLoginVC];
    } else {
        //跳转到加入球队界面
        TQJoinTeamViewController *joinTeamVC = [[TQJoinTeamViewController alloc] init];
        [(TQBaseViewController *)self.viewController pushViewController:joinTeamVC];
    }
    
}

- (void)createTeam
{
    if (!USER_TOKEN) {
        //跳转到登录界面
        [self jumpToLoginVC];
    } else {
        //跳转到创建球队界面
        TQCreateTeamViewController *createTeamVC = [[TQCreateTeamViewController alloc] init];
        [(TQBaseViewController *)self.viewController pushViewController:createTeamVC];
    }
    
}

- (void)jumpToLoginVC
{
    TQLoginViewController *loginVC = [[TQLoginViewController alloc] init];
    loginVC.originVC = self.viewController;
    [(TQBaseViewController *)self.viewController pushViewController:loginVC];
}

@end
