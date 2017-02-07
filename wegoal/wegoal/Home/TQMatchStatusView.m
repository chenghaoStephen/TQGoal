//
//  TQMatchStatusView.m
//  wegoal
//
//  Created by joker on 2016/12/26.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQMatchStatusView.h"
#import "TQMatchCell.h"

@interface TQMatchStatusView()
{
    CGFloat viewWidth;
    CGFloat viewHeight;
}

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *moreButton;
@property (strong, nonatomic) UIView *signView;
@property (strong, nonatomic) TQMatchCell *matchCell;
@property (strong, nonatomic) UIButton *actionButton;

@end

@implementation TQMatchStatusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        viewWidth = frame.size.width;
        viewHeight = frame.size.height;
        [self addSubview:self.titleLabel];
        [self addSubview:self.moreButton];
        [self addSubview:self.signView];
        [self addSubview:self.matchCell];
        [self addSubview:self.actionButton];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 7, viewWidth - 16, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        _titleLabel.textColor = kTitleTextColor;
        _titleLabel.text = @"我的约战";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setFrame:CGRectMake(viewWidth - 25, 7, 20, 20)];
        [_moreButton setImage:[UIImage imageNamed:@"more_share_drop"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"more_share_packup"] forState:UIControlStateSelected];
        [_moreButton addTarget:self action:@selector(showMore) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (UIView *)signView
{
    if (!_signView) {
        _signView = [[UIView alloc] initWithFrame:CGRectMake((viewWidth - 18)/2, CGRectGetMaxY(_titleLabel.frame) + 8, 18, 4)];
        _signView.backgroundColor = kTitleTextColor;
    }
    return _signView;
}

- (TQMatchCell *)matchCell
{
    if (!_matchCell) {
        _matchCell = [[[NSBundle mainBundle] loadNibNamed:@"TQMatchCell" owner:nil options:nil] firstObject];
        [_matchCell setFrame:CGRectMake((viewWidth - SCREEN_WIDTH)/2, CGRectGetMaxY(_signView.frame) + 8, SCREEN_WIDTH, 121)];
    }
    return _matchCell;
}

- (UIButton *)actionButton
{
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionButton setFrame:CGRectMake((viewWidth - 150)/2, viewHeight - 15, 150, 30)];
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


#pragma mark - event

- (void)showMore
{
    NSLog(@"show more.");
}

- (void)doAction
{
    NSLog(@"do action.");
}

@end
