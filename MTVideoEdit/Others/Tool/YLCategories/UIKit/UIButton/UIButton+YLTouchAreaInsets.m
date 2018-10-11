//
//  UIButton+YLTouchAreaInsets.m
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UIButton+YLTouchAreaInsets.h"
#import <objc/runtime.h>
@implementation UIButton (YLTouchAreaInsets)
- (UIEdgeInsets)yl_touchAreaInsets
{
    return [objc_getAssociatedObject(self, @selector(yl_touchAreaInsets)) UIEdgeInsetsValue];
}

- (void)setYl_touchAreaInsets:(UIEdgeInsets)yl_touchAreaInsets
{
    NSValue *value = [NSValue valueWithUIEdgeInsets:yl_touchAreaInsets];
    objc_setAssociatedObject(self, @selector(yl_touchAreaInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    UIEdgeInsets touchAreaInsets = self.yl_touchAreaInsets;
    CGRect bounds = self.bounds;
    bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                        bounds.origin.y - touchAreaInsets.top,
                        bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                        bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
    return CGRectContainsPoint(bounds, point);
}
@end
