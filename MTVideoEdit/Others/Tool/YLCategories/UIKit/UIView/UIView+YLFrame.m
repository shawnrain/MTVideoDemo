//
//  UIView+YLFrame.m
//  DailyCategory
//
//  Created by melon on 2017/8/25.
//  Copyright © 2017年 cy. All rights reserved.
//

#import "UIView+YLFrame.h"

@implementation UIView (YLFrame)
-(void)setYl_x:(CGFloat)yl_x
{
    CGRect frame = self.frame;
    frame.origin.x = yl_x;
    self.frame = frame;
}

-(CGFloat)yl_x
{
    return self.frame.origin.x;
}



-(void)setYl_y:(CGFloat)yl_y
{
    CGRect frame = self.frame;
    frame.origin.y = yl_y ;
    self.frame = frame;
}
-(CGFloat)yl_y
{
    return self.frame.origin.y;
}



-(void)setYl_width:(CGFloat)yl_width
{
    CGRect frame = self.frame;
    frame.size.width = yl_width;
    self.frame = frame;
}
-(CGFloat)yl_width
{
    return self.frame.size.width;
}



-(void)setYl_height:(CGFloat)yl_height
{
    CGRect frame = self.frame;
    frame.size.height = yl_height;
    self.frame = frame;
}

-(CGFloat)yl_height
{
    return self.frame.size.height;
}



-(void)setYl_centerX:(CGFloat)yl_centerX
{
    CGPoint center = self.center;
    center.x = yl_centerX;
    self.center = center;
}
-(CGFloat)yl_centerX
{
    return self.center.x;
}



-(void)setYl_centerY:(CGFloat)yl_centerY
{
    CGPoint center = self.center;
    center.y = yl_centerY;
    self.center = center;
}
-(CGFloat)yl_centerY
{
    return self.center.y;
}



- (CGFloat)yl_left;
{
    return CGRectGetMinX(self.frame);
}
- (void)setYl_left:(CGFloat)yl_left
{
    CGRect frame = self.frame;
    frame.origin.x = yl_left;
    self.frame = frame;
}



- (CGFloat)yl_right
{
    return CGRectGetMaxX(self.frame);
}
- (void)setYl_right:(CGFloat)yl_right
{
    CGRect frame = self.frame;
    frame.origin.x = yl_right - frame.size.width;
    self.frame = frame;
}



- (CGFloat)yl_top;
{
    return CGRectGetMinY(self.frame);
}
- (void)setYl_top:(CGFloat)yl_top
{
    CGRect frame = self.frame;
    frame.origin.y = yl_top;
    self.frame = frame;
}



- (CGFloat)yl_bottom;
{
    return CGRectGetMaxY(self.frame);
}
- (void)setYl_bottom:(CGFloat)yl_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = yl_bottom - frame.size.height;
    self.frame = frame;
}


-(void)setYl_size:(CGSize)yl_size
{
    CGRect frame = self.frame;
    frame.size = yl_size;
    self.frame = frame;
}
-(CGSize)yl_size
{
    return self.frame.size;
}
@end
