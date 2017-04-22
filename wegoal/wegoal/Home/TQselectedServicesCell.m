//
//  TQselectedServicesCell.m
//  wegoal
//
//  Created by joker on 2017/4/23.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQselectedServicesCell.h"

#define kServiceItemInterval    8.f
#define kServiceItemTop         8.f
#define kServiceItemHeight      20.f
#define kServiceItemMinWidth    48.f
#define kServiceItemAddWidth    26.f
@interface TQselectedServicesCell()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation TQselectedServicesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setServicesArray:(NSArray *)servicesArray
{
    _servicesArray = servicesArray;
    
    for (UIView *subView in _scrollView.subviews) {
        [subView removeFromSuperview];
    }
    
    CGFloat offsetX = kServiceItemInterval;
    if (servicesArray) {
        for (NSString *serviceStr in servicesArray) {
            //计算宽度
            CGFloat strWidth = [serviceStr boundingRectWithSize:CGSizeMake(MAXFLOAT, kServiceItemHeight)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]}
                                                        context:nil].size.width;
            strWidth = MAX(strWidth + kServiceItemAddWidth, kServiceItemMinWidth);
            //添加Label
            UILabel *serviceLbl = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, kServiceItemTop, strWidth, kServiceItemHeight)];
            serviceLbl.backgroundColor = kSubjectBackColor;
            serviceLbl.textColor = [UIColor whiteColor];
            serviceLbl.textAlignment = NSTextAlignmentCenter;
            serviceLbl.font = [UIFont systemFontOfSize:12.f];
            serviceLbl.text = serviceStr;
            serviceLbl.layer.masksToBounds = YES;
            serviceLbl.layer.cornerRadius = 10.f;
            [_scrollView addSubview:serviceLbl];
            
            offsetX += strWidth + kServiceItemInterval;
        }
        _scrollView.contentSize = CGSizeMake(offsetX, 36);
    }
}


@end
