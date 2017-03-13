//
//  TQHomeViewController.m
//  wegoal
//
//  Created by joker on 2016/11/27.
//  Copyright © 2016年 xdkj. All rights reserved.
//

#import "TQHomeViewController.h"
#import "TQCommandView.h"
#import "TQHomeMatchCell.h"
#import "TQMatchCell.h"
#import "TQMatchFlowLayout.h"
#import "TAPageControl.h"
#import "TQMessageViewController.h"
#import "TQProtocolViewController.h"
#import "TQWebPageViewController.h"

#define kBadgeLabelTag               1001
#define kHomeMatchCellIdentifier     @"TQHomeMatchCell"
#define kMatchCellIdentifier         @"TQMatchCell"

@interface TQHomeViewController ()<SDCycleScrollViewDelegate, TQMatchFlowLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSInteger scrollIndex;
    
    NSMutableArray *headerData;   //轮播图数据
    NSMutableArray *mainData;     //我的约战数据
    TQMatchModel *footerData;   //推荐数据
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headerView;
//banner
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
//约战
@property (nonatomic, strong) UICollectionView *matchView;
@property (nonatomic, strong) TAPageControl *matchPageControl;
//推荐
@property (nonatomic, strong) TQCommandView *commandView;

@end

@implementation TQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    headerData = [NSMutableArray array];
    mainData = [NSMutableArray array];
    scrollIndex = 0;
    [self.view addSubview:self.tableView];
    [self updateHomeSubViews];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setTabBarBtnShow];
    self.navigationItem.title = @"WeGoal";
    [self setBadgeNumber:0];
    [self setNavigationBar];
}

- (void)setNavigationBar
{
    //背景和标题
    [self.navigationController.navigationBar setBackgroundImage:[TQCommon imageWithColor:RGB16(0x57d67e)]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjects:@[[UIColor whiteColor],[UIFont boldSystemFontOfSize:18],] forKeys:@[NSForegroundColorAttributeName,NSFontAttributeName]]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_WITHOUT_TABBAR_HEIGHT)
                                                  style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kMainBackColor;
        [_tableView registerNib:[UINib nibWithNibName:@"TQMatchCell" bundle:nil] forCellReuseIdentifier:kMatchCellIdentifier];
        _tableView.tableHeaderView = self.headerView;
        __weak typeof(self) weakSelf = self;
        [_tableView addPullToRefreshWithActionHandler:^{
            [weakSelf requestData];
        }];
    }
    return _tableView;
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175 * SCALE375 + 222)];
        _headerView.backgroundColor = [UIColor clearColor];
        
        [_headerView addSubview:self.cycleScrollView];
        [_headerView addSubview:self.matchView];
        [_headerView addSubview:self.matchPageControl];
    }
    return _headerView;
}

- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140 * SCALE375)
                                                              delegate:self
                                                      placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"page_control_currentdot"];
        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"page_control_dot"];
        _cycleScrollView.delegate = self;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentLeft;
        _cycleScrollView.imageURLStringsGroup = @[@"",@"",@""];
    }
    return _cycleScrollView;
}

- (UICollectionView *)matchView
{
    if (!_matchView) {
        TQMatchFlowLayout *flow = [[TQMatchFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flow.itemSize = CGSizeMake(SCREEN_WIDTH - 50, 190);
        flow.minimumLineSpacing = -80;
        flow.minimumInteritemSpacing = 0;
        flow.delegate = self;
        flow.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        
        _matchView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_cycleScrollView.frame) + 10 * SCALE375, SCREEN_WIDTH - 20, 222) collectionViewLayout:flow];
        _matchView.backgroundColor = [UIColor clearColor];
        _matchView.delegate = self;
        _matchView.dataSource = self;
        _matchView.showsHorizontalScrollIndicator = NO;
        _matchView.layer.masksToBounds = YES;
        [_matchView registerClass:[TQHomeMatchCell class] forCellWithReuseIdentifier:kHomeMatchCellIdentifier];
    }
    return _matchView;
}

- (TAPageControl *)matchPageControl
{
    if (!_matchPageControl) {
        _matchPageControl = [[TAPageControl alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_matchView.frame) + 5 * SCALE375, SCREEN_WIDTH - 20, 8)];
        _matchPageControl.numberOfPages = 3;
        _matchPageControl.currentPage = 0;
        _matchPageControl.spacingBetweenDots = 8;
        _matchPageControl.currentDotImage = [UIImage imageNamed:@"page_control_currentdot"];
        _matchPageControl.dotImage = [UIImage imageNamed:@"page_control_dot"];
    }
    return _matchPageControl;
}

- (TQCommandView *)commandView
{
    if (!_commandView) {
        CGFloat viewHeight = MIN(165.f, MAX(156.f, VIEW_WITHOUT_TABBAR_HEIGHT - CGRectGetMaxY(_matchView.frame) - 25));
        _commandView = [[TQCommandView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_matchView.frame) + 25 * SCALE375, SCREEN_WIDTH, viewHeight)];
        _commandView.backgroundColor = [UIColor whiteColor];
    }
    return _commandView;
}

#pragma mark - navigation bar 设置

- (UIBarButtonItem*)buildLeftNavigationItem{
    //定位
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationBtn setFrame:CGRectMake(0, 0, 30, 30)];
    [locationBtn setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [locationBtn setTintColor:[UIColor whiteColor]];
//    [locationBtn addTarget:self action:@selector(changeLocation) forControlEvents:UIControlEventTouchUpInside];
    //label
    UILabel *cityLbl = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 50, 30)];
    cityLbl.backgroundColor = [UIColor clearColor];
    cityLbl.textAlignment = NSTextAlignmentLeft;
    cityLbl.textColor = [UIColor whiteColor];
    cityLbl.font = [UIFont systemFontOfSize:13.f];
    cityLbl.text = @"大连市";
    [locationBtn addSubview:cityLbl];
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:locationBtn];
    return leftBar;
}

- (UIBarButtonItem*)buildRightNavigationItem{
    //消息按钮
    UIButton *whistleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [whistleButton setFrame:CGRectMake(0, 0, 30, 30)];
    [whistleButton setImage:[UIImage imageNamed:@"whistle"] forState:UIControlStateNormal];
    [whistleButton setTintColor:[UIColor whiteColor]];
    [whistleButton addTarget:self action:@selector(showMessages) forControlEvents:UIControlEventTouchUpInside];
    //badge
    UILabel *badgeLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(whistleButton.frame) - 10, -2, 12, 12)];
    badgeLbl.backgroundColor = [UIColor redColor];
    badgeLbl.layer.masksToBounds = YES;
    badgeLbl.layer.cornerRadius = 6;
    badgeLbl.font = [UIFont systemFontOfSize:8.f];
    badgeLbl.textColor = [UIColor whiteColor];
    badgeLbl.tag = kBadgeLabelTag;
    badgeLbl.textAlignment = NSTextAlignmentCenter;
    [whistleButton addSubview:badgeLbl];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithCustomView:whistleButton];
    return rightBar;
}


#pragma mark - 数据请求

//获取主页信息
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = USER_NAME;
    params[@"Token"] = USER_TOKEN;
    [ZDMIndicatorView showInView:self.tableView];
    [[AFServer sharedInstance]GET:URL(kTQDomainURL, kHomeData) parameters:params finishBlock:^(id result) {
        [ZDMIndicatorView hiddenInView:weakSelf.tableView];
        [weakSelf.tableView.pullToRefreshView stopAnimating];
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //读取数据
                [headerData removeAllObjects];
                [headerData addObjectsFromArray:[TQBannerModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"headerData"]]];
                [mainData removeAllObjects];
                [mainData addObjectsFromArray:[TQMatchModel mj_objectArrayWithKeyValuesArray:result[@"data"][@"mainData"]]];
                footerData = [TQMatchModel mj_objectWithKeyValues:result[@"data"][@"footerData"]];
                
                //更新主页信息
                [weakSelf updateHomeSubViews];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZDMToast showWithText:result[@"msg"]];
            });
        }
        
    } failedBlock:^(NSError *error) {
        [ZDMIndicatorView hiddenInView:weakSelf.tableView];
        [weakSelf.tableView.pullToRefreshView stopAnimating];
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZDMToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
}


#pragma mark - 界面刷新

- (void)updateHomeSubViews
{
    //更新banner
    if (headerData.count > 0) {
        NSMutableArray *urlArray = [NSMutableArray array];
        for (TQBannerModel *bannerData in headerData) {
            [urlArray addObject:URL(kTQDomainURL, bannerData.imgUrl)];
        }
        _cycleScrollView.imageURLStringsGroup = urlArray;
    }
    //更新我的约战
    if (mainData.count > 1) {
        _matchView.height = 222;
        _matchPageControl.hidden = NO;
        _matchPageControl.numberOfPages = mainData.count;
        _headerView.height = 175 * SCALE375 + 222;
        _tableView.tableHeaderView = _headerView;
    } else if (mainData.count > 0) {
        //只有一组数据
        _matchView.height = 222;
        _matchPageControl.hidden = YES;
        _headerView.height = 175 * SCALE375 + 222;
        _tableView.tableHeaderView = _headerView;
    } else {
        _matchView.height = 0;
        _headerView.height = 150 * SCALE375;
        _tableView.tableHeaderView = _headerView;
        _matchPageControl.hidden = YES;
    }
    [self.matchView reloadData];
    //更新推荐
    [_tableView reloadData];
}


#pragma mark - events

- (void)setBadgeNumber:(NSInteger)badgeNumber
{
    UIView *rightView = self.navigationItem.rightBarButtonItem.customView;
    UILabel *badgeLbl = [rightView viewWithTag:kBadgeLabelTag];
    if (badgeLbl == nil) {
        return;
    }
    NSString *str = [NSString stringWithFormat:@"%ld", badgeNumber];
    if (badgeNumber > 99) {
        str = @"99+";
    }
    CGFloat width = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(badgeLbl.frame))
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{}
                                      context:nil].size.width + 2;
    width = MAX(width, 12);
    [badgeLbl setWidth:width];
    badgeLbl.text = str;
    //为0时隐藏
    if (badgeNumber > 0) {
        badgeLbl.hidden = NO;
    } else {
        badgeLbl.hidden = YES;
    }
    
}

//跳转到消息列表界面
- (void)showMessages
{
    NSLog(@"show message");
    TQMessageViewController *messageVC = [[TQMessageViewController alloc] init];
    messageVC.hidesBottomBarWhenPushed = YES;
    [self setTabbarBtnHide];
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)showMoreMatch
{
    
}

- (void)changeLocation
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"对不起，目前只支持大连市"
                                                       delegate:nil
                                              cancelButtonTitle:@"我知道了"
                                              otherButtonTitles:nil];
    [alertView show];
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击了第%ld个轮播图", (index + 1));
    //跳转到web视图
    TQWebPageViewController *webPageVC = [[TQWebPageViewController alloc] init];
    webPageVC.bannerModel = headerData[index];
    webPageVC.hidesBottomBarWhenPushed = YES;
    [self setTabbarBtnHide];
    [self.navigationController pushViewController:webPageVC animated:YES];
}


#pragma mark - TQMatchFlowLayoutDelegate

- (void)collectioViewScrollToIndex:(NSInteger)index
{
    scrollIndex = index;
    _matchPageControl.currentPage = index;
    TQHomeMatchCell *cell = (TQHomeMatchCell *)[_matchView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    if (cell) {
        [_matchView bringSubviewToFront:cell];
    }
//    cell.status = MatchStatusNewJoiner;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mainData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TQHomeMatchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeMatchCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 5.0f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.layer.shadowOpacity = 0.3;
    cell.layer.shadowRadius = 3.0f;
    cell.layer.shadowOffset = CGSizeMake(1.5, 1.5);
    if (indexPath.row < mainData.count) {
        cell.matchData = mainData[indexPath.row];
    }
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self collectioViewScrollToIndex:scrollIndex];
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:kMatchCellIdentifier];
    if (!cell) {
        NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"TQMatchCell" owner:nil options:nil].firstObject;
        cell = xibs.firstObject;
    }
    cell.isShowLine = NO;
    if (footerData) {
        cell.matchData = footerData;
        cell.isMine = NO;
    } else {
        [cell clearInformation];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 21)];
    topView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *scheduleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 13, 13)];
    scheduleImageView.image = [UIImage imageNamed:@"schedule_sign"];
    [topView addSubview:scheduleImageView];
    
    UILabel *scheduleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(scheduleImageView.frame) + 5, 8, 100, 13)];
    scheduleLabel.font = [UIFont systemFontOfSize:12.f];
    scheduleLabel.textColor = kTitleTextColor;
    scheduleLabel.textAlignment = NSTextAlignmentLeft;
    scheduleLabel.text = @"推荐约战";
    [topView addSubview:scheduleLabel];
    
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setImage:[UIImage imageNamed:@"more_match"] forState:UIControlStateNormal];
    [moreButton setFrame:CGRectMake(SCREEN_WIDTH - 25, 5, 20, 20)];
    [moreButton addTarget:self action:@selector(showMoreMatch) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:moreButton];
    return topView;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat viewHeight = MIN(144.f, MAX(135.f, VIEW_WITHOUT_TABBAR_HEIGHT - CGRectGetMaxY(_matchView.frame) - 46));
    return viewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 21.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
