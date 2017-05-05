//
//  TQTeamModel.h
//  wegoal
//
//  Created by joker on 2017/2/8.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQTeamModel : NSObject

/*
"teamId": "2",
"teamLogo": "/upload/201702/28/201702282043552018.jpg",
"teamName": "测试队A2",
"poloShirtColor": "红色",
"win": "0",
"lose": "0",
"draw": "0",
"gameCount": "0",
"score": null,
"rank": "",
"yellow": "",
"red": ""
"averageHeight": "178",
"averageWeight": "77",
"averageAge": "33"
 */

@property (nonatomic, copy) NSString *teamId;          //球队id
@property (nonatomic, copy) NSString *teamLogo;        //球队logo
@property (nonatomic, copy) NSString *teamName;        //球队名称
@property (nonatomic, copy) NSString *poloShirtColor;  //球衣颜色
@property (nonatomic, copy) NSString *win;             //胜场
@property (nonatomic, copy) NSString *lose;            //负场
@property (nonatomic, copy) NSString *draw;            //平场
@property (nonatomic, copy) NSString *gameCount;       //比赛场次
@property (nonatomic, copy) NSString *score;           //比分
@property (nonatomic, copy) NSString *rank;            //等级
@property (nonatomic, copy) NSString *yellow;          //黄牌
@property (nonatomic, copy) NSString *red;             //红牌
@property (nonatomic, copy) NSString *averageHeight;   //平均身高
@property (nonatomic, copy) NSString *averageWeight;   //平均体重
@property (nonatomic, copy) NSString *averageAge;      //平均年龄
@property (nonatomic, copy) NSString *teamCreateDate;  //成立时间
@property (nonatomic, copy) NSString *contactName;     //负责人姓名
@property (nonatomic, copy) NSString *contactPhone;    //联系人电话
@property (nonatomic, copy) NSString *teamBrief;       //球队介绍

@end
