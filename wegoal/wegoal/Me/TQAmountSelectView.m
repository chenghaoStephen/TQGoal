//
//  TQAmountSelectView.m
//  wegoal
//
//  Created by joker on 2017/4/21.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQAmountSelectView.h"

#define kAmountCellBaseTag  90001
@interface TQAmountSelectView()

@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UIView *amountListView;

@end

@implementation TQAmountSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kMainBackColor;
        
        [self addSubview:self.titleLbl];
        [self addSubview:self.amountListView];
        
    }
    return self;
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 24, 26)];
        _titleLbl.backgroundColor = [UIColor clearColor];
        _titleLbl.textColor = kNavTitleColor;
        _titleLbl.font = [UIFont systemFontOfSize:10.f];
        _titleLbl.text = @"充值金额";
    }
    return _titleLbl;
}

- (UIView *)amountListView
{
    if (!_amountListView) {
        _amountListView = [[UIView alloc] init];
        _amountListView.backgroundColor = [UIColor whiteColor];
    }
    return _amountListView;
}


- (void)setAmountsArray:(NSArray *)amountsArray
{
    _amountsArray = amountsArray;
    
    if (amountsArray) {
        _amountListView.frame = CGRectMake(0, 26, SCREEN_WIDTH, kAmountInterval*(amountsArray.count + 3) + kAmountCellHeight * amountsArray.count);
        //添加子视图
        for (UIView *subView in _amountListView.subviews) {
            [subView removeFromSuperview];
        }
        CGFloat offsetY = kAmountInterval * 2;
        for (NSInteger index = 0; index < amountsArray.count; index++) {
            UIView *amountCell = [[UIView alloc] initWithFrame:CGRectMake(12, offsetY, SCREEN_WIDTH - 24, kAmountCellHeight)];
            amountCell.backgroundColor = kSubjectBackColor;
            amountCell.tag = kAmountCellBaseTag + index;
            amountCell.layer.masksToBounds = YES;
            amountCell.layer.cornerRadius = 2.f;
            amountCell.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAmout:)];
            [amountCell addGestureRecognizer:tapGesture];
            
            UILabel *signLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 25, 18, 20)];
            signLbl.backgroundColor = [UIColor clearColor];
            signLbl.textColor = [UIColor whiteColor];
            signLbl.font = [UIFont systemFontOfSize:18.f];
            signLbl.text = @"¥.";
            [amountCell addSubview:signLbl];
            UILabel *amountLbl = [[UILabel alloc] initWithFrame:CGRectMake(signLbl.right, 20, 100, 25)];
            amountLbl.backgroundColor = [UIColor clearColor];
            amountLbl.textColor = [UIColor whiteColor];
            amountLbl.font = [UIFont fontWithName:@"Arial" size:30.f];
            amountLbl.text = amountsArray[index];
            [amountCell addSubview:amountLbl];
            
            [_amountListView addSubview:amountCell];
            offsetY += kAmountCellHeight + kAmountInterval;
        }
        
    }
    
    
}


#pragma mark - events

- (void)selectAmout:(UITapGestureRecognizer *)tapGesture
{
    for (NSInteger index = 0; index < _amountsArray.count; index++) {
        UIView *view = [_amountListView viewWithTag:(kAmountCellBaseTag + index)];
        view.backgroundColor = kSubjectBackColor;
    }
    
    UIView *amountView = tapGesture.view;
    amountView.backgroundColor = kRedBackColor;
    NSInteger selectIndex = amountView.tag - kAmountCellBaseTag;
    if (selectIndex < _amountsArray.count && _amountSelectBlock) {
        _amountSelectBlock(_amountsArray[selectIndex]);
    }
    
}



@end






