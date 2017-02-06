//
//  TQMatchModel.h
//  wegoal
//
//  Created by joker on 2017/2/6.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQMatchModel : NSObject

@property (nonatomic, assign) BOOL isCertify;        //是否认证
@property (nonatomic, copy) NSString *team1ImageUrl; //球队1logo
@property (nonatomic, copy) NSString *team1Name;     //球队1名称
@property (nonatomic, copy) NSString *team2ImageUrl; //球队2logo
@property (nonatomic, copy) NSString *team2Name;     //球队2名称
@property (nonatomic, copy) NSString *score;         //比分
@property (nonatomic, copy) NSString *system;        //赛制
@property (nonatomic, copy) NSString *address;       //地点
@property (nonatomic, copy) NSString *time1;         //时间-星期
@property (nonatomic, copy) NSString *time2;         //时间-年月日

@end
