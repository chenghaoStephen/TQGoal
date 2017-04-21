//
//  TQBriefEditCell.m
//  wegoal
//
//  Created by joker on 2017/4/20.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQBriefEditCell.h"

@interface TQBriefEditCell()<UITextViewDelegate>

@end

@implementation TQBriefEditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _textView.delegate = self;
}


#pragma mark - textView Delegate


-(void)textViewDidChange:(UITextView *)textView{
    
    if ([Victorinox isBlankString:textView.text]) {
        _placeLabel.text = @"点击输入球队概述";
    }else{
        _placeLabel.text = @"";
    }
    if (_textChangeBlock) {
        _textChangeBlock(textView.text);
    }
    
}

@end
