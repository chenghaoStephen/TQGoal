//
//  TQCreateTeamViewController.m
//  wegoal
//
//  Created by joker on 2017/4/20.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQCreateTeamViewController.h"
#import "TQEditMeCell.h"
#import "TQBriefEditCell.h"
#import "TQTeamInfoEditViewController.h"
#import "HeadImgChangeView.h"
#import "XHDatePickerView.h"

#define kEditMeCellIdentifier   @"TQEditMeCell"
#define kBriefEditCellIdentifier   @"TQBriefEditCell"
@interface TQCreateTeamViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *createButton;
@property (nonatomic, strong) TQTeamModel *teamData;

@end

@implementation TQCreateTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"创建球队";
    _teamData = [[TQTeamModel alloc] init];
    self.view.backgroundColor = kMainBackColor;
    [self registerNotifications];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.createButton];
}

- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    //根据键盘高度，滚动视图
    self.tableView.contentOffset = CGPointMake(0, 400 - (VIEW_HEIGHT - keyboardHeight));
}

- (void)keyboardWillHidden:(NSNotification *)notification
{
    self.tableView.contentOffset = CGPointMake(0, 0);
}



- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT - 44) style:UITableViewStylePlain];
        _tableView.backgroundColor = kMainBackColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerNib:[UINib nibWithNibName:@"TQEditMeCell" bundle:nil] forCellReuseIdentifier:kEditMeCellIdentifier];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 4)];
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}

- (UIButton *)createButton
{
    if (!_createButton) {
        _createButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _createButton.frame = CGRectMake(0, VIEW_HEIGHT - 44, SCREEN_WIDTH, 44);
        _createButton.backgroundColor = kSubjectBackColor;
        [_createButton setTitle:@"创建" forState:UIControlStateNormal];
        _createButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_createButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_createButton addTarget:self action:@selector(createTeamAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _createButton;
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        TQBriefEditCell *cell = [tableView dequeueReusableCellWithIdentifier:kBriefEditCellIdentifier];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"TQBriefEditCell" owner:nil options:nil].firstObject;
        }
        __weak typeof(self) weakSelf = self;
        cell.textChangeBlock = ^(NSString *textStr){
            weakSelf.teamData.teamBrief = textStr;
        };
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    TQEditMeCell *cell = [tableView dequeueReusableCellWithIdentifier:kEditMeCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQEditMeCell" owner:nil options:nil].firstObject;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"队徽";
        cell.avatarImageView.hidden = NO;
        cell.valueLabel.hidden = YES;
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, _teamData.teamLogo)]
                                placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    } else {
        cell.avatarImageView.hidden = YES;
        cell.valueLabel.hidden = NO;
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"球队名";
            cell.valueLabel.text = _teamData.teamName;
        } else if (indexPath.row == 2) {
            cell.titleLabel.text = @"负责人姓名";
            cell.valueLabel.text = _teamData.contactName;
        } else if (indexPath.row == 3) {
            cell.titleLabel.text = @"联系人电话";
            cell.valueLabel.text = _teamData.contactPhone;
        } else if (indexPath.row == 4) {
            cell.titleLabel.text = @"成立时间";
            cell.valueLabel.text = [NSDate datestrFromDate:[NSDate dateFromString:_teamData.teamCreateDate format:kDateFormatter1] withDateFormat:kDateFormatter3];
        }
    }
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80.f;
    } else if (indexPath.row > 0 && indexPath.row < 5) {
        return 36.f;
    } else {
        return 175.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.view endEditing:YES];
    if (indexPath.row == 5) {
        return;
    }
    TQEditMeCell *cell  =[tableView cellForRowAtIndexPath:indexPath];
    __weak typeof(self) weakSelf = self;
    switch (indexPath.row) {
        case 0:
            [self changeHeaderImage];
            break;
            
        case 1:
        {
            TQTeamInfoEditViewController *editVC = [[TQTeamInfoEditViewController alloc] init];
            editVC.titleName = @"球队名";
            editVC.type = TeamEditTypeName;
            editVC.submitBlock = ^(NSString *result){
                cell.valueLabel.text = result;
                weakSelf.teamData.teamName = result;
            };
            [self.navigationController pushViewController:editVC animated:YES];
            break;
        }
            
        case 2:
        {
            TQTeamInfoEditViewController *editVC = [[TQTeamInfoEditViewController alloc] init];
            editVC.titleName = @"负责人姓名";
            editVC.type = TeamEditTypeContactName;
            editVC.submitBlock = ^(NSString *result){
                cell.valueLabel.text = result;
                weakSelf.teamData.contactName = result;
            };
            [self.navigationController pushViewController:editVC animated:YES];
            break;
        }
            
        case 3:
        {
            TQTeamInfoEditViewController *editVC = [[TQTeamInfoEditViewController alloc] init];
            editVC.titleName = @"联系人电话";
            editVC.type = TeamEditTypeContactPhone;
            editVC.submitBlock = ^(NSString *result){
                cell.valueLabel.text = result;
                weakSelf.teamData.contactPhone = result;
            };
            [self.navigationController pushViewController:editVC animated:YES];
            break;
        }
            
        case 4:
        {
            XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCompleteBlock:^(NSDate *startDate) {
                cell.valueLabel.text = [NSDate datestrFromDate:startDate withDateFormat:kDateFormatter3];
                weakSelf.teamData.teamCreateDate = [NSDate datestrFromDate:startDate withDateFormat:kDateFormatter1];
            }];
            datepicker.datePickerStyle = DateStyleShowYearMonthDay;
            datepicker.themeColor = kSubjectBackColor;
            datepicker.minLimitDate = [NSDate dateWithTimeIntervalSince1970:0];
            [datepicker show];
            break;
        }
            
        default:
            break;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


//创建球队
- (void)createTeamAction
{
    if (![self checkInput]) {
        return;
    }
    
    TQMemberModel *userData = [UserDataManager getUserData];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = userData.userName;
    params[@"teamLogo"] = _teamData.teamLogo;
    params[@"teamName"] = _teamData.teamName;
    params[@"contactName"] = _teamData.contactName;
    params[@"contactPhone"] = _teamData.contactPhone;
    params[@"teamCreateDate"] = _teamData.teamCreateDate;
    params[@"teamBrief"] = _teamData.teamBrief;
    [ZDMIndicatorView showInView:self.view];
    [[AFServer sharedInstance]POST:URL(kTQDomainURL, kUserCreatTeam) parameters:params filePath:nil finishBlock:^(id result) {
        [ZDMIndicatorView hiddenInView:weakSelf.view];
        
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //创建成功
                [ZDMToast showWithText:@"创建成功"];
                //更新个人的球队名称
                NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithDictionary:[UserDataManager getUserDataDict]];
                userDict[@"temName"] = weakSelf.teamData.teamName;
                [UserDataManager setUserData:userDict];
//                //更新个人信息
//                [UserDataManager setUserData:result[@"data"]];
                //通知
                [[NSNotificationCenter defaultCenter] postNotificationName:kTeamCreateSuccess object:nil userInfo:nil];
                //返回上一页
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZDMToast showWithText:result[@"msg"]];
            });
        }
        
        
    } failedBlock:^(NSError *error) {
        [ZDMIndicatorView hiddenInView:weakSelf.view];
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZDMToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
}

- (BOOL)checkInput
{
    NSString *msg;
    BOOL result = YES;
    if (_teamData.teamName.length == 0) {
        msg = @"请输入球队名";
        result = NO;
    } else if (_teamData.teamLogo.length == 0) {
        msg = @"请选择一个队徽";
        result = NO;
    } else if (_teamData.contactName.length == 0) {
        msg = @"请输入负责人姓名";
        result = NO;
    } else if (_teamData.contactPhone.length == 0) {
        msg = @"请输入联系人电话";
        result = NO;
    } else if (_teamData.teamCreateDate.length == 0) {
        msg = @"请输入球队成立时间";
        result = NO;
    } else if (_teamData.teamBrief.length == 0) {
        msg = @"请输入球队介绍";
        result = NO;
    }
    
    if (!result) {
        [ZDMToast showWithText:msg];
    }
    
    return result;
    
}



#pragma mark - 队徽

// 更换头像
- (void)changeHeaderImage{
    
    [HeadImgChangeView showShareViewWithImageArray:@[@"Me_picture",@"Me_camera"] withNameArray: @[@"相册",@"相机"] withCompletion:^(NSInteger selectIndex) {
        
        switch (selectIndex) {
            case 0:
                [self chooseFromAlbum];
                break;
                
            case 1:
                [self takePhoto];
                break;
                
            default:
                return;
        }
        
    }];
    
}
// 拍照
-(void)takePhoto{
    // 拍照
    if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([self isFrontCameraAvailable]) {
            controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        controller.allowsEditing = YES;
        [self presentViewController:controller
                           animated:YES
                         completion:^(void){
                         }];
    }else{
        NSLog(@"该设备不支持拍照功能");
    }
    
}
// 从相册中选取
-(void)chooseFromAlbum{
    // 从相册中选取
    if ([self isPhotoLibraryAvailable]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.allowsEditing = YES;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        controller.mediaTypes = mediaTypes;
        controller.delegate = self;
        [self presentViewController:controller
                           animated:YES
                         completion:^(void){
                             
                         }];
    }
    
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *editImg = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        if (editImg==nil) {
            editImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            
        }
        [self updateUserHeadImage:UIImageJPEGRepresentation(editImg,0.2)];
        
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

- (void)updateUserHeadImage:(NSData*)data{
    
    TQEditMeCell *cell  =[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *path = [[Victorinox dirnameWithUserCache] stringByAppendingString:@"/img_up.jpeg"];
    [data writeToFile:path atomically:YES];
    //上传头像
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [ZDMIndicatorView showInView:self.view];
    [[AFServer sharedInstance]POST:URL(kTQDomainURL, kSetMemberPic) parameters:params filePath:path finishBlock:^(id result) {
        [ZDMIndicatorView hiddenInView:weakSelf.view];
        
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //图像上传成功，保存队徽
                weakSelf.teamData.teamLogo = result[@"data"];
                [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, result[@"data"])]
                                        placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZDMToast showWithText:result[@"msg"]];
            });
        }
        
        
    } failedBlock:^(NSError *error) {
        [ZDMIndicatorView hiddenInView:weakSelf.view];
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZDMToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
    
}


#pragma mark UIImagePickerController 相关属性
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}


@end










