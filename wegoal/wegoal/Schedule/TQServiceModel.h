//
//  TQServiceModel.h
//  wegoal
//
//  Created by joker on 2017/3/10.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQServiceModel : NSObject

/*
"serviceId": "7",
"serviceTypeName": "红色能量包",
"serviceType": "2",
"imgUrl": "/upload/201703/04/201703041725289681.jpg",
"bodyContent": "<p>\r\n\t按摩服务，啦啦队\r\n</p>",
"orderCount": null,
"price": "200"

*/

@property (nonatomic, copy) NSString *serviceId;         //id
@property (nonatomic, copy) NSString *serviceTypeName;   //服务类型名称
@property (nonatomic, copy) NSString *serviceType;       //服务类型
@property (nonatomic, copy) NSString *imgUrl;            //图片url
@property (nonatomic, copy) NSString *bodyContent;       //服务内容
@property (nonatomic, copy) NSString *orderCount;        //件数
@property (nonatomic, copy) NSString *price;             //价格

@end
