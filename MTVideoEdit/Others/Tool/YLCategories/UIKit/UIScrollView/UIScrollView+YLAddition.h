//
//  UIScrollView+YLAddition.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, YLScrollDirection) {
    YLScrollDirectionUp,
    YLScrollDirectionDown,
    YLScrollDirectionLeft,
    YLScrollDirectionRight,
    YLScrollDirectionWTF
};
@interface UIScrollView (YLAddition)
@property(nonatomic) CGFloat yl_contentWidth;
@property(nonatomic) CGFloat yl_contentHeight;
@property(nonatomic) CGFloat yl_contentOffsetX;
@property(nonatomic) CGFloat yl_contentOffsetY;

- (CGPoint)yl_topContentOffset;
- (CGPoint)yl_bottomContentOffset;
- (CGPoint)yl_leftContentOffset;
- (CGPoint)yl_rightContentOffset;

- (YLScrollDirection)yl_ScrollDirection;

- (BOOL)yl_isScrolledToTop;
- (BOOL)yl_isScrolledToBottom;
- (BOOL)yl_isScrolledToLeft;
- (BOOL)yl_isScrolledToRight;
- (void)yl_scrollToTopAnimated:(BOOL)animated;
- (void)yl_scrollToBottomAnimated:(BOOL)animated;
- (void)yl_scrollToLeftAnimated:(BOOL)animated;
- (void)yl_scrollToRightAnimated:(BOOL)animated;

- (NSUInteger)yl_verticalPageIndex;
- (NSUInteger)yl_horizontalPageIndex;

- (void)yl_scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;
- (void)yl_scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated;

@end
