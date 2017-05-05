//
//  TQTeamMemberCell.m
//  wegoal
//
//  Created by joker on 2017/2/13.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQTeamMemberCell.h"

@interface TQTeamMemberCell()

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *invitateButton;

@end

@implementation TQTeamMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _selectImageView.hidden = YES;
    
    _numberLabel.layer.masksToBounds = YES;
    _numberLabel.layer.cornerRadius = _numberLabel.height/2;
    _positionLabel.layer.masksToBounds = YES;
    _positionLabel.layer.cornerRadius = _positionLabel.height/2;
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = _avatarImageView.height/2;
    _invitateButton.layer.masksToBounds = YES;
    _invitateButton.layer.cornerRadius = _invitateButton.height/2;
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

- (void)setIsInvitate:(BOOL)isInvitate
{
    _isInvitate = isInvitate;
    _invitateButton.hidden = !isInvitate;
}

- (void)setMemberData:(TQMemberModel *)memberData
{
    _memberData = memberData;
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:URL(kTQDomainURL, memberData.headPic)]
                        placeholderImage:[UIImage imageNamed:@"defaultHeadImage"]];
    _numberLabel.text = memberData.memberNumber;
    _positionLabel.text = memberData.memberPosition;
    _positionLabel.backgroundColor = [TQCommon stringToColor:memberData.memberPositionColor];
    _nameLabel.text = memberData.memberName;
}

- (void)clearInformation
{
    _avatarImageView.image = [UIImage imageNamed:@"defaultHeadImage"];
    _numberLabel.text = @"--";
    _positionLabel.text = @"--";
    _positionLabel.backgroundColor = kRedBackColor;
    _nameLabel.text = @"--";
}

- (IBAction)invitateAction:(id)sender {
    if (_invitateBlock) {
        _invitateBlock();
    }
}


@end
