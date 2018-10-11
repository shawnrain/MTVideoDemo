//
//  UIView+YLBlockGesture.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^YLGestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);
@interface UIView (YLBlockGesture)

/**
 添加tap手势

 @param block 代码块
 */
- (void)yl_addTapActionWithBlock:(YLGestureActionBlock)block;

/**
 添加长按手势

 @param block 代码块
 */
- (void)yl_addLongPressActionWithBlock:(YLGestureActionBlock)block;
@end
