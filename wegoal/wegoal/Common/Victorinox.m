//
//  Victorinox.m
//  TalkShow
//
//  Created by dxd on 14-8-25.
//  Copyright (c) 2014年 dxd. All rights reserved.
//

#import "Victorinox.h"

@implementation Victorinox

//调试time
+ (void)printDebugTime:(NSString *)tagString {
    NSString* date;
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"hh:mm:ss:SSS"];
    date = [formatter stringFromDate:[NSDate date]];
    NSString * timeNow = [[NSString alloc] initWithFormat:@"%@_%@",tagString, date];
}

//用户目录 Document/{user_dir}
+ (NSString*)dirnameWithUserHome {
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSString * filename = [DOCUMENT_PATH stringByAppendingPathComponent:@"Default"];
    if (![filemanager fileExistsAtPath:filename]) {
        [filemanager createDirectoryAtPath:filename withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return filename;
}
// 用户cache目录
+ (NSString*)dirnameWithUserCache {
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSString * filename = [DOCUMENT_PATH stringByAppendingPathComponent:@"Cache"];
    if (![filemanager fileExistsAtPath:filename]) {
        [filemanager createDirectoryAtPath:filename withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return filename;
}
// 用户录音路径
+ (NSString*)dirnameWithUserVoice {
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSString * filename = [TMP_PATH stringByAppendingPathComponent:@"Voice"];
    if (![filemanager fileExistsAtPath:filename]) {
        [filemanager createDirectoryAtPath:filename withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return filename;
}
// 判断包含字符串
+ (BOOL) isContainWithString : (NSString*)sentence word:(NSString*)word{
    NSRange range = [sentence rangeOfString:word];
    return !(range.location==NSNotFound);
}

//截取字符串
+ (NSString*)substringToString:(NSString*)word string:(NSString*)string {
    NSRange range = [word rangeOfString:string];//匹配得到的下标
    return [word substringWithRange:NSMakeRange(0, range.location)];//截取范围类的字符串
}

// 拼接url
+ (NSString*)urlWithBaseurlAndParamter: (NSString*)url parameters:(NSDictionary*)parameters {
    NSString * returnUrl = @"";
    
    //得到词典中所有KEY值
    NSEnumerator * enumeratorKey = [parameters keyEnumerator];
    for (id key in enumeratorKey) {
        returnUrl = [NSString stringWithFormat:@"%@&%@=%@",returnUrl,key,(NSString*)[parameters objectForKey:key]];
    }
    if ([self isContainWithString:url word:@"?"]) {
        returnUrl = [NSString stringWithFormat:@"%@%@",url,returnUrl];
    } else {
        if (returnUrl.length>0) {
            returnUrl = [NSString stringWithFormat:@"%@?%@",url,[returnUrl substringFromIndex:1]];
        } else {
            returnUrl = [NSString stringWithFormat:@"%@",url];
        }
        
    }
    return returnUrl;
}

//判断空串
+(BOOL)isBlankString:(NSString *)string{
    if (string == nil || string == NULL || [string isKindOfClass:[NSNull class]] ) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
+(NSString*)stringWithNotNull:(NSString*)string{
    if ([self isBlankString:string]) {
        return @"--";
    }else{
        return string;
    }
}
//转换单位_万
+(NSString*)conversionUnitTenThousand:(float)value {
    NSString * stringValue;
    if (fabsf(value)>=100000000) {
        stringValue = [NSString stringWithFormat:@"%.2f亿",value/100000000];
    } else if (fabsf(value)>=10000) {
        stringValue = [NSString stringWithFormat:@"%.0f万",value/10000];
    } else {
        stringValue = [NSString stringWithFormat:@"%.0f",value];
    }
    return stringValue;
}

//转换单位_千
+(NSString*)conversionUnitThousand:(float)value{
    NSString * stringValue;
    if (fabsf(value)>=100000000) {
        stringValue = [NSString stringWithFormat:@"%.2f亿",value/100000000];
    } else if (fabsf(value)>=10000) {
        stringValue = [NSString stringWithFormat:@"%.1f万",value/10000];
    } else {
        stringValue = [NSString stringWithFormat:@"%.0f",value];
    }
    return stringValue;
}

//转换单位_百
+(NSString*)conversionUnitHundred:(float)value{
    NSString * stringValue;
    if (fabsf(value)>=100000000) {
        stringValue = [NSString stringWithFormat:@"%.2f亿",value/100000000];
    } else if (fabsf(value)>=10000) {
        stringValue = [NSString stringWithFormat:@"%.2f万",value/10000];
    } else {
        stringValue = [NSString stringWithFormat:@"%.0f",value];
    }
    return stringValue;
}

//颜色转图片
+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (BOOL)haveVoiceMessage:(NSString*)messageName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
//    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:VOICE_PATH error:&error];
    if ([fileList containsObject:messageName]) {
        return YES;
    }
    return NO;
}

//时间戳
+(NSTimeInterval)timeStamp{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval intTimeStamp=[date timeIntervalSince1970];
    return intTimeStamp;
}

//取股票code 430148.oc=>430148
+(NSString*)stockSymbolWithCode:(NSString*)code {
    return [code substringToIndex:6];
}

//版本比较  3位以下 1.2.3>1.2
+ (BOOL)hadNeweVersion:(NSString*)oldVersion newVersion:(NSString*)newVersion {
    NSArray *oldVersionArray =  [oldVersion componentsSeparatedByString:@"."];
    NSArray *newVersionArray =  [newVersion componentsSeparatedByString:@"."];
    BOOL update = NO;
    //有第一位
    if ([newVersionArray count] > 0 && [oldVersionArray count] > 0) {
        //第一位大于
        if ([newVersionArray[0] intValue] > [oldVersionArray[0] intValue]) {
            update = YES;
        //第一位等于，比较第二位
        }else if([newVersionArray[0] intValue] == [oldVersionArray[0] intValue]){
            //有第二位
            if ([newVersionArray count] > 1 && [oldVersionArray count] > 1) {
                //第二位大于
                if ([newVersionArray[1] intValue] > [oldVersionArray[1] intValue]) {
                    update = YES;
                //第二位等于，比较第三位
                }else if ([newVersionArray[1] intValue] == [oldVersionArray[1] intValue]){
                    //有第三位
                    if ([newVersionArray count] > 2 && [oldVersionArray count] > 2) {
                        //第三位大于
                        if ([newVersionArray[2] intValue] > [oldVersionArray[2] intValue]) {
                            update = YES;
                        }
                    }
                }
            }
        }
    }
    return update;
}

//控件宽度
+ (CGFloat)widthWithController:(id)sender{
    CGFloat ctlWidth = 0;
    if ([sender isKindOfClass:[UIButton class]]) {
        NSString * string = [(UIButton*)sender titleLabel].text;
        UIFont * font = [(UIButton*)sender titleLabel].font;
        CGFloat height = [(UIButton*)sender titleLabel].height;
        
        CGSize sizeToFit = [string sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:0];
        ctlWidth = sizeToFit.width;
        
    } else if ([sender isKindOfClass:[UILabel class]]) {
        NSString * string = [(UILabel*)sender text];
        UIFont * font = [(UILabel*)sender font];
        CGFloat height = [(UILabel*)sender height];
        CGSize sizeToFit = [string sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:0];
        ctlWidth = sizeToFit.width;
    }
    
    return ctlWidth;
}

@end
