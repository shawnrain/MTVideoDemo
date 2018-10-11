//
//  UIView+Frame.m
//
//  Created by sho yakushiji on 2013/05/15.
//  Copyright (c) 2013年 CALACULU. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setSize:(CGSize)size;
{
    CGPoint origin = [self frame].origin;
    
    [self setFrame:CGRectMake(origin.x, origin.y, size.width, size.height)];
}

- (CGSize)size;
{
    return [self frame].size;
}
- (CGPoint)origin;
{
    CGRect frame = [self frame];
    return CGPointMake(frame.origin.x, frame.origin.y);
}

- (void)setOrigin:(CGPoint)point;
{
    CGRect frame = [self frame];
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    [self setFrame:CGRectStandardize(frame)];
}
- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)centerX;
{
    return [self center].x;
}

- (void)setCenterX:(CGFloat)centerX;
{
    [self setCenter:CGPointMake(centerX, self.center.y)];
}

- (CGFloat)centerY;
{
    return [self center].y;
}

- (void)setCenterY:(CGFloat)centerY;
{
    [self setCenter:CGPointMake(self.center.x, centerY)];
}

- (CGFloat)centerx;
{
    return self.width/2;
}

- (void)setCenterx:(CGFloat)centerx;
{
    self.centerX  =self.superview.width/2;
}

- (CGFloat)centery;
{
    return self.height/2;
}

- (void)setCentery:(CGFloat)centery;
{
    self.centerY  = self.superview.height/2;
}
+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil].firstObject;
}

@end
