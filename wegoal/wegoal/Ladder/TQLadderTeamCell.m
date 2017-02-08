//
//  TQLadderTeamCell.m
//  wegoal
//
//  Created by joker on 2017/2/8.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQLadderTeamCell.h"

@interface TQLadderTeamCell ()

@property (weak, nonatomic) IBOutlet UILabel *ladderNoLbl;
@property (weak, nonatomic) IBOutlet UIImageView *teamImageView;
@property (weak, nonatomic) IBOutlet UILabel *teamNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchNumberLbl;
@property (weak, nonatomic) IBOutlet UILabel *winRateLbl;
@property (weak, nonatomic) IBOutlet UILabel *rankLbl;

@end

@implementation TQLadderTeamCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _teamImageView.layer.masksToBounds = YES;
    _teamImageView.layer.cornerRadius = _teamImageView.height/2;
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

- (void)setLadderNo:(NSInteger)ladderNo
{
    _ladderNo = ladderNo;
    _ladderNoLbl.text = [NSString stringWithFormat:@"%ld", ladderNo];
    //前3名特殊处理
    if (ladderNo >= 1 && ladderNo <= 3) {
        _ladderNoLbl.textColor = [UIColor whiteColor];
        _ladderNoLbl.layer.masksToBounds = YES;
        _ladderNoLbl.layer.cornerRadius = _ladderNoLbl.height/2;
        
        if (ladderNo == 1) {
            _ladderNoLbl.backgroundColor = RGB16(0xF8C041);
        } else if (ladderNo == 2) {
            _ladderNoLbl.backgroundColor = RGB16(0x97ABB5);
        } else if (ladderNo == 3) {
            _ladderNoLbl.backgroundColor = RGB16(0xD6AD85);
        }
    } else {
        _ladderNoLbl.textColor = kTitleTextColor;
        _ladderNoLbl.backgroundColor = [UIColor clearColor];
    }

}

@end
