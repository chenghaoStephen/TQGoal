//
//  TQMeTopView.m
//  wegoal
//
//  Created by joker on 2017/2/9.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMeTopView.h"

@interface TQMeTopView()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *gradeSignLbl;
@property (weak, nonatomic) IBOutlet UILabel *gradeLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *goalNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *winRateLbl;
@property (weak, nonatomic) IBOutlet UIImageView *yellowCardImageView;
@property (weak, nonatomic) IBOutlet UIImageView *redCardImageView;
@property (weak, nonatomic) IBOutlet UILabel *yellowCardNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *redCardNumLbl;

@end

@implementation TQMeTopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _gradeSignLbl.layer.masksToBounds = YES;
    _gradeSignLbl.layer.cornerRadius = _gradeSignLbl.height/2;
    _yellowCardImageView.layer.masksToBounds = YES;
    _yellowCardImageView.layer.cornerRadius = 1.5;
    _redCardImageView.layer.masksToBounds = YES;
    _redCardImageView.layer.cornerRadius = 1.5;
}



@end
