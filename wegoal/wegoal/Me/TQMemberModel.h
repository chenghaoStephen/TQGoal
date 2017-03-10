//
//  TQMemberModel.h
//  wegoal
//
//  Created by joker on 2017/3/10.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQMemberModel : NSObject
/*
 "memberId": "8",
 "userName": "13000000008",
 "headPic": "/upload/201702/28/201702282046277295.jpg",
 "memberName": "测试队员A8",
 "memberNumber": "1",
 "memberPosition": "前锋",
 "memberHeight": "178",
 "memberWeight": "77",
 "memberAge": "33",
 "mvp": null,
 "score": null
 */

@property (nonatomic, copy) NSString *memberId;           //id
@property (nonatomic, copy) NSString *userName;           //用户名
@property (nonatomic, copy) NSString *headPic;            //头像
@property (nonatomic, copy) NSString *memberName;         //姓名
@property (nonatomic, copy) NSString *memberNumber;       //号码
@property (nonatomic, copy) NSString *memberPosition;     //位置
@property (nonatomic, copy) NSString *memberHeight;       //身高
@property (nonatomic, copy) NSString *memberWeight;       //体重
@property (nonatomic, copy) NSString *memberAge;          //年龄
@property (nonatomic, copy) NSString *mvp;                //mvp数
@property (nonatomic, copy) NSString *score;              //进球数

@end
