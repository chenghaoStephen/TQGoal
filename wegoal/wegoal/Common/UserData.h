//
//  UserData.h
//  WeGoal
//
//  Created by joker on 15/6/9.
//  Copyright (c) 2015年 WeGoal. All rights reserved.
//  存储用户登录信息类

#import <Foundation/Foundation.h>
#import "TQMemberModel.h"

#define UserDataManager [UserData shareManager]

@interface UserData : NSObject

+ (UserData*)shareManager;

// 数据读取与保存
- (void)setUserData:(NSDictionary *)userData;
- (TQMemberModel *)getUserData;

// 清空用户数据
- (void)clearUserData;

@end
