//
//  UIScrollView+YLAddition.m
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UIScrollView+YLAddition.h"

@implementation UIScrollView (YLAddition)

//@property(nonatomic) CGFloat yl_contentOffsetX;
//@property(nonatomic) CGFloat yl_contentOffsetY;
- (CGFloat)yl_contentWidth
{
    return self.contentSize.width;
}
- (void)setYl_contentWidth:(CGFloat)width
{
    self.contentSize = CGSizeMake(width, self.frame.size.height);
}
- (CGFloat)yl_contentHeight
{
    return self.contentSize.height;
}
- (void)setYl_contentHeight:(CGFloat)height
{
    self.contentSize = CGSizeMake(self.frame.size.width, height);
}
- (CGFloat)yl_contentOffsetX
{
    return self.contentOffset.x;
}
- (void)setYl_contentOffsetX:(CGFloat)x
{
    self.contentOffset = CGPointMake(x, self.contentOffset.y);
}
- (CGFloat)yl_contentOffsetY
{
    return self.contentOffset.y;
}
- (void)setYl_contentOffsetY:(CGFloat)y
{
     self.contentOffset = CGPointMake(self.contentOffset.x, y);
}



- (CGPoint)yl_topContentOffset
{
    return CGPointMake(0.0f, -self.contentInset.top);
}
- (CGPoint)yl_bottomContentOffset
{
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}
- (CGPoint)yl_leftContentOffset
{
    return CGPointMake(-self.contentInset.left, 0.0f);
}
- (CGPoint)yl_rightContentOffset
{
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}


- (YLScrollDirection)yl_ScrollDirection
{
    YLScrollDirection direction;
    if ([self.panGestureRecognizer translationInView:self.superview].y > 0.0f){
        direction = YLScrollDirectionUp;
    }
    else if ([self.panGestureRecognizer translationInView:self.superview].y < 0.0f){
        direction = YLScrollDirectionDown;
    }
    else if ([self.panGestureRecognizer translationInView:self].x < 0.0f){
        direction = YLScrollDirectionLeft;
    }
    else if ([self.panGestureRecognizer translationInView:self].x > 0.0f){
        direction = YLScrollDirectionRight;
    }
    else{
        direction = YLScrollDirectionWTF;
    }
    return direction;
}


- (BOOL)yl_isScrolledToTop
{
    return self.contentOffset.y <= [self yl_topContentOffset].y;
}
- (BOOL)yl_isScrolledToBottom
{
    return self.contentOffset.y >= [self yl_bottomContentOffset].y;
}
- (BOOL)yl_isScrolledToLeft
{
    return self.contentOffset.x <= [self yl_leftContentOffset].x;
}
- (BOOL)yl_isScrolledToRight
{
    return self.contentOffset.x >= [self yl_rightContentOffset].x;
}
- (void)yl_scrollToTopAnimated:(BOOL)animated
{
    [self setContentOffset:[self yl_topContentOffset] animated:animated];
}
- (void)yl_scrollToBottomAnimated:(BOOL)animated
{
    [self setContentOffset:[self yl_bottomContentOffset] animated:animated];
}
- (void)yl_scrollToLeftAnimated:(BOOL)animated
{
    [self setContentOffset:[self yl_leftContentOffset] animated:animated];
}
- (void)yl_scrollToRightAnimated:(BOOL)animated
{
    [self setContentOffset:[self yl_rightContentOffset] animated:animated];
}

- (NSUInteger)yl_verticalPageIndex
{
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}
- (NSUInteger)yl_horizontalPageIndex
{
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}


- (void)yl_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}
- (void)yl_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}
@end
