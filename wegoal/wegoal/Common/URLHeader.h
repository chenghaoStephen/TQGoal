//
//  URLHeader.h
//  wegoal
//
//  Created by joker on 2016/12/20.
//  Copyright © 2016年 xdkj. All rights reserved.
//


#define URL(domian,url) [domian stringByAppendingString:url?:@""]

//Domain
#define kTQDomainURL     @"http://165n01a586.iask.in"


//登录
#define kAccountLogin    @"/api/Account/Login"
//注册
#define kAccountRegister @"/api/Account/Register"

//主页数据
#define kHomeData        @"/api/AppGetView/GetEnrollList"
//约战详情
#define kEnrollDetail    @"/api/AppGetView/GetMyEnrollDetails"
//约战协议
#define kEnrollAgreement @"/api/AppGetView/GetEnrollAgreement"
//发起约战
#define kEnrollLaunched  @"/api/AppGetView/GetEnrollLaunched"
//邀请队友
#define kInviteTeammates @"/api/AppGetView/GetInviteTeammates"
//约战场地
#define kGamePlace       @"/api/AppGetView/GetGamePlace"

//确认约战
#define kSetEnroll       @"/api/AppPostData/SetEnrollDetails"
//用户信息完善
#define kSetMember       @"/api/AppPostData/SetMember"
