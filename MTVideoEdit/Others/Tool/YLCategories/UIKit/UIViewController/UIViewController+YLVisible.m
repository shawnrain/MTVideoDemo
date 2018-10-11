//
//  UIViewController+YLVisible.m
//  OC-YL
//
//  Created by melon on 2018/5/25.
//  Copyright © 2018年 melon. All rights reserved.
//

#import "UIViewController+YLVisible.h"

@implementation UIViewController (YLVisible)
- (BOOL)yl_isVisible
{
    return [self isViewLoaded] && self.view.window;
}
@end
