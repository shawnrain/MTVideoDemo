//
//  BaseNavigationController.m
//  KwaiUp
//
//  Created by melon on 2018/1/2.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UINavigationController+YLSlideNavigation.h"
#import <WRNavigationBar/WRNavigationBar.h>
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customBackImage = [UIImage imageNamed:@"返回-白色"];
    self.hideBottomLine = YES;
    [self yl_enableFullScreenGesture:0];
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:[UIColor navColor]];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor naviTitleColor]];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor naviTitleColor]];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



@end
