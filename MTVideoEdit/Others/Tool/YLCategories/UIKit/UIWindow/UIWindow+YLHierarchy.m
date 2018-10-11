//
//  UIWindow+YLHierarchy.m
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UIWindow+YLHierarchy.h"

@implementation UIWindow (YLHierarchy)
- (UIViewController *)yl_topMostController
{
    UIViewController *topController = [self rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])    topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}
- (UIViewController *)yl_currentViewController
{
    UIViewController *currentViewController = [self yl_topMostController];
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}
@end
