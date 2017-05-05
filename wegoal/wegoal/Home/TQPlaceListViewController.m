//
//  TQPlaceListViewController.m
//  wegoal
//
//  Created by joker on 2017/3/14.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQPlaceListViewController.h"
#import "TQPlaceCell.h"

#define kTQPlaceCellIdentifier     @"TQPlaceCell"
@interface TQPlaceListViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *placesArray;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation TQPlaceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择球场";
    self.view.backgroundColor = kMainBackColor;
    placesArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self requestData];
}

- (UIBarButtonItem*)buildRightNavigationItem{
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_gray"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(searchAction)];
    return rightBar;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 3, SCREEN_WIDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kMainBackColor;
        [_tableView registerNib:[UINib nibWithNibName:@"TQPlaceCell" bundle:nil] forCellReuseIdentifier:kTQPlaceCellIdentifier];
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 3)];
        headerView.backgroundColor = kMainBackColor;
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}


#pragma mark - events

- (void)searchAction
{
    NSLog(@"search place.");
}

//获取主页信息
- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = USER_NAME;
    params[@"Token"] = USER_TOKEN;
    [JOIndicatorView showInView:self.tableView];
    [[AFServer sharedInstance]GET:URL(kTQDomainURL, kGamePlace) parameters:params finishBlock:^(id result) {
        [JOIndicatorView hiddenInView:weakSelf.tableView];
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //读取数据
                [placesArray removeAllObjects];
                [placesArray addObjectsFromArray:[TQPlaceModel mj_objectArrayWithKeyValuesArray:result[@"data"]]];
                //更新主页信息
                [weakSelf.tableView reloadData];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [JOToast showWithText:result[@"msg"]];
            });
        }
        
    } failedBlock:^(NSError *error) {
        [JOIndicatorView hiddenInView:weakSelf.tableView];
        dispatch_async(dispatch_get_main_queue(), ^{
            [JOToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return placesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQPlaceCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQPlaceCell" owner:nil options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row < placesArray.count) {
        cell.placeData = placesArray[indexPath.row];
    } else {
        [cell clearInfomation];
    }
    __weak typeof(self) weakSelf = self;
    cell.telBlk = ^(NSString *number){
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", number]];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            if (!weakSelf.webView) {
                weakSelf.webView = [[UIWebView alloc] init];
            }
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [weakSelf.webView loadRequest:request];
        }else{
            [JOToast showWithText:@"不支持打电话功能"];
        }
    };
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 169.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < placesArray.count && _selectPlaceBlk) {
        _selectPlaceBlk(placesArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end


