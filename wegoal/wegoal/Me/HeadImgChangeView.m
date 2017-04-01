//
//  GXShareView.m
//  WeGoal
//
//  Created by joker on 15/5/28.
//  Copyright (c) 2015年 WeGoal. All rights reserved.
//

#import "HeadImgChangeView.h"
#import "GXShareCollectionCell.h"
#define Column 3 // 有几列
@interface HeadImgChangeView()<UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate>

- (instancetype)initWithImageArray:(NSArray*)imageArray withNameArray:(NSArray*)nameArray;
@property (nonatomic,strong) NSArray*imageArray;
@property (nonatomic,strong) NSArray*nameArray;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) CGFloat margin;//每个图片的高度
@property (nonatomic,assign) CGFloat collectionHeight;
@property (nonatomic,assign) BOOL isClick; // 屏蔽快速点击
@property (nonatomic,copy)   didSelectBlock  block;
@end
@implementation HeadImgChangeView
- (instancetype)initWithImageArray:(NSArray*)imageArray  withNameArray:(NSArray*)nameArray{
    if (self = [super initWithFrame:CGRectZero]){
        self.imageArray = [NSArray arrayWithArray:imageArray];
        self.nameArray = [NSArray arrayWithArray:nameArray];
    }
    return self;
}

- (void)setUpView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenShareView)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    self.collectionHeight = self.margin*ceil((float)self.imageArray.count/Column)+self.margin/2*((float)ceil((float)self.imageArray.count/Column)-1)+10;
    self.backgroundColor = RGBA16(0x000, 0.5);
    self.contentView = [[UIView alloc]init];
//    self.contentView.backgroundColor = RGB16(0xececec);
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = CGRectMake(0, self.frame.size.height, CGRectGetWidth(self.frame), self.margin+self.collectionHeight);
    [self addSubview:self.contentView];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc ]init];
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, self.margin/2-15, CGRectGetWidth(self.frame), self.collectionHeight) collectionViewLayout:flowLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GXShareCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.collectionView];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.margin/2-15+self.collectionHeight, CGRectGetWidth(self.frame), 0.5)];
    line.backgroundColor = kNavTitleColor;
    [self.contentView addSubview:line];
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(0, self.collectionHeight+self.margin/2-15, CGRectGetWidth(self.frame), 50);
    [cancelButton setTitleColor:kNavTitleColor forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(hiddenShareView) forControlEvents:UIControlEventTouchUpInside];
//    cancelButton.layer.borderColor = SystemLineColor.CGColor;
//    cancelButton.layer.borderWidth = 1;
    [self.contentView addSubview:cancelButton];
    [self showShareView];
    
}

+ (void)showShareViewWithImageArray:(NSArray*)imageArray  withNameArray:(NSArray*)nameArray withCompletion:(didSelectBlock)completion{
    HeadImgChangeView * shareView = [[HeadImgChangeView alloc]initWithImageArray:imageArray withNameArray:nameArray];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    shareView.margin = CGRectGetWidth(window.frame)/(Column*2)+30;
    shareView.frame = window.bounds;
    [shareView setUpView];
    [window addSubview:shareView];
    shareView.block = completion;
    
}

+ (void)showShareViewInView:(UIView*)baseView withImageArray:(NSArray*)imageArray  withNameArray:(NSArray*)nameArray withCompletion:(didSelectBlock)completion{
    HeadImgChangeView * shareView = [[HeadImgChangeView alloc]initWithImageArray:imageArray withNameArray:nameArray];
    shareView.margin = CGRectGetWidth(baseView.frame)/(Column*2)+30;
    shareView.frame = baseView.bounds;
    [baseView addSubview:shareView];
    shareView.block = completion;
}

#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

//定义展示的Section的个数

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"CollectionCell";
    GXShareCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.imageItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",self.imageArray[indexPath.row]]];
    cell.name.text = self.nameArray[indexPath.row];

    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(collectionView.frame)/2, self.margin);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return (self.margin-30)/2;

}
#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.block) {
        self.block(indexPath.row);
    }
    [self hiddenShareView];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void) hiddenShareView{
    if (self.isClick == YES) {
        return ;
    }
    self.isClick = true;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(0, self.frame.size.height, CGRectGetWidth(self.frame), self.margin+self.collectionHeight);

    } completion:^(BOOL finished) {
        self.contentView.hidden = YES;
        self.isClick = NO;
        [self removeFromSuperview];
    }];
}

- (void) showShareView{
    if (self.isClick == YES) {
        return ;
    }
    self.isClick = true;
    self.contentView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(0, self.frame.size.height- (self.margin/2-15+self.collectionHeight+self.margin/2), CGRectGetWidth(self.frame), self.margin/2-15+self.collectionHeight+self.margin/2);

    } completion:^(BOOL finished) {
        self.isClick = NO;
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view !=self) {
        return NO;
    }
    return YES;
}
@end
