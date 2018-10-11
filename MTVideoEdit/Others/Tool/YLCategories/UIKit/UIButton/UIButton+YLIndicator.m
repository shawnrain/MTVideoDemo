//
//  UIButton+YLIndicator.m
//  OC-YL
//
//  Created by melon on 2018/6/29.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UIButton+YLIndicator.h"
#import <objc/runtime.h>


static NSString *const yl_IndicatorViewKey = @"indicatorView";
static NSString *const yl_ButtonTextObjectKey = @"buttonTextObject";

@implementation UIButton (YLIndicator)
- (void)yl_showIndicator
{
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, &yl_IndicatorViewKey);
    if (!indicator) {
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        indicator.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [indicator startAnimating];
    }
    NSString *currentButtonText = self.titleLabel.text;
    objc_setAssociatedObject(self, &yl_ButtonTextObjectKey, currentButtonText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &yl_IndicatorViewKey, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTitle:@"" forState:UIControlStateNormal];
    self.enabled = NO;
    [self addSubview:indicator];
}

- (void)yl_hideIndicator
{
    NSString *currentButtonText = (NSString *)objc_getAssociatedObject(self, &yl_ButtonTextObjectKey);
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)objc_getAssociatedObject(self, &yl_IndicatorViewKey);
    
    [indicator removeFromSuperview];
    [self setTitle:currentButtonText forState:UIControlStateNormal];
    self.enabled = YES;
}
@end
