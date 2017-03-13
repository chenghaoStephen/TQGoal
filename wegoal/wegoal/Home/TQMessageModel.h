//
//  TQMessageModel.h
//  wegoal
//
//  Created by joker on 2017/3/13.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MessageType){
    MessageTypeDeal = 0,
    MessageTypeMatch,
    MessageTypeSystem,
};

@interface TQMessageModel : NSObject

@property (nonatomic, copy) NSString *type;           //类型
@property (nonatomic, copy) NSString *latestMessage;  //最新消息
@property (nonatomic, copy) NSString *time;           //时间

@end
