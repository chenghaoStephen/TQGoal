//
//  TQTeamApplyCell.m
//  wegoal
//
//  Created by joker on 2017/4/20.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQTeamApplyCell.h"

@interface TQTeamApplyCell()

@property (weak, nonatomic) IBOutlet UIImageView *teamLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *teamZoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *gameCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *winLbl;
@property (weak, nonatomic) IBOutlet UILabel *loseLbl;
@property (weak, nonatomic) IBOutlet UILabel *drawLbl;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;

@end

@implementation TQTeamApplyCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _teamLogoImageView.layer.masksToBounds = YES;
    _teamLogoImageView.layer.cornerRadius = 4.f;
    _joinButton.layer.masksToBounds = YES;
    _joinButton.layer.cornerRadius = 8.f;
    
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下方添加一条分隔线
    CGContextSetStrokeColorWithColor(context, kMainBackColor.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - .5, rect.size.width, .5));
}

- (void)setTeamData:(TQTeamModel *)teamData
{
    _teamData = teamData;
    if (teamData) {
        [_teamLogoImageView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, teamData.teamLogo)]
                              placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
        _teamNameLbl.text = teamData.teamName;
        _teamZoneLbl.text = @"";
        _gameCountLbl.text = [NSString stringWithFormat:@"场次：%@", teamData.gameCount];
        _winLbl.text = [NSString stringWithFormat:@"胜：%@", teamData.win];
        _loseLbl.text = [NSString stringWithFormat:@"负：%@", teamData.lose];
        _drawLbl.text = [NSString stringWithFormat:@"平：%@", teamData.draw];
    } else {
        _teamLogoImageView.image = [UIImage imageNamed:@""];
        _teamNameLbl.text = @"";
        _teamZoneLbl.text = @"";
        _gameCountLbl.text = @"";
        _winLbl.text = @"";
        _loseLbl.text = @"";
        _drawLbl.text = @"";
    }
}


#pragma mark - events

- (IBAction)joinAction:(id)sender {
    if (_applyBlock) {
        _applyBlock();
    }
}



@end
