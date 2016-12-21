//
//  JOMatchMenuView.m
//  JOExample3
//
//  Created by joker on 2016/12/14.
//  Copyright © 2016年 joker. All rights reserved.
//

#import "JOMatchMenuView.h"
#import "JOShowMenuView.h"
#import "JOSelectMenuView.h"

#define kWeekMenuViewTag        2001
#define kSystemMenuViewTag      2002
#define kTypeMenuViewTag        2003

@interface JOMatchMenuView()<JOSelectMenuViewDelegate>
{
    NSArray *weekMenus;                        //星期选项
    NSArray *systemMenus;                      //赛制选项
    NSArray *typeMenus;                        //类型选项
    
    NSMutableArray *weekSelects;               //选择星期
    NSMutableArray *systemSelects;             //选择赛制
    NSMutableArray *typeSelects;               //选择类型
    
    NSMutableDictionary *keyValues;            //关键字:显示字符串
}

//子视图
@property (nonatomic, strong) JOShowMenuView *topView;
@property (nonatomic, strong) UIButton *packupButton;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) JOSelectMenuView *weekView;
@property (nonatomic, strong) JOSelectMenuView *systemView;
@property (nonatomic, strong) JOSelectMenuView *typeView;

@end

@implementation JOMatchMenuView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        weekMenus = @[@{@"key":@"mon",@"string":@"星期一"},
                      @{@"key":@"tus",@"string":@"星期二"},
                      @{@"key":@"wed",@"string":@"星期三"},
                      @{@"key":@"thu",@"string":@"星期四"},
                      @{@"key":@"fri",@"string":@"星期五"},
                      @{@"key":@"sat",@"string":@"星期六"},
                      @{@"key":@"sun",@"string":@"星期日"}
                      ];
        
        systemMenus = @[@{@"key":@"three",@"string":@"三人制"},
                        @{@"key":@"five",@"string":@"五人制"},
                        @{@"key":@"seven",@"string":@"七人制"},
                        @{@"key":@"eleven",@"string":@"十一人"}
                        ];
        
        typeMenus = @[@{@"key":@"friendly",@"string":@"友谊赛"},
                      @{@"key":@"certify",@"string":@"认证赛"}
                      ];
        
        weekSelects = [NSMutableArray array];
        systemSelects = [NSMutableArray array];
        typeSelects = [NSMutableArray array];
        
        keyValues = [NSMutableDictionary dictionary];
        for (NSDictionary *dic in weekMenus) {
            [keyValues setValue:dic[@"string"] forKey:dic[@"key"]];
        }
        for (NSDictionary *dic in systemMenus) {
            [keyValues setValue:dic[@"string"] forKey:dic[@"key"]];
        }
        for (NSDictionary *dic in typeMenus) {
            [keyValues setValue:dic[@"string"] forKey:dic[@"key"]];
        }
        
        //添加子视图
        [self addSubview:self.topView];
        [self addSubview:self.packupButton];
        [self addSubview:self.clearButton];
        [self addSubview:self.weekView];
        [self addSubview:self.systemView];
        [self addSubview:self.typeView];
    }
    return self;
}

- (JOShowMenuView *)topView
{
    if (!_topView) {
        _topView = [[JOShowMenuView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 30)];
        _topView.backgroundColor = [UIColor lightGrayColor];
        _topView.layer.masksToBounds = YES;
        _topView.layer.cornerRadius = 15;
        //默认显示
        [_topView setTitle:@"所有星期•所有赛制•所有类型"];
        //点击展开
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dropMenuList)];
        [_topView addGestureRecognizer:tapGestureRecognizer];
        
    }
    return _topView;
}

- (UIButton *)packupButton
{
    if (!_packupButton) {
        _packupButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_packupButton setFrame:CGRectMake(10, 10, 30, 30)];
        [_packupButton setTintColor:[UIColor whiteColor]];
        [_packupButton setTitle:@"收起" forState:UIControlStateNormal];
        _packupButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
        [_packupButton addTarget:self action:@selector(packupAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _packupButton;
}

- (UIButton *)clearButton
{
    if (!_clearButton) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearButton setFrame:CGRectMake(SCREEN_WIDTH - 70, 10, 60, 30)];
        [_clearButton setTintColor:[UIColor whiteColor]];
        [_clearButton setTitle:@"全部清空" forState:UIControlStateNormal];
        _clearButton.titleLabel.font = [UIFont systemFontOfSize:10.f];
        [_clearButton addTarget:self action:@selector(clearMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}

- (JOSelectMenuView *)weekView
{
    if (!_weekView) {
        _weekView = [[JOSelectMenuView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_topView.frame) + 10, SCREEN_WIDTH - 20, 30)];
        _weekView.backgroundColor = [UIColor lightGrayColor];
        _weekView.layer.masksToBounds = YES;
        _weekView.layer.cornerRadius = 15;
        _weekView.menuList = weekMenus;
        _weekView.tag = kWeekMenuViewTag;
        _weekView.delegate = self;
    }
    return _weekView;
}

- (JOSelectMenuView *)systemView
{
    if (!_systemView) {
        _systemView = [[JOSelectMenuView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_weekView.frame) + 10, SCREEN_WIDTH - 20, 30)];
        _systemView.backgroundColor = [UIColor lightGrayColor];
        _systemView.layer.masksToBounds = YES;
        _systemView.layer.cornerRadius = 15;
        _systemView.menuList = systemMenus;
        _systemView.tag = kSystemMenuViewTag;
        _systemView.delegate = self;
    }
    return _systemView;
}

- (JOSelectMenuView *)typeView
{
    if (!_typeView) {
        _typeView = [[JOSelectMenuView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_systemView.frame) + 10, SCREEN_WIDTH - 20, 30)];
        _typeView.backgroundColor = [UIColor lightGrayColor];
        _typeView.layer.masksToBounds = YES;
        _typeView.layer.cornerRadius = 15;
        _typeView.menuList = typeMenus;
        _typeView.tag = kTypeMenuViewTag;
        _typeView.delegate = self;
    }
    return _typeView;
}


-(void)setIsDrop:(BOOL)isDrop
{
    _isDrop = isDrop;
    if (isDrop) {
        //菜单展开
        _topView.hidden = YES;
        _packupButton.hidden = NO;
        _clearButton.hidden = NO;
        _weekView.hidden = NO;
        _systemView.hidden = NO;
        _typeView.hidden = NO;
    } else {
        //菜单收起
        _topView.hidden = NO;
        _packupButton.hidden = YES;
        _clearButton.hidden = YES;
        _weekView.hidden = YES;
        _systemView.hidden = YES;
        _typeView.hidden = YES;
    }
}


#pragma mark - 数据刷新

- (void)refreshMatchData
{
    //更新标头显示
    //星期
    NSString *weekStr = @"";
    for (NSString *weekKey in weekSelects) {
        weekStr = [weekStr stringByAppendingString:keyValues[weekKey]];
        if ([weekSelects indexOfObject:weekKey] < (weekSelects.count - 1)) {
            weekStr = [weekStr stringByAppendingString:@" "];
        }
    }
    weekStr = (weekStr.length > 0)?weekStr:@"所有星期";
    //赛制
    NSString *systemStr = @"";
    for (NSString *systemKey in systemSelects) {
        systemStr = [systemStr stringByAppendingString:keyValues[systemKey]];
        if ([systemSelects indexOfObject:systemKey] < (systemSelects.count - 1)) {
            systemStr = [systemStr stringByAppendingString:@" "];
        }
    }
    systemStr = (systemStr.length > 0)?systemStr:@"所有赛制";
    //类型
    NSString *typeStr = @"";
    for (NSString *typeKey in typeSelects) {
        typeStr = [typeStr stringByAppendingString:keyValues[typeKey]];
        if ([typeSelects indexOfObject:typeKey] < (typeSelects.count - 1)) {
            typeStr = [typeStr stringByAppendingString:@" "];
        }
    }
    typeStr = (typeStr.length > 0)?typeStr:@"所有类型";
    NSString *title = [NSString stringWithFormat:@"%@•%@•%@", weekStr, systemStr, typeStr];
    [_topView setTitle:title];
    
    //数据刷新
    if (_delegate && [_delegate respondsToSelector:@selector(JOMatchMenuView:getDataWithWeeks:systems:types:)]) {
        [_delegate JOMatchMenuView:self getDataWithWeeks:weekSelects systems:systemSelects types:typeSelects];
    }
}


#pragma mark - JOSelectMenuViewDelegate

- (void)JOSelectMenuView:(JOSelectMenuView *)selectMenuView setOptions:(NSArray *)options
{
    switch (selectMenuView.tag) {
        case kWeekMenuViewTag:
            [weekSelects removeAllObjects];
            [weekSelects addObjectsFromArray:options];
            break;
            
        case kSystemMenuViewTag:
            [systemSelects removeAllObjects];
            [systemSelects addObjectsFromArray:options];
            break;
            
        case kTypeMenuViewTag:
            [typeSelects removeAllObjects];
            [typeSelects addObjectsFromArray:options];
            break;
            
        default:
            break;
    }
    [self refreshMatchData];
}


#pragma mark - actions

- (void)dropMenuList
{
    self.isDrop = YES;
}

- (void)packupAction
{
    self.isDrop = NO;
}

- (void)clearMenu
{
    //界面
    [_weekView clearMenu];
    [_systemView clearMenu];
    [_typeView clearMenu];
    //数据
    [weekSelects removeAllObjects];
    [systemSelects removeAllObjects];
    [typeSelects removeAllObjects];
    //数据刷新
    [self refreshMatchData];
}


@end
