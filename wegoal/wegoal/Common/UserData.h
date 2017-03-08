//
//  UserData.h
//  SanbanNews
//
//  Created by zhengdongming on 15/6/9.
//  Copyright (c) 2015年 GuoXinHuiJin. All rights reserved.
//  存储用户登录信息类

#import <Foundation/Foundation.h>
#define UserDataManager [UserData shareManager]
@interface UserData : NSObject
@property(nonatomic,strong) NSMutableDictionary*userData;
@property (nonatomic,strong) NSString*  userToken;

//
+ (UserData*)shareManager;
// 保存用户数据
- (BOOL)saveUserData:(NSDictionary*)_userData;
// 保存某条数据
- (BOOL)saveUserValue:(id)value forKey:(NSString*)key;
//删除用户数据
- (BOOL)deleteUserData;



//{
//    "access_token" = axy8JU8U7qFQByMKi8bAA9NADFCJSTPp;
//    "auth_key" = "PLjctJC4PGs3Y_EAeFcPHHoKkmo2btUG";
//    "created_at" = 1434100688;
//    email = "<null>";
//    "avatar_img" = "<null>";
//    id = 10014;
//    mobile = 12265862271;
//    "mobile_code" = "<null>";
//    "mobile_login_code" = "<null>";
//    "mobile_login_code_time" = "<null>";
//    salt = "BYi0-X37";
//    status = 10;
//    "updated_at" = 1434100688;
//    username = "\U5c0f\U9ed1\U660e";
//}
@end
