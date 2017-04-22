//
//  TQMatchMessageCell.m
//  wegoal
//
//  Created by joker on 2017/4/22.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMatchMessageCell.h"


@interface TQMatchMessageCell()

@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchRivalLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchTimeLbl;

@end


@implementation TQMatchMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _timeView.layer.masksToBounds = YES;
    _timeView.layer.cornerRadius = 6.f;
    _detailView.layer.masksToBounds = YES;
    _detailView.layer.cornerRadius = 2.f;
}


@end
