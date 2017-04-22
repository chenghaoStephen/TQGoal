//
//  TQAcceptRefereeCell.m
//  wegoal
//
//  Created by joker on 2017/4/23.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQAcceptRefereeCell.h"

@interface TQAcceptRefereeCell()
{
    NSArray *marksArray;
}

@property (weak, nonatomic) IBOutlet UIImageView *refereeAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *paidAmountLbl;
@property (weak, nonatomic) IBOutlet UIView *bodyView;

@end

@implementation TQAcceptRefereeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    marksArray = @[@"认证比赛", @"一颗备用球", @"四面角旗", @"10件对抗衫", @"气管气针气压计"];
    //添加裁判标签
    CGFloat offsetX = 0;
    CGFloat offsetY = 0;
    for (NSString *markStr in marksArray) {
        //判断是否需要换行
        CGFloat lblWidth = [TQCommon widthForString:markStr fontSize:[UIFont systemFontOfSize:10] andHeight:13];
        if (offsetX + lblWidth + 13 > _bodyView.width - 12) {
            offsetX = 0;
            offsetY += 18;
        }
        //标识
        UIImageView *markImageView = [[UIImageView alloc] initWithFrame:CGRectMake(offsetX, offsetY + 2, 9, 9)];
        markImageView.image = [UIImage imageNamed:@"project_confirm"];
        offsetX += 13;
        [_bodyView addSubview:markImageView];
        //标签文字
        UILabel *markLabel = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, offsetY, lblWidth, 13)];
        markLabel.text = markStr;
        markLabel.textColor = kTitleTextColor;
        markLabel.font = [UIFont systemFontOfSize:10];
        offsetX += lblWidth + 10;
        [_bodyView addSubview:markLabel];
    }
}

- (void)setRefereeData:(TQServiceModel *)refereeData
{
    _refereeData = refereeData;
    [_refereeAvatarImageView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, refereeData.imgUrl)]
                               placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    _nameLabel.text = refereeData.serviceTypeName;
    _costLabel.text = [NSString stringWithFormat:@"￥%@", refereeData.price?:@""];
}


@end
