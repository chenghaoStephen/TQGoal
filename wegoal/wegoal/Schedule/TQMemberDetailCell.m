//
//  TQMemberDetailCell.m
//  wegoal
//
//  Created by joker on 2017/2/14.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMemberDetailCell.h"
#import "TQHeightBackView.h"
#import "TQWeightBackView.h"

@interface TQMemberDetailCell()

@property (weak, nonatomic) IBOutlet UIView *memberView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *yellowCardImageView;
@property (weak, nonatomic) IBOutlet UILabel *yellowCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *redCardImageView;
@property (weak, nonatomic) IBOutlet UILabel *redCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *goalCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberNoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *clothesImageView;
@property (nonatomic, strong) TQHeightBackView *heightBackView;
@property (nonatomic, strong) TQWeightBackView *weightBackView;
@property (nonatomic, strong) UILabel *heightLabel;
@property (nonatomic, strong) UILabel *weightLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *clothesRightConstraint;

@end

@implementation TQMemberDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _memberView.layer.cornerRadius = 8.f;
    _memberView.layer.masksToBounds = NO;
    _memberView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _memberView.layer.shadowOpacity = 0.5;
    _memberView.layer.shadowRadius = 8.0f;
    _memberView.layer.shadowOffset = CGSizeMake(3, 3);
    
    _avatarImageView.layer.masksToBounds = NO;
    _avatarImageView.layer.cornerRadius = _avatarImageView.height/2;
    _positionLabel.layer.masksToBounds = YES;
    _positionLabel.layer.cornerRadius = _positionLabel.height/2;
    _yellowCardImageView.layer.masksToBounds = YES;
    _yellowCardImageView.layer.cornerRadius = 1.5;
    _redCardImageView.layer.masksToBounds = YES;
    _redCardImageView.layer.cornerRadius = 1.5;
    
    [self.memberView addSubview:self.heightBackView];
    [self.memberView addSubview:self.weightBackView];
    [self.memberView addSubview:self.heightLabel];
    [self.memberView addSubview:self.weightLabel];
}

- (TQHeightBackView *)heightBackView
{
    if (!_heightBackView) {
        _heightBackView = [[TQHeightBackView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 69 - 47 * SCALE375 + 5, CGRectGetMinY(_clothesImageView.frame), 15, _clothesImageView.height)];
        _heightBackView.backgroundColor = [UIColor clearColor];
    }
    return _heightBackView;
}

- (TQWeightBackView *)weightBackView
{
    if (!_weightBackView) {
        _weightBackView = [[TQWeightBackView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 69 - 47 * SCALE375 - _clothesImageView.width * 0.5 - 28, CGRectGetMaxY(_clothesImageView.frame) + 23, 56, 17)];
        _weightBackView.backgroundColor = [UIColor clearColor];
    }
    return _weightBackView;
}

- (UILabel *)heightLabel
{
    if (!_heightLabel) {
        _heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(_heightBackView.centerX - 25, _heightBackView.centerY - 15, 50, 30)];
        _heightLabel.font = [UIFont systemFontOfSize:12.f];
        _heightLabel.textColor = kNavTitleColor;
        _heightLabel.textAlignment = NSTextAlignmentCenter;
        _heightLabel.backgroundColor = [UIColor whiteColor];
        _heightLabel.text = @"---CM";
    }
    return _heightLabel;
}

- (UILabel *)weightLabel
{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(_weightBackView.centerX - 20, _weightBackView.centerY - 12, 40, 12)];
        _weightLabel.font = [UIFont systemFontOfSize:12.f];
        _weightLabel.textColor = kNavTitleColor;
        _weightLabel.textAlignment = NSTextAlignmentCenter;
        _weightLabel.backgroundColor = [UIColor whiteColor];
        _weightLabel.text = @"--KG";
    }
    return _weightLabel;
}

- (void)updateConstraints
{
    [super updateConstraints];
    _clothesRightConstraint.constant = 47 * SCALE375;
}

@end
