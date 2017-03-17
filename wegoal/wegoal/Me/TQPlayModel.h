//
//  TQPlayModel.h
//  wegoal
//
//  Created by joker on 2017/3/17.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PlayType)
{
    PlayTypeLaunchImage = 0,
    PlayTypeLaunchText,
    PlayTypeScheduleImage,
    PlayTypeScheduleText,
    PlayTypeGameStartImage,
    PlayTypeGameStartText,
    PlayTypeGoal,
    PlayTypeYellow,
    PlayTypeRed,
};

@interface TQPlayModel : NSObject

@property (nonatomic, copy) NSString *playId;          //id
@property (nonatomic, assign) NSInteger type;          //事件类型
@property (nonatomic, copy) NSString *time;            //时间
@property (nonatomic, copy) NSString *content;         //内容
@property (nonatomic, assign) BOOL isTeam1;            //是否是球队1

@end
