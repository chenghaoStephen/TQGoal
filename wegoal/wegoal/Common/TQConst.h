//
//  TQConst.h
//  wegoal
//
//  Created by joker on 2016/12/20.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import <Foundation/Foundation.h>

//约战状态
//typedef NS_ENUM(NSInteger, MatchStatus){
//    MatchStatusNewJoiner = 0,     //新球员，可创建、加入球队
//    MatchStatusTeaming,           //组队中
//    MatchStatusStartUp,           //组队完成，可以发起约战
//    MatchStatusStarted,           //发起约战，等待响应
//    MatchStatusResponse,          //响应约战，等待发起方确认
//    MatchStatusConfirm,           //有人响应，等待确认
//    MatchStatusPay,               //确认约战，待支付
//    MatchStatusWaiting,           //支付完成，等待开始
//    MatchStatusProcessing,        //进行中
//    MatchStatusEvaluateSelf,      //评价己方
//    MatchStatusEvaluateOther,     //评价对手
//    MatchStatusShare,             //分享
//};

typedef NS_ENUM(NSInteger, MatchStatus){
    MatchStatusSearching = 0,     //寻找对手
    MatchStatusConfirm,           //确认对手
    MatchStatusPay,               //付费
    MatchStatusWaiting,           //等待比赛
    MatchStatusProcessing,        //比赛中
    MatchStatusEnd,               //结束
};

#define kRaceSystemArray   @[@"5人制",@"7/8/9人制",@"11人制"]


//颜色
#define kMainBackColor       RGB16(0xf0f6f2)
#define kTitleTextColor      RGB16(0x96abb5)
#define kSubTextColor        RGB16(0xdfe8ec)
#define kSubjectBackColor    RGB16(0x57d67e)
#define kScheduleBackColor   RGB16(0x0b1523)
#define kNavTitleColor       RGB16(0x34454C)
#define kBackLineColor       RGB16(0xDFDFDF)
#define kRedBackColor        RGB16(0xF9585E)
#define kUnenableColor       RGB16(0xDFE8EC)
#define kSystemBlueColor     RGB16(0x30B3F7)


//Notification Identifier
#define kTabbarNeedShowNoti  @"TabbarNeedShow"
#define kTabbarNeedHideNoti  @"TabbarNeedHide"
#define kTabbarClickButton   @"TabbarClickButton"


//Native
#define kGuideViewShow       @"GuideViewShow"


//date formatter
#define kDateFormatter1      @"yyyy-MM-dd HH:mm:ss"
#define kDateFormatter2      @"MM/dd - HH:mm"
#define kDateFormatter3      @"yyyyMMddHHmm"


#define HTTP_TIME_OUT 10
