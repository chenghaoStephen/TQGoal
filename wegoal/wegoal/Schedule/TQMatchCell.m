//
//  TQMatchCell.m
//  wegoal
//
//  Created by joker on 2016/12/26.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQMatchCell.h"
#import "TQProtocolViewController.h"

@interface TQMatchCell()
@property (weak, nonatomic) IBOutlet UILabel *certifiySign;     //认证标识
@property (weak, nonatomic) IBOutlet UIImageView *team1Image;   //球队1logo
@property (weak, nonatomic) IBOutlet UILabel *team1Name;        //球队1名称
@property (weak, nonatomic) IBOutlet UIImageView *team2Image;   //球队2logo
@property (weak, nonatomic) IBOutlet UILabel *team2Name;        //球队2名称
@property (weak, nonatomic) IBOutlet UILabel *scoreLbl;         //比分
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;  //状态标识
@property (weak, nonatomic) IBOutlet UILabel *vsLbl;            //vs
@property (weak, nonatomic) IBOutlet UIImageView *team1Status;  //球队1状态
@property (weak, nonatomic) IBOutlet UIImageView *team2Status;  //球队2状态
@property (weak, nonatomic) IBOutlet UILabel *systemLbl;        //赛制
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;       //地点
@property (weak, nonatomic) IBOutlet UILabel *time1Lbl;         //时间-星期
@property (weak, nonatomic) IBOutlet UILabel *time2Lbl;         //时间-年月日
@property (weak, nonatomic) IBOutlet UIView *lineView;          //分割线

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *time1CenterConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *team1LeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *team2RightConstraint;

@end


@implementation TQMatchCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _certifiySign.hidden = YES;
    _time2Lbl.hidden = YES;
    _lineView.hidden = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _team1Image.layer.masksToBounds = YES;
    _team1Image.layer.cornerRadius = _team1Image.height/2;
    _team2Image.layer.masksToBounds = YES;
    _team2Image.layer.cornerRadius = _team2Image.height/2;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    _team1LeftConstraint.constant = 54 * SCALE375;
    _team2RightConstraint.constant = 54 * SCALE375;
}

- (void)setIsShowLine:(BOOL)isShowLine
{
    if (isShowLine) {
        _lineView.hidden = NO;
        _lineView.backgroundColor = kMainBackColor;
    } else {
        _lineView.hidden = YES;
    }
}

- (void)setMatchData:(TQMatchModel *)matchData
{
    _matchData = matchData;
    
    //比赛信息
    _team1Name.text = matchData.team1Name;
    [_team1Image sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, matchData.team1Logo)]
                   placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    
    if ([TQCommon isBlankString:matchData.team2Name]) {
        _team2Name.text = @"待定中";
        [_team2Image setImage:[UIImage imageNamed:@"defaultHeadImage"]];
        [_team2Status setImage:[UIImage imageNamed:@"teaming"]];
    } else {
        _team2Name.text = matchData.team2Name;
        [_team2Image sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, matchData.team2Logo)]
                       placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
        [_team2Status setImage:[UIImage imageNamed:@"team_success"]];
    }
//    _scoreLbl.text = matchData.gameDate;
    _systemLbl.text = matchData.gameRules;
    _addressLbl.text = matchData.gamePlace;
    //显示日期和星期
    if (matchData.gameDate.length == 12) {
        NSDate *date = [NSDate dateFromString:matchData.gameDate format:kDateFormatter1];
        _scoreLbl.text = [NSDate datestrFromDate:date withDateFormat:kDateFormatter2];
        _time1Lbl.text = [TQCommon weekStringFromDate:date];
        _time2Lbl.text = @"";
    } else {
        _scoreLbl.text = @"";
        _time1Lbl.text = @"";
        _time2Lbl.text = @"";
    }
    
}

- (void)setIsMine:(BOOL)isMine
{
    _isMine = isMine;
    if (isMine && [TQCommon isBlankString:_matchData.team2Name]) {
        _team2Name.text = @"待定中";
        [_team2Image setImage:[UIImage imageNamed:@"defaultHeadImage"]];
        [_team2Status setImage:[UIImage imageNamed:@"teaming"]];
        
    } else if (!isMine && [TQCommon isBlankString:_matchData.team2Name]) {
        _team2Name.text = @"点击应战";
        [_team2Image setImage:[UIImage imageNamed:@"competitor"]];
        [_team2Status setImage:[UIImage imageNamed:@"teaming"]];
        _team2Image.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(acceptMatch)];
        [_team2Image addGestureRecognizer:tapGesture];
    }
}

//点击应战
- (void)acceptMatch
{
    if (_isMine || ![TQCommon isBlankString:_matchData.team2Name]) {
        return;
    }
    
    TQProtocolViewController *protocolVC = [[TQProtocolViewController alloc] init];
    protocolVC.isAccept = YES;
    protocolVC.matchData = _matchData;
    [(TQBaseViewController *)self.viewController pushViewController:protocolVC];
    
}

- (void)clearInformation
{
    _team1Name.text = @"";
    [_team1Image setImage:[UIImage imageNamed:@"defaultHeadImage"]];
    [_team1Status setImage:[UIImage imageNamed:@"teaming"]];
    _team2Name.text = @"";
    [_team2Image setImage:[UIImage imageNamed:@"defaultHeadImage"]];
    [_team2Status setImage:[UIImage imageNamed:@"teaming"]];
    _scoreLbl.text = @"--";
    _systemLbl.text = @"--";
    _addressLbl.text = @"--";
    _time1Lbl.text = @"--";
    _time2Lbl.text = @"";
}


@end
