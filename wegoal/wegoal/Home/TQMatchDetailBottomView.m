//
//  TQMatchDetailBottomView.m
//  wegoal
//
//  Created by joker on 2017/3/15.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMatchDetailBottomView.h"

@implementation TQMatchDetailBottomView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"退款条约"];
    NSRange strRange = {0,[str length]};
    [str addAttributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle], NSFontAttributeName:[UIFont systemFontOfSize:10.f], NSForegroundColorAttributeName:kTitleTextColor} range:strRange];
    [_drawBackButton setAttributedTitle:str forState:UIControlStateNormal];
}



@end
