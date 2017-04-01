//
//  GXShareView.h
//  WeGoal
//
//  Created by joker on 15/5/28.
//  Copyright (c) 2015年 WeGoal. All rights reserved.
//

#import <Foundation/Foundation.h>
// 点击按钮回调
typedef void (^didSelectBlock)(NSInteger selectIndex);

@interface HeadImgChangeView : UIView
+ (void)showShareViewWithImageArray:(NSArray*)imageArray  withNameArray:(NSArray*)nameArray withCompletion:(didSelectBlock)completion;
+ (void)showShareViewInView:(UIView*)baseView withImageArray:(NSArray*)imageArray  withNameArray:(NSArray*)nameArray withCompletion:(didSelectBlock)completion;
@end
