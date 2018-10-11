//
//  YLGradientProgressView.h
//  KwaiUp
//
//  Created by melon on 2018/1/28.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLGradientProgressView : UIView
/**
 *  进度条背景颜色  默认是 EDEDED  237 237 237
 */
@property (nonatomic, strong) UIColor *bgProgressColor;

/**
 *  进度条渐变颜色数组，颜色个数>=2
 *  默认是 @[(id)YLRGBColor(252, 244, 77).CGColor,(id)YLRGBColor(252, 93, 59).CGColor]
 */
@property (nonatomic, strong) NSArray *colorArr;

/**
 *  进度 默认是0.65
 */
@property (nonatomic, assign) CGFloat progress;


@end
