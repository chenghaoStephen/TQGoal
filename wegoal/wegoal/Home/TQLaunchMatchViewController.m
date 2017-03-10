//
//  TQLaunchMatchViewController.m
//  wegoal
//
//  Created by joker on 2017/3/9.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQLaunchMatchViewController.h"
#import "TQTeamInformationView.h"
#import "TQMatchInformationCell.h"
#import "TQMatchRefereeCell.h"

#define kTQMatchInformationCellIdentifier   @"TQMatchInformationCell"
#define kTQMatchRefereeCellIdentifier       @"TQMatchRefereeCell"
@interface TQLaunchMatchViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) TQTeamInformationView *topView;
@property (strong, nonatomic) UITableView *detailTableView;
@property (strong, nonatomic) UIButton *nextStep;

@property (assign, nonatomic) BOOL isRefereePackup;

@end

@implementation TQLaunchMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发起约战";
    _isRefereePackup = NO;
    self.view.backgroundColor = kMainBackColor;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.detailTableView];
    [self.view addSubview:self.nextStep];
}

- (TQTeamInformationView *)topView
{
    if (!_topView) {
        _topView = [[TQTeamInformationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        _topView.backgroundColor = [UIColor blackColor];
        _topView.viewMode = TeamTopViewModeTeam;
    }
    return _topView;
}

- (UITableView *)detailTableView
{
    if (!_detailTableView) {
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), SCREEN_WIDTH, VIEW_HEIGHT - 194) style:UITableViewStylePlain];
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTableView.dataSource = self;
        _detailTableView.delegate = self;
        _detailTableView.backgroundColor = kMainBackColor;
        [_detailTableView registerNib:[UINib nibWithNibName:@"TQMatchInformationCell" bundle:nil] forCellReuseIdentifier:kTQMatchInformationCellIdentifier];
        [_detailTableView registerNib:[UINib nibWithNibName:@"TQMatchRefereeCell" bundle:nil] forCellReuseIdentifier:kTQMatchRefereeCellIdentifier];
    }
    return _detailTableView;
}

- (UIButton *)nextStep
{
    if (!_nextStep) {
        _nextStep = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextStep.frame = CGRectMake(0, VIEW_HEIGHT - 44, SCREEN_WIDTH, 44);
        _nextStep.backgroundColor = kSubjectBackColor;
        [_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
        _nextStep.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextStep addTarget:self action:@selector(nextStepAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStep;
}


#pragma mark - events

- (void)nextStepAction
{
    NSLog(@"next step!");
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 0 && indexPath.row < 4) {
        TQMatchInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMatchInformationCellIdentifier];
        if (!cell) {
            NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"TQMatchInformationCell" owner:nil options:nil].firstObject;
            cell = xibs.firstObject;
        }
        switch (indexPath.row) {
            case 0:
                cell.infoImageView.image = [UIImage imageNamed:@"match_time"];
                cell.infoTitleLabel.text = @"约战时间";
                cell.infoContentLabel.text = @"---";
                break;
            case 1:
                cell.infoImageView.image = [UIImage imageNamed:@"match_ground"];
                cell.infoTitleLabel.text = @"约战场地";
                cell.infoContentLabel.text = @"---";
                break;
            case 2:
                cell.infoImageView.image = [UIImage imageNamed:@"ground_pay"];
                cell.infoTitleLabel.text = @"场地费用";
                cell.infoContentLabel.text = @"---";
                break;
            case 3:
                cell.infoImageView.image = [UIImage imageNamed:@"race_system"];
                cell.infoTitleLabel.text = @"赛制";
                cell.infoContentLabel.text = @"---";
                break;
                
            default:
                cell.infoImageView.image = nil;
                cell.infoTitleLabel.text = @"---";
                cell.infoContentLabel.text = @"---";
                break;
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        return cell;
    } else {
        TQMatchRefereeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTQMatchRefereeCellIdentifier];
        if (!cell) {
            NSArray *xibs = [[NSBundle mainBundle] loadNibNamed:@"TQMatchRefereeCell" owner:nil options:nil].firstObject;
            cell = xibs.firstObject;
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        cell.isPackup = _isRefereePackup;
        cell.block = ^(BOOL isPackup){
            weakSelf.isRefereePackup = isPackup;
            [weakSelf.detailTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        };
        return cell;
    }
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 0 && indexPath.row < 4) {
        return 37.f;
    } else {
        if (_isRefereePackup) {
            return 40.f;
        } else {
            return 120.f;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
