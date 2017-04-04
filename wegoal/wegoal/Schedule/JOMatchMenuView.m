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
#define kStatusMenuViewTag      2004

@interface JOMatchMenuView()<JOSelectMenuViewDelegate>
{
    NSArray *weekMenus;                        //星期选项
    NSArray *systemMenus;                      //赛制选项
    NSArray *typeMenus;                        //类型选项
    NSMutableArray *weekSelects;               //选择星期
    NSMutableArray *systemSelects;             //选择赛制
    NSMutableArray *typeSelects;               //选择类型
    
    NSArray *statusMenus;                      //状态选项
    NSMutableArray *statusSelects;             //选择状态
    
    NSMutableDictionary *keyValues;            //关键字:显示字符串
}

//子视图
@property (nonatomic, strong) JOShowMenuView *topView;
@property (nonatomic, strong) UIButton *packupButton;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) JOSelectMenuView *weekView;
@property (nonatomic, strong) JOSelectMenuView *systemView;
@property (nonatomic, strong) JOSelectMenuView *typeView;
@property (nonatomic, strong) JOSelectMenuView *statusView;

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
        
        systemMenus = @[@{@"key":@"five",@"string":@"5人制"},
                        @{@"key":@"seven",@"string":@"7/8/9人制"},
                        @{@"key":@"eleven",@"string":@"11人制"}
                        ];
        
        typeMenus = @[@{@"key":@"friendly",@"string":@"友谊赛"},
                      @{@"key":@"certify",@"string":@"认证赛"}
                      ];
        
        statusMenus = @[@{@"key":@"uncomplete",@"string":@"未完成"},
                        @{@"key":@"complete",@"string":@"已完成"}
                        ];
        
        weekSelects = [NSMutableArray array];
        systemSelects = [NSMutableArray array];
        typeSelects = [NSMutableArray array];
        statusSelects = [NSMutableArray array];
        
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
        for (NSDictionary *dic in statusMenus) {
            [keyValues setValue:dic[@"string"] forKey:dic[@"key"]];
        }
        
        //添加子视图
        [self addSubview:self.topView];
        [self addSubview:self.packupButton];
        [self addSubview:self.clearButton];
        [self addSubview:self.weekView];
        [self addSubview:self.systemView];
        [self addSubview:self.typeView];
        [self addSubview:self.statusView];
    }
    return self;
}

- (JOShowMenuView *)topView
{
    if (!_topView) {
        _topView = [[JOShowMenuView alloc] initWithFrame:CGRectMake(10, 25, SCREEN_WIDTH - 20, 30)];
        _topView.backgroundColor = RGBA16(0xFFFFFF, 0.1);
        _topView.layer.masksToBounds = YES;
        _topView.layer.cornerRadius = 15;
        //默认显示
        [_topView setTitle:@"所有星期 • 所有赛制 • 所有类型"];
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
        [_packupButton setFrame:CGRectMake(10, 25, 30, 30)];
        [_packupButton setImage:[UIImage imageNamed:@"packup"] forState:UIControlStateNormal];
        [_packupButton addTarget:self action:@selector(packupAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _packupButton;
}

- (UIButton *)clearButton
{
    if (!_clearButton) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearButton setFrame:CGRectMake(SCREEN_WIDTH - 70, 25, 60, 30)];
        [_clearButton setTintColor:[UIColor whiteColor]];
        [_clearButton setTitle:@"全部清空" forState:UIControlStateNormal];
        _clearButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_clearButton addTarget:self action:@selector(clearMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}

- (JOSelectMenuView *)weekView
{
    if (!_weekView) {
        _weekView = [[JOSelectMenuView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_topView.frame) + 10, SCREEN_WIDTH - 20, 30)];
        _weekView.backgroundColor = RGBA16(0xFFFFFF, 0.1);
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
        _systemView.backgroundColor = RGBA16(0xFFFFFF, 0.1);
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
        _typeView.backgroundColor = RGBA16(0xFFFFFF, 0.1);
        _typeView.layer.masksToBounds = YES;
        _typeView.layer.cornerRadius = 15;
        _typeView.menuList = typeMenus;
        _typeView.tag = kTypeMenuViewTag;
        _typeView.delegate = self;
    }
    return _typeView;
}

- (JOSelectMenuView *)statusView
{
    if (!_statusView) {
        _statusView = [[JOSelectMenuView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_topView.frame) + 10, SCREEN_WIDTH - 20, 30)];
        _statusView.backgroundColor = RGBA16(0xFFFFFF, 0.1);
        _statusView.layer.masksToBounds = YES;
        _statusView.layer.cornerRadius = 15;
        _statusView.menuList = statusMenus;
        _statusView.tag = kStatusMenuViewTag;
        _statusView.delegate = self;
    }
    return _statusView;
}


-(void)setIsDrop:(BOOL)isDrop
{
    _isDrop = isDrop;
    [self updateView];
}

- (void)setMatchType:(NSString *)matchType
{
    _matchType =  matchType;
    [self updateView];
    //[self refreshMatchData];
}

- (void)updateView
{
    CGFloat heightTmp = 0.0;
    if (_isDrop) {
        //菜单展开
        if ([_matchType isEqualToString:@"first"]) {
            _topView.hidden = YES;
            _packupButton.hidden = NO;
            _clearButton.hidden = NO;
            _weekView.hidden = NO;
            _systemView.hidden = NO;
            _typeView.hidden = NO;
            _statusView.hidden = YES;
            heightTmp = 185.f;
        } else {
            _topView.hidden = YES;
            _packupButton.hidden = NO;
            _clearButton.hidden = NO;
            _weekView.hidden = YES;
            _systemView.hidden = YES;
            _typeView.hidden = YES;
            _statusView.hidden = NO;
            heightTmp = 105.f;
        }

    } else {
        //菜单收起
        _topView.hidden = NO;
        _packupButton.hidden = YES;
        _clearButton.hidden = YES;
        _weekView.hidden = YES;
        _systemView.hidden = YES;
        _typeView.hidden = YES;
        _statusView.hidden = YES;
        heightTmp = 65.f;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(JOMatchMenuView:updateViewHeight:)]) {
        [_delegate JOMatchMenuView:self updateViewHeight:heightTmp];
    }
}

#pragma mark - 数据刷新

- (void)refreshMatchData
{
    //更新标头显示
    if ([_matchType isEqualToString:@"first"]) {
        //星期
        NSString *weekTmp = @"*";
        NSString *weekStr = @"";
        for (NSString *weekKey in weekSelects) {
            weekStr = [weekStr stringByAppendingString:keyValues[weekKey]];
            if ([weekSelects indexOfObject:weekKey] < (weekSelects.count - 1)) {
                weekStr = [weekStr stringByAppendingString:@" "];
            }
        }
        weekTmp = (weekStr.length > 0)?[weekStr stringByReplacingOccurrencesOfString:@" " withString:@","]:@"*";
        weekStr = (weekStr.length > 0)?weekStr:@"所有星期";
        //赛制
        NSString *systemTmp = @"*";
        NSString *systemStr = @"";
        for (NSString *systemKey in systemSelects) {
            systemStr = [systemStr stringByAppendingString:keyValues[systemKey]];
            if ([systemSelects indexOfObject:systemKey] < (systemSelects.count - 1)) {
                systemStr = [systemStr stringByAppendingString:@" "];
            }
        }
        systemTmp = (systemStr.length > 0)?[systemStr stringByReplacingOccurrencesOfString:@" " withString:@","]:@"*";
        systemStr = (systemStr.length > 0)?systemStr:@"所有赛制";
        //类型
        NSString *typeTmp = @"*";
        NSString *typeStr = @"";
        for (NSString *typeKey in typeSelects) {
            typeStr = [typeStr stringByAppendingString:keyValues[typeKey]];
            if ([typeSelects indexOfObject:typeKey] < (typeSelects.count - 1)) {
                typeStr = [typeStr stringByAppendingString:@" "];
            }
        }
        typeTmp = (typeStr.length > 0)?[typeStr stringByReplacingOccurrencesOfString:@" " withString:@","]:@"*";
        typeStr = (typeStr.length > 0)?typeStr:@"所有类型";
        NSString *title = [NSString stringWithFormat:@"%@ • %@ • %@", weekStr, systemStr, typeStr];
        [_topView setTitle:title];
        
        //数据刷新
        if (_delegate && [_delegate respondsToSelector:@selector(JOMatchMenuView:getDataWithWeeks:systems:types:)]) {
            [_delegate JOMatchMenuView:self
                      getDataWithWeeks:weekTmp
                               systems:systemTmp
                                 types:typeTmp
             ];
        }
    } else {
        //状态
        NSString *statusTmp = @"*";
        NSString *statusStr = @"";
        for (NSString *statusKey in statusSelects) {
            statusStr = [statusStr stringByAppendingString:keyValues[statusKey]];
            if ([statusSelects indexOfObject:statusKey] < (statusSelects.count - 1)) {
                statusStr = [statusStr stringByAppendingString:@" "];
            }
        }
        statusTmp = (statusStr.length > 0)?[statusStr stringByReplacingOccurrencesOfString:@" " withString:@","]:@"*";
        statusStr = (statusStr.length > 0)?statusStr:@"所有状态";
        [_topView setTitle:statusStr];
        
        //数据刷新
        if (_delegate && [_delegate respondsToSelector:@selector(JOMatchMenuView:getDataWithStatus:)]) {
            [_delegate JOMatchMenuView:self getDataWithStatus:statusTmp];
        }
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
            
        case kStatusMenuViewTag:
            [statusSelects removeAllObjects];
            [statusSelects addObjectsFromArray:options];
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
    if ([_matchType isEqualToString:@"first"]) {
        //界面
        [_weekView clearMenu];
        [_systemView clearMenu];
        [_typeView clearMenu];
        //数据
        [weekSelects removeAllObjects];
        [systemSelects removeAllObjects];
        [typeSelects removeAllObjects];
    } else {
        //界面
        [_statusView clearMenu];
        //数据
        [statusSelects removeAllObjects];
    }

    //数据刷新
    [self refreshMatchData];
}


@end
