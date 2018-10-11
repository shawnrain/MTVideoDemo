//
//  SPMyMessageViewController.h
//  shipingdiandian
//
//  Created by MTShawn on 2018/7/20.
//  Copyright © 2018年 MT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPMyMessageViewController : UIViewController

@end

@interface SPMyMessageTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel  * messageLabel;
@property (nonatomic, strong) UILabel  * timeLabel;
@end
