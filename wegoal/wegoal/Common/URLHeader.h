//
//  URLHeader.h
//  wegoal
//
//  Created by joker on 2016/12/20.
//  Copyright © 2016年 xdkj. All rights reserved.
//


#define URL(domian,url) [domian stringByAppendingString:url?:@""]

//Domain
#define kTQDomainURL     @"http://175.170.128.237:9004/"


//登录
#define kAccountLogin    @"/api/Account/Login"
//注册
#define kAccountRegister @"/api/Account/Register"
//发送手机验证码
#define kAccountSendCode @"/api/Account/sendCode"
//验证手机验证码
#define kAccountVerifyCode @"/api/Account/verifyCode"


//主页数据
#define kHomeData        @"/api/AppGetView/GetEnrollList"
//约战详情
#define kEnrollDetail    @"/api/AppGetView/GetMyEnrollDetails"
//约战协议
#define kEnrollAgreement @"/api/AppGetView/GetEnrollAgreement"
//发起约战
#define kEnrollLaunched  @"/api/AppGetView/GetEnrollLaunched"
//可邀请队友列表
#define kInviteTeammates @"/api/AppGetView/GetInviteTeammates"
//邀请队友
#define kInviteAction    @"/api/AppPostData/PostInviteTeammates"
//约战场地
#define kGamePlace       @"/api/AppGetView/GetGamePlace"
//确认约战
#define kSetEnroll       @"/api/AppPostData/SetEnrollDetails"
//单独约裁判、服务 支付
#define kPayServiceOnly  @"/api/AppPostData/PayServiceOnly"

//约战检索
#define kEnrollWaitList  @"/api/AppGetView/GetEnrollWaitList"


//用户信息完善
#define kSetMember       @"/api/AppPostData/SetMember"
//上传头像
#define kSetMemberPic    @"/api/ImageUpload/PostFile"
//创建球队
#define kUserCreatTeam   @"/api/AppPostData/CreatTeam"
//取得球队列表
#define kGetTeamList     @"/api/AppGetView/GetTeamList"
//加入球队
#define kUserJoinTeam    @"/api/AppPostData/JoinTeam"
//报名
#define kUserSignUp      @"/api/AppPostData/JoinGame"


//取得比赛直播数据
#define kGetLiveDetail   @"/api/AppGetView/GetGameBroadCast"


