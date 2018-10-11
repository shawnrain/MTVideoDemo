//
//  UIView+YLFrame.h
//  DailyCategory
//
//  Created by melon on 2017/8/25.
//  Copyright © 2017年 cy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YLFrame)

@property (nonatomic, assign) CGFloat yl_x; /** origin.x */
@property (nonatomic, assign) CGFloat yl_y; /** origin.y */

@property (nonatomic, assign) CGFloat yl_width;   /** width */
@property (nonatomic, assign) CGFloat yl_height;  /** height */

@property (nonatomic, assign) CGFloat yl_centerX;  /** centerX */
@property (nonatomic, assign) CGFloat yl_centerY;  /** centerY */


@property (nonatomic, assign) CGFloat yl_left;    /** left */
@property (nonatomic, assign) CGFloat yl_right;   /** right */
@property (nonatomic, assign) CGFloat yl_top;     /** top */
@property (nonatomic, assign) CGFloat yl_bottom;  /** bottom */


@property (nonatomic, assign) CGSize yl_size;  /** size */
@end
