//
//  TQMatchRefereeCell.m
//  wegoal
//
//  Created by joker on 2017/3/9.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMatchRefereeCell.h"

@interface TQMatchRefereeCell()
{
    NSArray *marksArray;
}

@property (weak, nonatomic) IBOutlet UIView *refereeTopView;
@property (weak, nonatomic) IBOutlet UIView *refereeDetailView;
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UIImageView *refereeAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UIImageView *packupImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImageLeftConstraint;

@end

@implementation TQMatchRefereeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    marksArray = @[@"认证比赛", @"一颗备用球", @"四面角旗", @"10件对抗衫", @"气管气针气压计"];
    //添加裁判标签
    CGFloat offsetX = _nameLabel.x;
    CGFloat offsetY = CGRectGetMaxY(_nameLabel.frame) + 20;
    for (NSString *markStr in marksArray) {
        //判断是否需要换行
        CGFloat lblWidth = [TQCommon widthForString:markStr fontSize:[UIFont systemFontOfSize:10] andHeight:13];
        if (offsetX + lblWidth + 13 > SCREEN_WIDTH - 60) {
            offsetX = _nameLabel.x;
            offsetY += 18;
        }
        //标识
        UIImageView *markImageView = [[UIImageView alloc] initWithFrame:CGRectMake(offsetX, offsetY + 2, 9, 9)];
        markImageView.image = [UIImage imageNamed:@"project_confirm"];
        offsetX += 13;
        [_refereeDetailView addSubview:markImageView];
        //标签文字
        UILabel *markLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, offsetY, lblWidth, 13)];
        markLabel.text = markStr;
        markLabel.textColor = kTitleTextColor;
        markLabel.font = [UIFont systemFontOfSize:10];
        offsetX += lblWidth + 10;
        [_refereeDetailView addSubview:markLabel];
    }
    
    //添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(packupDetailView)];
    [_refereeTopView addGestureRecognizer:tapGesture];
    
}


#pragma mark - events

- (IBAction)selectAction:(id)sender {
    _selectedButton.selected = !_selectedButton.selected;
    
}

- (void)setCanSelected:(BOOL)canSelected
{
    _canSelected = canSelected;
    if (canSelected) {
        _selectedButton.hidden = NO;
        _avatarImageLeftConstraint.constant = 32.f;
    } else {
        _selectedButton.hidden = YES;
        _avatarImageLeftConstraint.constant = 8.f;
    }
}

- (void)packupDetailView
{
    _block(!_isPackup);
}

- (void)setIsPackup:(BOOL)isPackup
{
    _isPackup = isPackup;
    if (isPackup) {
        _refereeDetailView.hidden = YES;
        _packupImageView.image = [UIImage imageNamed:@"drop_gray"];
    } else {
        _refereeDetailView.hidden = NO;
        _packupImageView.image = [UIImage imageNamed:@"packup_gray"];
    }
}


@end
