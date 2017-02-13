//
//  TQTeamTopView.m
//  wegoal
//
//  Created by joker on 2017/2/8.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQTeamTopView.h"

@interface TQTeamTopView ()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *decorationImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchNumlabel;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;
@property (weak, nonatomic) IBOutlet UILabel *loseLabel;
@property (weak, nonatomic) IBOutlet UILabel *tieLabel;
@property (weak, nonatomic) IBOutlet UIImageView *yellowImageView;
@property (weak, nonatomic) IBOutlet UILabel *yellowCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *redImageView;
@property (weak, nonatomic) IBOutlet UILabel *redCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoImageLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *informationLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backImageWidthConstraint;

@end

@implementation TQTeamTopView

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    _logoImageLeftConstraint.constant = 35 * SCALE375;
    _informationLeftConstraint.constant = 26 * SCALE375;
    _backImageWidthConstraint.constant = SCREEN_WIDTH;
}

- (void)setViewMode:(TeamTopViewMode)viewMode
{
    _viewMode = viewMode;
    if (viewMode == TeamTopViewModeLadder) {
        _decorationImageView.hidden = NO;
        _yellowImageView.hidden = YES;
        _yellowCountLabel.hidden = YES;
        _redImageView.hidden = YES;
        _redCountLabel.hidden = YES;
        _heightLabel.hidden = YES;
        _weightLabel.hidden = YES;
        _ageLabel.hidden = YES;
    } else {
        _decorationImageView.hidden = YES;
        _yellowImageView.hidden = NO;
        _yellowCountLabel.hidden = NO;
        _redImageView.hidden = NO;
        _redCountLabel.hidden = NO;
        _heightLabel.hidden = NO;
        _weightLabel.hidden = NO;
        _ageLabel.hidden = NO;
    }
}

- (void)setTeamInfo:(TQMatchModel *)teamInfo
{
    _teamInfo = teamInfo;
}


#pragma mark - events



@end




