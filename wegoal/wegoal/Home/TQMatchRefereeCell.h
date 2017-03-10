//
//  TQMatchRefereeCell.h
//  wegoal
//
//  Created by joker on 2017/3/9.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^packupBlock)(BOOL isPackup);
@interface TQMatchRefereeCell : UITableViewCell

@property (nonatomic, copy) packupBlock block;
@property (nonatomic, assign) BOOL isPackup;

@end
