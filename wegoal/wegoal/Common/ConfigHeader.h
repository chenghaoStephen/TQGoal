//
//  ConfigHeader.h
//  wegoal
//
//  Created by joker on 2016/12/20.
//  Copyright © 2016年 xdkj. All rights reserved.
//

// 版本
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
#define OS_VERSION [[UIDevice currentDevice]systemVersion]  //字符串 无符号数
#define OS_VERSION_VALUE    [OS_VERSION floatValue]
#define OS_G10 OS_VERSION_VALUE>=10.0
#define OS_G9 OS_VERSION_VALUE>=9.0
#define OS_G8 OS_VERSION_VALUE>=8.0
#define OS_G7 OS_VERSION_VALUE>=7.0
#define OS_G6 OS_VERSION_VALUE>=6.0
#define OS_G5 OS_VERSION_VALUE>=5.0
#define OS_L7 OS_VERSION_VALUE<7.0

// 页面
#define SCREEN_HEIGHT (([[UIScreen mainScreen] applicationFrame].size.height>[[UIScreen mainScreen] applicationFrame].size.width)?[[UIScreen mainScreen] applicationFrame].size.height:[[UIScreen mainScreen] applicationFrame].size.width)
#define SCREEN_WIDTH (([[UIScreen mainScreen] applicationFrame].size.height<[[UIScreen mainScreen] applicationFrame].size.width)?[[UIScreen mainScreen] applicationFrame].size.height:[[UIScreen mainScreen] applicationFrame].size.width)
#define VIEW_HEIGHT (SCREEN_HEIGHT-44)
#define VIEW_WITHOUT_TABBAR_HEIGHT (SCREEN_HEIGHT-50-44)
#define SCALE375 (SCREEN_WIDTH/375)

// 颜色
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define RGB16(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define RGBA16(rgbValue,a) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:a]

//文件
#define DOCUMENT_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define TMP_PATH NSTemporaryDirectory()
#define VOICE_PATH [Victorinox dirnameWithUserVoice]
#define USER_PATH [Victorinox dirnameWithUserHome]
#define USER_CACHE_PATH [Victorinox dirnameWithUserCache]

//用户数据
#define USER_TOKEN UserDataManager.userToken
#define USER_NAME  UserDataManager.userName

//第三方AppId、AppSecret
//share-sdk
#define kShareSdkAppId     @"1c46efcdaa680"
#define kShareSdkAppSecret @"3cadef6408a7583b989a4598e4fef2ec"
//wechat
#define kWechatAppId       @""
#define kWechatAppSecret   @""
//qq
#define kQQAppId           @""
#define kQQAppKey          @""






