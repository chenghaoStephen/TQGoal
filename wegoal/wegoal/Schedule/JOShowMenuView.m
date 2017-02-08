//
//  JOShowMenuView.m
//  JOExample3
//
//  Created by joker on 2016/12/14.
//  Copyright © 2016年 joker. All rights reserved.
//

#import "JOShowMenuView.h"

@interface JOShowMenuView()

@property (nonatomic, strong) UIImageView *searchImageView;
@property (nonatomic, strong) UILabel *stringlabel;

@end

@implementation JOShowMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.searchImageView];
        [self addSubview:self.stringlabel];
    }
    return self;
}

- (UIImageView *)searchImageView
{
    if (!_searchImageView) {
        _searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20, 20)];
        _searchImageView.image = [UIImage imageNamed:@"search"];
    }
    return _searchImageView;
}

- (UILabel *)stringlabel
{
    if (!_stringlabel) {
        _stringlabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, SCREEN_WIDTH - 70, 30)];
        _stringlabel.textColor = [UIColor whiteColor];
        _stringlabel.font = [UIFont systemFontOfSize:12.f];
    }
    return _stringlabel;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _stringlabel.text = title;
}

@end
