//
//  MTWaterView.m
//  MTVideoEditDemo
//
//  Created by MTShawn on 2018/8/1.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "MTWaterView.h"

@implementation MTWaterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
