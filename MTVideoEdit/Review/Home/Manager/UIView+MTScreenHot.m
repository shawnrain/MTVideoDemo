//
//  UIView+MTScreenHot.m
//  wanghong
//
//  Created by MTShawn on 2018/9/13.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "UIView+MTScreenHot.h"

@implementation UIView (MTScreenHot)
//截图
- (UIImage *)generateImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  snapshotImageFromMyView;
}
@end
