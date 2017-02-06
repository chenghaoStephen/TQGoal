//
//  TQMatchCell.m
//  wegoal
//
//  Created by joker on 2016/12/26.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQMatchCell.h"

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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *time1CenterConstraint;

@property (strong, nonatomic) TQMatchModel *matchData;

@end


@implementation TQMatchCell


@end
