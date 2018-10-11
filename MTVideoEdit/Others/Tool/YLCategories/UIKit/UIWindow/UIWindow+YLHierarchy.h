//
//  UIWindow+YLHierarchy.h
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (YLHierarchy)

/**
 topMostController

 @return Returns the current Top Most ViewController in hierarchy.
 */
- (UIViewController*)yl_topMostController;

/**
 currentViewController

 @return Returns the topViewController in stack of topMostController.
 */
- (UIViewController*)yl_currentViewController;
@end
