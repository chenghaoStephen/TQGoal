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
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *decorationImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchNumlabel;
@property (weak, nonatomic) IBOutlet UILabel *winLabel;
@property (weak, nonatomic) IBOutlet UILabel *loseLabel;
@property (weak, nonatomic) IBOutlet UILabel *tieLabel;

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
    
    _logoImageLeftConstraint.constant = 35 * SCREEN_WIDTH/375;
    _informationLeftConstraint.constant = 26 * SCREEN_WIDTH/375;
    _backImageWidthConstraint.constant = SCREEN_WIDTH;
}

- (void)setTeamInfo:(TQMatchModel *)teamInfo
{
    _teamInfo = teamInfo;
}


#pragma mark - events

- (IBAction)searchAction:(id)sender {
    
}


@end




