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

#define kEditMeCellIdentifier   @"TQEditMeCell"
@interface TQEditMeViewController ()<UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

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
        
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
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
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"头像";
        cell.imageView.hidden = NO;
        cell.valueLabel.hidden = YES;
    } else {
        cell.imageView.hidden = YES;
        cell.valueLabel.hidden = NO;
        if (indexPath.row == 1) {
            cell.titleLabel.text = @"昵称";
            cell.valueLabel.text = @"--";
        } else if (indexPath.row == 2) {
            cell.titleLabel.text = @"球队";
            cell.valueLabel.text = @"--";
        } else if (indexPath.row == 3) {
            cell.titleLabel.text = @"球号";
            cell.valueLabel.text = @"--";
        } else if (indexPath.row == 4) {
            cell.titleLabel.text = @"位置";
            cell.valueLabel.text = @"--";
        } else if (indexPath.row == 5) {
            cell.titleLabel.text = @"年龄";
            cell.valueLabel.text = @"--";
        } else if (indexPath.row == 6) {
            cell.titleLabel.text = @"身高";
            cell.valueLabel.text = @"--";
        } else if (indexPath.row == 7) {
            cell.titleLabel.text = @"体重";
            cell.valueLabel.text = @"--";
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
    switch (indexPath.row) {
        case 0:
            [self changeHeaderImage];
            break;
            
        default:
            break;
    }
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
