//
//  TQMeTopView.m
//  wegoal
//
//  Created by joker on 2017/2/9.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMeTopView.h"

@interface TQMeTopView()
{
    TQMemberModel *userInfo;
}

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


- (void)updateUserInformation
{
    userInfo = [UserDataManager getUserData];
    if (userInfo) {
        [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, userInfo.headPic)]
                            placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    } else {
        [_avatarImageView setImage:[UIImage imageNamed:@"defaultHeadImage"]];
    }
    
    if (userInfo) {
        _gradeSignLbl.text = userInfo.memberPosition;
        _gradeLbl.text = userInfo.memberNumber;
        _nameLbl.text = userInfo.memberName;
        _goalNumLbl.text = userInfo.goal;
        _matchNumLbl.text = userInfo.gameCount;
        _winRateLbl.text = userInfo.winRate;
        _yellowCardNumLbl.text = userInfo.yellow;
        _redCardNumLbl.text = userInfo.red;
    } else {
        _gradeSignLbl.text = @"";
        _gradeLbl.text = @"";
        _nameLbl.text = @"";
        _goalNumLbl.text = @"";
        _matchNumLbl.text = @"";
        _winRateLbl.text = @"";
        _yellowCardNumLbl.text = @"";
        _redCardNumLbl.text = @"";
    }
}



@end
