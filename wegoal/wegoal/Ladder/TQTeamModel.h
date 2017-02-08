//
//  TQTeamModel.h
//  wegoal
//
//  Created by joker on 2017/2/8.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TQTeamModel : NSObject

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, assign) NSInteger matchNumber;
@property (nonatomic, assign) NSInteger win;
@property (nonatomic, assign) NSInteger lose;
@property (nonatomic, assign) NSInteger tie;

@end
