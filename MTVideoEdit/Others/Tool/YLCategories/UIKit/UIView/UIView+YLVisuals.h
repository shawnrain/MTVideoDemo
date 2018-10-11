//
//  UIView+CornerRadius.h
//  OC-YL
//
//  Created by cy on 2018/5/24.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YLVisuals)

@property (nonatomic, assign) CGFloat yl_cornerRadius;/** 圆角半径  */
/**
 所有角切圆

 @param radius 圆角半径
 */
- (void)yl_roundedCornerWithRadius:(CGFloat)radius;

/**
 切圆

 @param radius 圆角半径
 @param corners 哪一个角
 */
- (void)yl_roundedCornerWithRadius:(CGFloat)radius
                           corners:(UIRectCorner)corners;


/**
 添加阴影

 @param color 颜色
 @param offset 偏移量
 @param opacity 不透明度
 @param radius 半径
 */
- (void)yl_shadowWithColor:(UIColor *)color
                    offset:(CGSize)offset
                   opacity:(CGFloat)opacity
                    radius:(CGFloat)radius;

@end
