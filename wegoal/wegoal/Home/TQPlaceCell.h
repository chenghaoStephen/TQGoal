
//
//  TQPlaceCell.h
//  wegoal
//
//  Created by joker on 2017/3/14.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^telBlock)(NSString *);
@interface TQPlaceCell : UITableViewCell

@property (nonatomic, strong) TQPlaceModel *placeData;
@property (nonatomic, copy) telBlock telBlk;

- (void)clearInfomation;

@end
