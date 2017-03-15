//
//  TQMatchModel.h
//  wegoal
//
//  Created by joker on 2017/2/6.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQMatchModel : NSObject

@property (nonatomic, copy) NSString *enrollId;       //id
@property (nonatomic, copy) NSString *gameName;       //名称
@property (nonatomic, copy) NSString *team1Logo;      //球队1logo
@property (nonatomic, copy) NSString *team1Name;      //球队1名称
@property (nonatomic, copy) NSString *team1Win;       //球队1胜
@property (nonatomic, copy) NSString *team1Lose;      //球队1负
@property (nonatomic, copy) NSString *team1Draw;      //球队1平
@property (nonatomic, copy) NSString *team1GameCount; //球队1比赛
@property (nonatomic, copy) NSString *team1Rank;      //球队1等级
@property (nonatomic, copy) NSString *team2Logo;      //球队2logo
@property (nonatomic, copy) NSString *team2Name;      //球队2名称
@property (nonatomic, copy) NSString *team2Win;       //球队2胜
@property (nonatomic, copy) NSString *team2Lose;      //球队2负
@property (nonatomic, copy) NSString *team2Draw;      //球队2平
@property (nonatomic, copy) NSString *team2GameCount; //球队2比赛
@property (nonatomic, copy) NSString *team2Rank;      //球队2等级
@property (nonatomic, copy) NSString *gameRules;      //赛制
@property (nonatomic, copy) NSString *gamePlace;      //地点
@property (nonatomic, copy) NSString *placeFee;       //场地费用
@property (nonatomic, copy) NSString *gamePlaceId;    //地点id
@property (nonatomic, copy) NSString *gameDate;       //时间
@property (nonatomic, copy) NSString *status;         //约战状态
@property (nonatomic, copy) NSString *referee;        //裁判

@end
