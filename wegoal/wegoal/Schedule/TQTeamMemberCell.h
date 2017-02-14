//
//  TQTeamMemberCell.h
//  wegoal
//
//  Created by joker on 2017/2/13.
//  Copyright © 2017年 xdkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TQTeamMemberCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewLeftConstraint;

@end
