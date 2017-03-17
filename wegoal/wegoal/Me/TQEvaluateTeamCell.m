//
//  TQEvaluateTeamCell.m
//  wegoal
//
//  Created by joker on 2017/3/17.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQEvaluateTeamCell.h"
#import "XHStarRateView.h"

#define kSignButtonBaseTag     82001
#define kSignButtonWidth       60.f
#define kSignButtonHeight      22.f
@interface TQEvaluateTeamCell()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;
@property (weak, nonatomic) IBOutlet UILabel *loseLabel;
@property (weak, nonatomic) IBOutlet UILabel *drawLabel;

@property (strong, nonatomic) XHStarRateView *starView;
@property (strong, nonatomic) UILabel *pointLabel;

@property (strong, nonatomic) UIView *tagsView;

@end

@implementation TQEvaluateTeamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addSubview:self.starView];
    [self addSubview:self.pointLabel];
    [self addSubview:self.tagsView];
}


- (XHStarRateView *)starView
{
    if (!_starView) {
        __weak typeof(self) weakSelf = self;
        _starView = [[XHStarRateView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 135)/2, CGRectGetMaxY(_avatarImageView.frame) + 27, 135, 20) numberOfStars:5 rateStyle:HalfStar isAnination:YES finish:^(CGFloat currentScore) {
            CGFloat tmp = fmod(currentScore, (int)currentScore);
            if (tmp == 0) {
                weakSelf.pointLabel.text = [NSString stringWithFormat:@"%d", (int)currentScore];
            } else {
                weakSelf.pointLabel.text = [NSString stringWithFormat:@"%.1f", currentScore];
            }
        }];
    }
    return _starView;
}

- (UILabel *)pointLabel
{
    if (!_pointLabel) {
        _pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_starView.frame) + 8, _starView.y, 30, 20)];
        _pointLabel.font = [UIFont systemFontOfSize:12.f];
        _pointLabel.textColor = [UIColor blackColor];
        _pointLabel.textAlignment = NSTextAlignmentLeft;
        _pointLabel.text = @"0";
    }
    return _pointLabel;
}

- (UIView *)tagsView
{
    if (!_tagsView) {
        _tagsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_starView.frame) + 8, SCREEN_WIDTH, 80)];
        _tagsView.backgroundColor = [UIColor whiteColor];
        
        CGFloat intervalXLine1 = (SCREEN_WIDTH - 4*kSignButtonWidth)/5;
        CGFloat intervalXLine2 = (SCREEN_WIDTH - 3*kSignButtonWidth)/4;
        for (NSInteger i = 0; i < 7; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.titleLabel.font = [UIFont systemFontOfSize:10.f];
            [button setTitle:@"完美" forState:UIControlStateNormal];
            [button setTitle:@"完美" forState:UIControlStateSelected];
            [button setTitleColor:kNavTitleColor forState:UIControlStateNormal];
            [button setTitleColor:kRedBackColor forState:UIControlStateSelected];
            if (i < 4) {
                button.frame = CGRectMake(intervalXLine1*(i + 1) + kSignButtonWidth*i, 15, kSignButtonWidth, kSignButtonHeight);
            } else {
                button.frame = CGRectMake(intervalXLine2*(i - 3) + kSignButtonWidth*(i - 4), 25 + kSignButtonHeight, kSignButtonWidth, kSignButtonHeight);
            }
            button.tag = kSignButtonBaseTag + i;
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = kSignButtonHeight/2;
            button.layer.borderColor = kNavTitleColor.CGColor;
            button.layer.borderWidth = 1.0;
            [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [_tagsView addSubview:button];
        }
        
    }
    return _tagsView;
}

- (void)setCanEdit:(BOOL)canEdit
{
    _canEdit = canEdit;
    self.starView.canEdit = canEdit;
    
    for (UIView *subView in _tagsView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            ((UIButton *)subView).enabled = canEdit;
        }
    }
}


#pragma mark - events

- (void)selectButton:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        btn.layer.borderColor = kRedBackColor.CGColor;
    } else {
        btn.layer.borderColor = kNavTitleColor.CGColor;
    }
}


@end
