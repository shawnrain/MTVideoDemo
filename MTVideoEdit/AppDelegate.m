//
//  AppDelegate.m
//  MTVideoEdit
//
//  Created by MTShawn on 2018/9/17.
//  Copyright © 2018年 MT. All rights reserved.
//

#import "AppDelegate.h"
#import "MTHomeViewController.h"
#import "MTMineViewController.h"
#import <CYLTabBarController/CYLTabBarController.h>
#import "BaseNavigationController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setReviewsControl];
    return YES;
}
- (void)setReviewsControl{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kIsReviewKey];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    
    tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    NSDictionary *home = @{
                           CYLTabBarItemTitle : @"首页",
                           CYLTabBarItemImage : @"首页-未点击",
                           CYLTabBarItemSelectedImage : @"首页-点击",
                           };
    NSDictionary * mine =  @{
                             CYLTabBarItemTitle : @"我的",
                             CYLTabBarItemImage : @"我的-未点击",
                             CYLTabBarItemSelectedImage : @"我的点击",
                             };
    
    BaseNavigationController * homeNavi =  [[BaseNavigationController alloc] initWithRootViewController:[[MTHomeViewController alloc]init]];
    BaseNavigationController * mainNavi = [[BaseNavigationController alloc] initWithRootViewController:[[MTMineViewController alloc]init]];
    tabBarController.tabBarItemsAttributes= @[home,mine];
    tabBarController.viewControllers = @[homeNavi,mainNavi];
    [self customizeTabBarAppearance:tabBarController];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyWindow];
}
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController
{
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = color999999;
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = colorFF687F;
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
