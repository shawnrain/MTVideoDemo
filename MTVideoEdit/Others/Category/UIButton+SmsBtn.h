//
//  UIButton+SmsBtn.h
//  weicou
//
//  Created by couba001 on 2017/4/13.
//  Copyright © 2017年 couba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SmsBtn)

/**
 开始定时器BTN

 @param timeLine 时间
 @param mTitle 主标题
 @param countDownTitle 时间完之后标题
 @param mColor 主颜色
 @param countDownColor 时间完之后颜色
 */
- (void)cc_startTimer:(NSInteger)timeLine mTitle:(NSString *)mTitle countDownTitle:(NSString *)countDownTitle mColor:(UIColor *)mColor countDownColor:(UIColor *)countDownColor;

@end
