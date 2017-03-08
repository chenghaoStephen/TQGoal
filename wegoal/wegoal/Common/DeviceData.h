//
//  DeviceData.h
//  SanbanNews
//
//  Created by zhengdongming on 15/6/15.
//  Copyright (c) 2015年 GuoXinHuiJin. All rights reserved.
//  设备相关数据

#import <Foundation/Foundation.h>
#define DeviceDataManager [DeviceData shareManager]

typedef enum {
    FONT_SMALL = 1,     //小字体
    FONT_NORMAL,        //普通字体
    FONT_LARGE,         //大字体
    FONT_LARGEX,        //超大字体
} NEWS_FONT_SIZE;

@interface DeviceData : NSObject
/*! 设备名 iphone6 */
@property(nonatomic,strong)NSString*deviceName;
/*! 设备系统 phoneOS 8.3*/
@property(nonatomic,strong)NSString*deviceVersion;
/*! 设备唯一标志*/
@property(nonatomic,strong)NSString*uuid;
/*! 程序名称*/
@property(nonatomic,strong)NSString*appName;
/*! 程序版本号*/
@property(nonatomic,strong)NSString*appVersion;
/*!deviceToken*/
@property (nonatomic,strong)NSString*deviceToken;
/*! 正文字体*/
@property(nonatomic,assign)NEWS_FONT_SIZE newsFont;
/*! 正文字体字号大小*/
@property(nonatomic,strong)NSString* newsFontValue;
/*! 刷新频率*/
@property(nonatomic,assign)NSInteger reFrequency;
/*! 最新程序版本号*/
@property(nonatomic,strong)NSString*oldAppVersion;
/*! 升级后第一次打开*/
@property(nonatomic,assign)BOOL fristOpen;
/*! 新闻推送状态*/
@property(nonatomic,assign)BOOL newsPush;
/*! 推送声音状态*/
@property(nonatomic,assign)BOOL pushSound;

+ (DeviceData*)shareManager;

@end
