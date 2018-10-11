//
//  UIBarButtonItem+Button.h
//  weicou
//
//  Created by couba001 on 2017/4/13.
//  Copyright © 2017年 couba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Button)
+ (instancetype)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage targer:(id)target action:(SEL)action;


+ (instancetype)barButtonItemWithImage:(UIImage *)image selImage:(UIImage *)selImage targer:(id)target action:(SEL)action;

+ (instancetype)barButtonItemWithTltle:(NSString *)title font:(CGFloat)font tltleColor:(UIColor *)tltleColor targer:(id)target action:(SEL)action;

@end
