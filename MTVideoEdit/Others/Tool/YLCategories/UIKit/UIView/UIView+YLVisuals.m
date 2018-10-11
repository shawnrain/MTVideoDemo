//
//  UIView+CornerRadius.m
//  OC-YL
//
//  Created by cy on 2018/5/24.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UIView+YLVisuals.h"
#import <objc/runtime.h>
static char YLCornerRadiusKey;
@implementation UIView (YLVisuals)
- (void)setYl_cornerRadius:(CGFloat)yl_cornerRadius
{
    objc_setAssociatedObject(self, &YLCornerRadiusKey, @(yl_cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self yl_roundedCornerWithRadius:yl_cornerRadius];
}

- (CGFloat)yl_cornerRadius
{
    return [objc_getAssociatedObject(self, &YLCornerRadiusKey) doubleValue];
}
- (void)yl_roundedCornerWithRadius:(CGFloat)radius
{
    [self yl_roundedCornerWithRadius:radius corners:UIRectCornerAllCorners];
}
- (void)yl_roundedCornerWithRadius:(CGFloat)radius corners:(UIRectCorner)corners
{
    UIBezierPath *maskPath  = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.layer.mask         = maskLayer;
}
- (void)yl_shadowWithColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius
{
    self.clipsToBounds          = NO;
    self.layer.shadowColor      = color.CGColor;
    self.layer.shadowOffset     = offset;
    self.layer.shadowOpacity    = opacity;
    self.layer.shadowRadius     = radius;
}
@end
