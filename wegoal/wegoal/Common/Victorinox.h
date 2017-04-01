//
//  Victorinox.h
//  TalkShow
//
//  Created by dxd on 14-8-25.
//  Copyright (c) 2014年 dxd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Victorinox : NSObject

//调试time
+ (void)printDebugTime:(NSString *)tagString;
//用户目录 Document/{user_dir}
+ (NSString*)dirnameWithUserHome;
// 用户cache目录
+ (NSString*)dirnameWithUserCache;
// 用户录音路径
+ (NSString*)dirnameWithUserVoice;
// 判断包含字符串
+ (BOOL) isContainWithString : (NSString*)sentence word:(NSString*)word;
//截取字符串
+ (NSString*)substringToString:(NSString*)word string:(NSString*)string;
// 拼接url
+ (NSString*)urlWithBaseurlAndParamter: (NSString*)url parameters:(NSDictionary*)parameters;
//判断空串
+(BOOL)isBlankString:(NSString *)string;
//字符串不为空 若为空则显示 “--”
+(NSString*)stringWithNotNull:(NSString*)string;
//转换单位_万
+(NSString*)conversionUnitTenThousand:(float)value;
//转换单位_千
+(NSString*)conversionUnitThousand:(float)value;
//转换单位_百
+(NSString*)conversionUnitHundred:(float)value;
//颜色转图片
+(UIImage*) createImageWithColor:(UIColor*) color;
//判断是否有录音文件
+ (BOOL)haveVoiceMessage:(NSString*)messageId;
//时间戳
+(NSTimeInterval)timeStamp;
//取股票code 430148.oc=>430148
+(NSString*)stockSymbolWithCode:(NSString*)code;
//版本比较  3位以下 1.2.3>1.2
+ (BOOL)hadNeweVersion:(NSString*)oldVersion newVersion:(NSString*)newVersion;
//控件宽度
+ (CGFloat)widthWithController:(id)sender;

@end
