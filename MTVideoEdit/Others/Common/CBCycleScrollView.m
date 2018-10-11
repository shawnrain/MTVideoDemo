//
//  CBCycleScrollView.m
//  weicou
//
//  Created by couba001 on 2017/4/14.
//  Copyright © 2017年 couba. All rights reserved.
//

#import "CBCycleScrollView.h"

@implementation CBCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.showPageControl = YES;
        
        //设置轮播视图分也控件的位置
        self.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//        self.currentPageDotImage = [UIImage imageNamed:@"home_cycle_red"];
//        self.pageDotImage = [UIImage imageNamed:@"home_cycle_white"];
        self.autoScrollTimeInterval = 2;
    }
    return self;
}

@end
