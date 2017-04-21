//
//  TQPayTypeSelectView.h
//  wegoal
//
//  Created by joker on 2017/4/21.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PayType){
    PayTypeWechat = 0,
    PayTypeAlipay,
};

@interface TQPayTypeSelectView : UIView

@property (nonatomic, copy) void(^payTypeBlock)(PayType type);

@end
