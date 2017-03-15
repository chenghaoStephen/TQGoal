//
//  TQMatchDetailTopView.m
//  wegoal
//
//  Created by joker on 2017/3/15.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMatchDetailTopView.h"

@interface TQMatchDetailTopView()

@property (weak, nonatomic) IBOutlet UIImageView *team1AvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *team1NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *team1RankLabel;
@property (weak, nonatomic) IBOutlet UILabel *team1GameLabel;
@property (weak, nonatomic) IBOutlet UILabel *team1WinLabel;
@property (weak, nonatomic) IBOutlet UILabel *team1LoseLabel;
@property (weak, nonatomic) IBOutlet UILabel *team1DrawLabel;
@property (weak, nonatomic) IBOutlet UIImageView *team2AvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *team2NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *team2RankLabel;
@property (weak, nonatomic) IBOutlet UILabel *team2GameLabel;
@property (weak, nonatomic) IBOutlet UILabel *team2WinLabel;
@property (weak, nonatomic) IBOutlet UILabel *team2LoseLabel;
@property (weak, nonatomic) IBOutlet UILabel *team2DrawLabel;

@end

@implementation TQMatchDetailTopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _team1AvatarImageView.layer.masksToBounds = YES;
    _team1AvatarImageView.layer.cornerRadius = _team1AvatarImageView.height/2;
    _team2AvatarImageView.layer.masksToBounds = YES;
    _team2AvatarImageView.layer.cornerRadius = _team2AvatarImageView.height/2;
}

- (void)setMatchData:(TQMatchModel *)matchData
{
    _matchData = matchData;
    //球队1
    [_team1AvatarImageView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, matchData.team1Logo)]
                             placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    _team1NameLabel.text = matchData.team1Name;
    _team1RankLabel.text = [NSString stringWithFormat:@"Rank %@", matchData.team1Rank];
    _team1GameLabel.text = [NSString stringWithFormat:@"场次：%@", matchData.team1GameCount];
    _team1WinLabel.text = matchData.team1Win;
    _team1LoseLabel.text = matchData.team1Lose;
    _team1DrawLabel.text = matchData.team1Draw;
    //球队2
    [_team2AvatarImageView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, matchData.team2Logo)]
                             placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    _team2NameLabel.text = matchData.team2Name;
    _team2RankLabel.text = [NSString stringWithFormat:@"Rank %@", matchData.team2Rank];
    _team2GameLabel.text = [NSString stringWithFormat:@"场次：%@", matchData.team2GameCount];
    _team2WinLabel.text = matchData.team2Win;
    _team2LoseLabel.text = matchData.team2Lose;
    _team2DrawLabel.text = matchData.team2Draw;
}


@end
