//
//  TQMessageCell.m
//  wegoal
//
//  Created by joker on 2017/3/7.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQMessageCell.h"

@interface TQMessageCell()

@property (weak, nonatomic) IBOutlet UIImageView *messageImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *latestMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation TQMessageCell

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    //下方添加一条分隔线
    CGContextSetStrokeColorWithColor(context, kMainBackColor.CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - .5, rect.size.width, .5));
}

- (void)setMessageData:(TQMessageModel *)messageData
{
    _messageData = messageData;
    switch ([messageData.type integerValue]) {
        case MessageTypeDeal:
            _messageImageView.image = [UIImage imageNamed:@"deal_message"];
            _messageTitleLabel.text = @"交易消息";
            break;
            
        case MessageTypeMatch:
            _messageImageView.image = [UIImage imageNamed:@"match_message"];
            _messageTitleLabel.text = @"约战消息";
            break;
            
        case MessageTypeSystem:
            _messageImageView.image = [UIImage imageNamed:@"system_message"];
            _messageTitleLabel.text = @"系统消息";
            break;
            
        default:
            break;
    }
    _latestMessageLabel.text = messageData.latestMessage;
    _timeLabel.text = messageData.time;
}

@end
