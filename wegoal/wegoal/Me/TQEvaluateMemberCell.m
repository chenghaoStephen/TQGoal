//
//  TQEvaluateMemberCell.m
//  wegoal
//
//  Created by joker on 2017/3/16.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQEvaluateMemberCell.h"

@interface TQEvaluateMemberCell()

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIImageView *mvpSignImageView;

@end

@implementation TQEvaluateMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _numberLabel.layer.masksToBounds = YES;
    _numberLabel.layer.cornerRadius = _numberLabel.height/2;
    _positionLabel.layer.masksToBounds = YES;
    _positionLabel.layer.cornerRadius = _positionLabel.height/2;
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = _avatarImageView.height/2;
}

- (void)drawRect:(CGRect)rect
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
        [_minusButton setImage:[UIImage imageNamed:@"reduce_white"] forState:UIControlStateNormal];
    } else {
        [_minusButton setImage:[UIImage imageNamed:@"reduce_black"] forState:UIControlStateNormal];
    }
}

- (void)setMemberData:(TQMemberModel *)memberData
{
    _memberData = memberData;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, memberData.headPic)]
                        placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    _numberLabel.text = memberData.memberNumber;
    _positionLabel.text = memberData.memberPosition;
    _nameLabel.text = memberData.memberName;
    if (memberData.isMvp) {
        _mvpSignImageView.image = [UIImage imageNamed:@"MVP"];
    } else {
        _mvpSignImageView.image = nil;
    }
}

- (void)clearInformation
{
    _avatarImageView.image = [UIImage imageNamed:@"defaultHeadImage"];
    _numberLabel.text = @"--";
    _positionLabel.text = @"--";
    _nameLabel.text = @"--";
}

- (void)setCanEdit:(BOOL)canEdit
{
    _canEdit = canEdit;
    if (canEdit) {
        _mvpSignImageView.hidden = YES;
        _selectedButton.hidden = NO;
        _plusButton.hidden = NO;
        _minusButton.hidden = NO;
        _amountLabel.backgroundColor = kUnenableColor;
    } else {
        _mvpSignImageView.hidden = NO;
        _selectedButton.hidden = YES;
        _plusButton.hidden = YES;
        _minusButton.hidden = YES;
        _amountLabel.backgroundColor = [UIColor clearColor];
    }
}


#pragma mark - events

- (IBAction)selectAction:(id)sender {
    _selectedButton.selected = YES;
    if (_selectBlk) {
        _selectBlk(YES);
    }
}


- (IBAction)minusAction:(id)sender {
    if ([_amountLabel.text integerValue] == 0) {
        return;
    }
    NSUInteger newAmount = [_amountLabel.text integerValue] - 1;
    _amountLabel.text = [NSString stringWithFormat:@"%ld", newAmount];
    if (newAmount == 0) {
        [_minusButton setImage:[UIImage imageNamed:@"reduce_white"] forState:UIControlStateNormal];
    } else {
        [_minusButton setImage:[UIImage imageNamed:@"reduce_black"] forState:UIControlStateNormal];
    }
    if (_amountBlk) {
        _amountBlk(newAmount);
    }
}

- (IBAction)plusAction:(id)sender {
    if ([_amountLabel.text integerValue] == 10) {
        return;
    }
    NSUInteger newAmount = [_amountLabel.text integerValue] + 1;
    _amountLabel.text = [NSString stringWithFormat:@"%ld", newAmount];
    if (newAmount == 0) {
        [_minusButton setImage:[UIImage imageNamed:@"reduce_white"] forState:UIControlStateNormal];
    } else {
        [_minusButton setImage:[UIImage imageNamed:@"reduce_black"] forState:UIControlStateNormal];
    }
    if (_amountBlk) {
        _amountBlk(newAmount);
    }
}



@end
