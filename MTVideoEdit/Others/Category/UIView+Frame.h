//
//  UIView+Frame.h
//
//  Created by sho yakushiji on 2013/05/15.
//  Copyright (c) 2013年 CALACULU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
//外部中心
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

//内部中心
@property (nonatomic, assign) CGFloat centerx;
@property (nonatomic, assign) CGFloat centery;

+ (instancetype)viewFromXib;
@end
