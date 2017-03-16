//
//  TQMatchServiceCell.m
//  wegoal
//
//  Created by joker on 2017/3/13.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMatchServiceCell.h"

@interface TQMatchServiceCell()

@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UIImageView *serviceAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarLeftConstraint;


@end

@implementation TQMatchServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _contentLabel.numberOfLines = 0;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下方添加一条分隔线
    CGContextSetStrokeColorWithColor(context, kMainBackColor.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - .5, rect.size.width, .5));
}

- (void)setSelected:(BOOL)selected andAmount:(NSUInteger)amount
{
    _selectedButton.selected = selected;
    _amountLabel.text = [NSString stringWithFormat:@"%ld", amount];
    if (amount == 0) {
        [_minusBtn setImage:[UIImage imageNamed:@"reduce_white"] forState:UIControlStateNormal];
    } else {
        [_minusBtn setImage:[UIImage imageNamed:@"reduce_black"] forState:UIControlStateNormal];
    }
}

#pragma mark - events

- (void)setServiceData:(TQServiceModel *)serviceData
{
    [_serviceAvatarImageView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, serviceData.imgUrl)]
                               placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    _nameLabel.text = serviceData.serviceTypeName;
    _costLabel.text = [NSString stringWithFormat:@"￥%@", serviceData.price?:@""];
//    _contentLabel.text = serviceData.bodyContent;
    _amountLabel.text = [NSString stringWithFormat:@"%ld", serviceData.amount];
}

- (void)clearInformation
{
    _serviceAvatarImageView.image = [UIImage imageNamed:@"defaultHeadImage"];
    _nameLabel.text = @"---";
    _costLabel.text = @"￥---";
    _contentLabel.text = @"---";
}

- (IBAction)selectAction:(id)sender {
    _selectedButton.selected = !_selectedButton.selected;
    if (_selectBlk) {
        _selectBlk(_selectedButton.selected);
    }
}

- (void)setCanSelected:(BOOL)canSelected
{
    _canSelected = canSelected;
    if (canSelected) {
        _selectedButton.hidden = NO;
        _avatarLeftConstraint.constant = 32.f;
        _minusBtn.hidden = NO;
        _plusBtn.hidden = NO;
//        _amountLabel.hidden = NO;
        _amountLabel.backgroundColor = kUnenableColor;
    } else {
        _selectedButton.hidden = YES;
        _avatarLeftConstraint.constant = 8.f;
        _minusBtn.hidden = YES;
        _plusBtn.hidden = YES;
//        _amountLabel.hidden = YES;
        _amountLabel.backgroundColor = [UIColor clearColor];
    }
}

- (IBAction)minusAction:(id)sender {
    if ([_amountLabel.text integerValue] == 0) {
        return;
    }
    NSUInteger newAmount = [_amountLabel.text integerValue] - 1;
    _amountLabel.text = [NSString stringWithFormat:@"%ld", newAmount];
    if (newAmount == 0) {
        [_minusBtn setImage:[UIImage imageNamed:@"reduce_white"] forState:UIControlStateNormal];
    } else {
        [_minusBtn setImage:[UIImage imageNamed:@"reduce_black"] forState:UIControlStateNormal];
    }
    if (_amountBlk) {
        _amountBlk(newAmount);
    }
}

- (IBAction)plusAction:(id)sender {
    NSUInteger newAmount = [_amountLabel.text integerValue] + 1;
    _amountLabel.text = [NSString stringWithFormat:@"%ld", newAmount];
    if (newAmount == 0) {
        [_minusBtn setImage:[UIImage imageNamed:@"reduce_white"] forState:UIControlStateNormal];
    } else {
        [_minusBtn setImage:[UIImage imageNamed:@"reduce_black"] forState:UIControlStateNormal];
    }
    if (_amountBlk) {
        _amountBlk(newAmount);
    }
}

@end
