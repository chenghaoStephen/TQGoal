//
//  TQMatchFlowLayout.h
//  wegoal
//
//  Created by joker on 2016/12/20.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TQMatchFlowLayout;
@protocol TQMatchFlowLayoutDelegate <NSObject>

- (void)collectioViewScrollToIndex:(NSInteger)index;

@end

@interface TQMatchFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id<TQMatchFlowLayoutDelegate> delegate;

@end
