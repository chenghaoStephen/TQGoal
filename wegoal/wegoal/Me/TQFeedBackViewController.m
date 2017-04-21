//
//  TQFeedBackViewController.m
//  wegoal
//
//  Created by joker on 2017/4/21.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import "TQFeedBackViewController.h"

@interface TQFeedBackViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TQFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)submitAction:(id)sender {
    
}


#pragma mark - textView Delegate

-(void)textViewDidChange:(UITextView *)textView{
    
    if ([Victorinox isBlankString:textView.text]) {
        _placeLabel.text = @"请告诉我们您的想法";
    }else{
        _placeLabel.text = @"";
    }
    
    
}

@end
