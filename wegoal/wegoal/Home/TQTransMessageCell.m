//
//  TQTransMessageCell.m
//  wegoal
//
//  Created by joker on 2017/4/22.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQTransMessageCell.h"

@interface TQTransMessageCell()

@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *amountLbl;
@property (weak, nonatomic) IBOutlet UILabel *accountLbl;
@property (weak, nonatomic) IBOutlet UILabel *rechargeTimeLbl;

@end

@implementation TQTransMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _timeView.layer.masksToBounds = YES;
    _timeView.layer.cornerRadius = 6.f;
    _detailView.layer.masksToBounds = YES;
    _detailView.layer.cornerRadius = 2.f;
}



@end
