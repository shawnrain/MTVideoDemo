//
//  UITextField+YLInputLimit.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (YLInputLimit)
@property (assign, nonatomic)  NSInteger yl_maxLength;//if <=0, no limit
@end
