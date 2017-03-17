//
//  TQPlayTextCell.m
//  wegoal
//
//  Created by joker on 2017/3/17.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQPlayTextCell.h"


@interface TQPlayTextCell()



@end

@implementation TQPlayTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _infoLabel.layer.masksToBounds = YES;
    _infoLabel.layer.cornerRadius = _infoLabel.height/2;
    
    _leftInfoLabel.hidden = YES;
    _leftImageView.hidden = YES;
    _rightInfoLabel.hidden = YES;
    _rightImageView.hidden = YES;
}



@end
