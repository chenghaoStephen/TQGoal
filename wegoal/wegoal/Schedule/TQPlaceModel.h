//
//  TQPlaceModel.h
//  wegoal
//
//  Created by joker on 2017/3/10.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQPlaceModel : NSObject

/*
"gamePlaceId": "3",
"placePic": "/upload/201703/01/201703012217144591.jpg",
"name": "大连体育场",
"gps": "180,199",
"place": "中山区",
"brief": "场地大，没草坪，水泥地",
"price": "200",
"gamePlaceVS": null
 */

@property (nonatomic, copy) NSString *gamePlaceId;     //id
@property (nonatomic, copy) NSString *placePic;        //场地图片
@property (nonatomic, copy) NSString *name;            //场地名称
@property (nonatomic, copy) NSString *phone;           //电话
@property (nonatomic, copy) NSString *gps;             //位置
@property (nonatomic, copy) NSString *place;           //地点
@property (nonatomic, copy) NSString *brief;           //特点
@property (nonatomic, copy) NSString *price;           //价格
@property (nonatomic, copy) NSArray *gamePlaceVS;      //VS

@end
