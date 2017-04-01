//
//  TQMemberModel.h
//  wegoal
//
//  Created by joker on 2017/3/10.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQMemberModel : NSObject

@property (nonatomic, copy) NSString *memberId;           //id
@property (nonatomic, copy) NSString *userName;           //用户名
@property (nonatomic, copy) NSString *headPic;            //头像
@property (nonatomic, copy) NSString *memberName;         //姓名
@property (nonatomic, copy) NSString *memberNumber;       //号码
@property (nonatomic, copy) NSString *memberPosition;     //位置
@property (nonatomic, copy) NSString *memberPositionColor;//颜色
@property (nonatomic, copy) NSString *memberHeight;       //身高
@property (nonatomic, copy) NSString *memberWeight;       //体重
@property (nonatomic, copy) NSString *memberAge;          //年龄
@property (nonatomic, copy) NSString *mvp;                //mvp数
@property (nonatomic, copy) NSString *score;              //得分
@property (nonatomic, copy) NSString *goal;               //进球数
@property (nonatomic, copy) NSString *gameCount;          //比赛场次
@property (nonatomic, copy) NSString *winRate;            //胜率
@property (nonatomic, copy) NSString *temName;            //队名
@property (nonatomic, copy) NSString *isLeader;           //是否是队长
@property (nonatomic, copy) NSString *red;                //红牌数
@property (nonatomic, copy) NSString *yellow;             //黄牌数
@property (nonatomic, assign) BOOL isMvp;                 //是否值本场mvp
@property (nonatomic, assign) NSUInteger point;           //得分

@end
