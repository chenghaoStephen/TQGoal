//
//  JOCodeView.m
//
//  Created by joker on 2017/3/30.
//  Copyright © 2017年 joker. All rights reserved.
//

#import "JOCodeView.h"

#define Space 5
#define LineWidth (self.frame.size.width - self.lineNumber * 2 * Space)/self.lineNumber
#define LineHeight 2
#define LineBottomHeight 5
#define UnderLineCenterY (self.frame.size.height - LineBottomHeight - LineHeight/2)

@interface JOCodeView()<UITextFieldDelegate>
{
    //观察者，监听textField文字变化
    NSObject *observer;
}

@property (nonatomic, strong) NSMutableArray *textArray;
@property (nonatomic, assign) NSUInteger lineNumber;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIFont *textFont;

@property (nonatomic, strong) UITextField *textField;

@end


@implementation JOCodeView


- (instancetype)initWithFrame:(CGRect)frame
                       number:(NSUInteger)number
                        color:(UIColor *)color
                         font:(UIFont *)font
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        _textArray = [NSMutableArray arrayWithCapacity:number];
        
        //参数设置
        _lineNumber = number;
        _lineColor = color;
        _textFont = font;
        
        self.textField.delegate = self;
        
        //单击手势
        UITapGestureRecognizer *tapGusture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(beginEdit)];
        [self addGestureRecognizer:tapGusture];
        
        //添加下划线
        [self addUnderLine];
    }
    return self;
}

- (void)addUnderLine
{
    for (NSUInteger i = 0; i < _lineNumber; i++) {
        CAShapeLayer *line = [CAShapeLayer layer];
        line.frame = CGRectMake(Space * (2 *i + 1) + i * LineWidth, UnderLineCenterY - LineHeight/2, LineWidth, LineHeight);
        line.fillColor = _lineColor.CGColor;
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:line.bounds];
        line.path = path.CGPath;
        [self.layer addSublayer:line];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //画字
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (NSInteger i = 0; i < _textArray.count; i++) {
        NSString *num = _textArray[i];
        CGFloat wordWidth = [TQCommon widthForString:num fontSize:_textFont andHeight:_textFont.lineHeight];
        CGFloat startX = self.frame.size.width/_lineNumber * i + (self.frame.size.width/_lineNumber - wordWidth)/2;
        [num drawInRect:CGRectMake(startX, (self.frame.size.height - _textFont.lineHeight - LineBottomHeight - LineHeight)/2, wordWidth, _textFont.lineHeight + 5)
         withAttributes:@{NSFontAttributeName:_textFont,NSForegroundColorAttributeName:_lineColor}];
        
        CGContextDrawPath(context, kCGPathFill);
    }
}


#pragma mark - events

//开始编辑
- (void)beginEdit
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.hidden = YES;
        _textField.delegate = self;
        [self addSubview:_textField];
    }
    [self addNotification];
    [self.textField becomeFirstResponder];
}

//结束编辑
- (void)endEdit
{
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
    [self.textField resignFirstResponder];
}


#pragma mark - notification

- (void)addNotification
{
    if (observer) {
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }
    
    __weak typeof(self) weakSelf = self;
    observer = [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification
                                                                 object:nil
                                                                  queue:nil
                                                             usingBlock:^(NSNotification * _Nonnull note) {
                                                                 
                                                                 NSInteger length = weakSelf.textField.text.length;
                                                                 //更新textArray
                                                                 if (length > weakSelf.textArray.count) {
                                                                     [weakSelf.textArray addObject:[weakSelf.textField.text substringWithRange:NSMakeRange(weakSelf.textArray.count, 1)]];
                                                                 } else {
                                                                     [weakSelf.textArray removeLastObject];
                                                                 }
                                                                 //重绘
                                                                 [self setNeedsDisplay];
                                                                 
                                                                 //判断是否完成编辑
                                                                 if (length == weakSelf.lineNumber) {
                                                                     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                         [weakSelf endEdit];
                                                                     });
                                                                 }
                                                                 if (length > weakSelf.lineNumber) {
                                                                     weakSelf.textField.text = [weakSelf.textField.text substringToIndex:weakSelf.lineNumber];
                                                                     [weakSelf endEdit];
                                                                 }
                                                                 
                                                                 //回调
                                                                 if (weakSelf.EditBlock) {
                                                                     weakSelf.EditBlock(weakSelf.textField.text);
                                                                 }
                                                                 
                                                             }];
}


#pragma mark - textField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self endEdit];
}




@end
