//
//  TQEditMeViewController.m
//  wegoal
//
//  Created by joker on 2017/2/20.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQEditMeViewController.h"
#import "TQEditMeCell.h"
#import "TQInfoEditViewController.h"
#import "HeadImgChangeView.h"
#import "ZSYPopoverListView.h"

#define kEditMeCellIdentifier   @"TQEditMeCell"
@interface TQEditMeViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ZSYPopoverListDatasource, ZSYPopoverListDelegate>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation TQEditMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑个人资料";
    self.view.backgroundColor = kMainBackColor;
    [self.view addSubview:self.tableview];
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
        _tableview.backgroundColor = kMainBackColor;
        _tableview.dataSource = self;
        _tableview.delegate = self;
        [_tableview registerNib:[UINib nibWithNibName:@"TQEditMeCell" bundle:nil] forCellReuseIdentifier:kEditMeCellIdentifier];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 4)];
        _tableview.tableHeaderView = headerView;
    }	
    return _tableview;
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQEditMeCell *cell = [tableView dequeueReusableCellWithIdentifier:kEditMeCellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TQEditMeCell" owner:nil options:nil].firstObject;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    TQMemberModel *memberData = [UserDataManager getUserData];
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"头像";
        cell.avatarImageView.hidden = NO;
        cell.valueLabel.hidden = YES;
        [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, memberData.headPic)]
                                placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    } else {
        cell.avatarImageView.hidden = YES;
        cell.valueLabel.hidden = NO;
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"昵称";
            cell.valueLabel.text = memberData.memberName;
        } else if (indexPath.row == 2) {
            cell.titleLabel.text = @"球队";
            cell.valueLabel.text = memberData.temName;
        } else if (indexPath.row == 3) {
            cell.titleLabel.text = @"球号";
            cell.valueLabel.text = memberData.memberNumber;
        } else if (indexPath.row == 4) {
            cell.titleLabel.text = @"位置";
            cell.valueLabel.text = memberData.memberPosition;
        } else if (indexPath.row == 5) {
            cell.titleLabel.text = @"年龄";
            cell.valueLabel.text = memberData.memberAge;
        } else if (indexPath.row == 6) {
            cell.titleLabel.text = @"身高";
            cell.valueLabel.text = memberData.memberHeight;
        } else if (indexPath.row == 7) {
            cell.titleLabel.text = @"体重";
            cell.valueLabel.text = memberData.memberWeight;
        }
    }
    return cell;
}


#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80.f;
    } else {
        return 36.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TQEditMeCell *cell  =[tableView cellForRowAtIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            [self changeHeaderImage];
            break;
            
        case 1:
        {
            TQInfoEditViewController *editVC = [[TQInfoEditViewController alloc] init];
            editVC.titleName = @"昵称";
            editVC.type = EditTypeName;
            editVC.submitBlock = ^(NSString *result){
                cell.valueLabel.text = result;
            };
            [self.navigationController pushViewController:editVC animated:YES];
            break;
        }
            
        case 2:
        {
            //球队不可编辑
//            TQInfoEditViewController *editVC = [[TQInfoEditViewController alloc] init];
//            editVC.titleName = @"球队";
//            editVC.type = EditTypeTeam;
//            editVC.submitBlock = ^(NSString *result){
//                cell.valueLabel.text = result;
//            };
//            [self.navigationController pushViewController:editVC animated:YES];
            break;
        }
            
        case 3:
        {
            TQInfoEditViewController *editVC = [[TQInfoEditViewController alloc] init];
            editVC.titleName = @"球号";
            editVC.type = EditTypeNumber;
            editVC.submitBlock = ^(NSString *result){
                cell.valueLabel.text = result;
            };
            [self.navigationController pushViewController:editVC animated:YES];
            break;
        }
            
        case 4:
        {
            ZSYPopoverListView *listView = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0, 0, 120, 264)];
            listView.titleName.text = @"";
            listView.datasource = self;
            listView.delegate = self;
            listView.locationType = LocationTypeCenter;
            listView.hideTitle = YES;
            NSString *position = [UserDataManager getUserData].memberPosition;
            NSInteger index = 0;
            if (position.length > 0 && [kPositionsArray containsObject:position]) {
                index = [kPositionsArray indexOfObject:position];
            }
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            [listView show];
            [listView setTableViewSelectIndexPath:indexPath];
            break;
        }
            
        case 5:
        {
            TQInfoEditViewController *editVC = [[TQInfoEditViewController alloc] init];
            editVC.titleName = @"年龄";
            editVC.type = EditTypeAge;
            editVC.submitBlock = ^(NSString *result){
                cell.valueLabel.text = result;
            };
            [self.navigationController pushViewController:editVC animated:YES];
            break;
        }
            
        case 6:
        {
            TQInfoEditViewController *editVC = [[TQInfoEditViewController alloc] init];
            editVC.titleName = @"身高";
            editVC.type = EditTypeHeight;
            editVC.submitBlock = ^(NSString *result){
                cell.valueLabel.text = result;
            };
            [self.navigationController pushViewController:editVC animated:YES];
            break;
        }
            
        case 7:
        {
            TQInfoEditViewController *editVC = [[TQInfoEditViewController alloc] init];
            editVC.titleName = @"体重";
            editVC.type = EditTypeWeight;
            editVC.submitBlock = ^(NSString *result){
                cell.valueLabel.text = result;
            };
            [self.navigationController pushViewController:editVC animated:YES];
            break;
        }
            
        default:
            break;
    }
}


#pragma mark - popListView datasource delegate

- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kPositionsArray.count;
}

- (UITableViewCell *)popoverListView:(ZSYPopoverListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusablePopoverCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.textColor = kNavTitleColor;
    cell.textLabel.font = [UIFont systemFontOfSize:12.f];
    if (indexPath.row < kPositionsArray.count) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [kPositionsArray objectAtIndex:indexPath.row]];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (CGFloat)popoverListView:(ZSYPopoverListView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQEditMeCell *cell  =[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    NSString *position = [kPositionsArray objectAtIndex:indexPath.row];
    NSString *positionColor = [kPositionColorArray objectAtIndex:indexPath.row];
    [tableView dismiss];
    
    TQMemberModel *userData = [UserDataManager getUserData];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = userData.userName;
    params[@"memberPosition"] = position;
    params[@"memberPositionColor"] = positionColor;
    [JOIndicatorView showInView:self.view];
    [[AFServer sharedInstance]POST:URL(kTQDomainURL, kSetMember) parameters:params filePath:nil finishBlock:^(id result) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //保存成功
                [JOToast showWithText:@"保存成功"];
                //存储个人信息
                NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithDictionary:[UserDataManager getUserDataDict]];
                userDict[@"memberPosition"] = position;
                [UserDataManager setUserData:userDict];
                //更新显示
                cell.valueLabel.text = position;
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [JOToast showWithText:result[@"msg"]];
            });
        }
        
        
    } failedBlock:^(NSError *error) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        dispatch_async(dispatch_get_main_queue(), ^{
            [JOToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



#pragma mark - 头像

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
    
    NSString *path = [[Victorinox dirnameWithUserCache] stringByAppendingString:@"/img_up.jpeg"];
    [data writeToFile:path atomically:YES];
    //上传头像
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [JOIndicatorView showInView:self.view];
    [[AFServer sharedInstance]POST:URL(kTQDomainURL, kSetMemberPic) parameters:params filePath:path finishBlock:^(id result) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //图像上传成功，保存用户信息
                [weakSelf saveUserAvatar:result[@"data"]];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [JOToast showWithText:result[@"msg"]];
            });
        }
        
        
    } failedBlock:^(NSError *error) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        dispatch_async(dispatch_get_main_queue(), ^{
            [JOToast showWithText:@"网络连接失败，请稍后再试！"];
        });
    }];
    
}

- (void)saveUserAvatar:(NSString *)headPic
{
    TQEditMeCell *cell  =[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    TQMemberModel *userData = [UserDataManager getUserData];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userName"] = userData.userName;
    params[@"headPic"] = headPic;
    [JOIndicatorView showInView:self.view];
    [[AFServer sharedInstance]POST:URL(kTQDomainURL, kSetMember) parameters:params filePath:nil finishBlock:^(id result) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        
        if (result[@"status"] != nil && [result[@"status"] integerValue] == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //保存成功
                [JOToast showWithText:@"保存成功"];
                //存储个人信息
                NSMutableDictionary *userDict = [NSMutableDictionary dictionaryWithDictionary:[UserDataManager getUserDataDict]];
                userDict[@"headPic"] = headPic;
                [UserDataManager setUserData:userDict];
                //更新显示
                [cell.avatarImageView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, headPic)]
                                        placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [JOToast showWithText:result[@"msg"]];
            });
        }
        
        
    } failedBlock:^(NSError *error) {
        [JOIndicatorView hiddenInView:weakSelf.view];
        dispatch_async(dispatch_get_main_queue(), ^{
            [JOToast showWithText:@"网络连接失败，请稍后再试！"];
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
